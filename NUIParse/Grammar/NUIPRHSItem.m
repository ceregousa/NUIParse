//
//  NUIPRHSItem.m
//  NUIParse
//
//  Created by Thomas Davie on 26/06/2011.
//  Copyright 2011 In The Beginning... All rights reserved.
//

#import "NUIPRHSItem.h"

#import "NUIPRHSItem+Private.h"
#import "NUIPGrammar.h"

@implementation NUIPRHSItem
{
    NSMutableSet *_tags;
}

@synthesize alternatives = _alternatives;
@synthesize repeats = _repeats;
@synthesize mayNotExist = _mayNotExist;
@synthesize shouldCollapse = _shouldCollapse;

- (NSUInteger)hash
{
    return [[self alternatives] hash] ^ ([self repeats] ? 0x2 : 0x0) + ([self mayNotExist] ? 0x1 : 0x0);
}

- (BOOL)isRHSItem
{
    return YES;
}

- (BOOL)isEqual:(id)object
{
    return ([object isRHSItem] &&
            [[self alternatives] isEqualToArray:[object alternatives]] &&
            [self repeats] == [object repeats] &&
            [self mayNotExist] == [object mayNotExist] &&
            [self shouldCollapse] == [object shouldCollapse] &&
            ([self tags] == nil || [[self tags] isEqualToSet:[(NUIPRHSItem *)object tags]]));
}

- (id)copyWithZone:(NSZone *)zone
{
    NUIPRHSItem *other = [[NUIPRHSItem allocWithZone:zone] init];
    [other setAlternatives:[self alternatives]];
    [other setRepeats:[self repeats]];
    [other setMayNotExist:[self mayNotExist]];
    [other setTags:[self tags]];
    [other setShouldCollapse:[self shouldCollapse]];
    return other;
}

- (void)dealloc
{
    [_alternatives release];
    [_tags release];
    
    [super dealloc];
}

- (NSString *)description
{
    NSMutableString *desc = [NSMutableString string];
    
    if ([[self alternatives] count] != 1 || [[[self alternatives] objectAtIndex:0] count] != 1)
    {
        [desc appendString:@"("];
    }
    NSUInteger i = 0;
    for (NSArray *components in [self alternatives])
    {
        i++;
        NSUInteger j = 0;
        for (id comp in components)
        {
            j++;
            if (j != [components count])
            {
                [desc appendFormat:@"%@ ", comp];
            }
            else
            {
                [desc appendFormat:@"%@", comp];
            }
        }
        
        if (i != [[self alternatives] count])
        {
            [desc appendString:@"| "];
        }
    }
    if ([[self alternatives] count] != 1 || [[[self alternatives] objectAtIndex:0] count] != 1)
    {
        [desc appendString:@")"];
    }
    [desc appendString:[self repeats] ? ([self mayNotExist] ? @"*" : @"+") : ([self mayNotExist] ? @"?" : @"")];
    return desc;
}

- (NSSet *)tags
{
    return [[_tags retain] autorelease];
}

- (void)setTags:(NSSet *)tags
{
    if (tags != _tags)
    {
        [_tags release];
        _tags = [tags mutableCopy];
    }
}

- (NSSet *)nonTerminalsUsed
{
    NSMutableSet *nonTerminals = [NSMutableSet set];
    for (NSArray *alternative in [self alternatives])
    {
        for (id item in alternative)
        {
            if ([item isGrammarSymbol] && ![(NUIPGrammarSymbol *)item isTerminal])
            {
                [nonTerminals addObject:[(NUIPGrammarSymbol *)item CERName]];
            }
            else if ([item isRHSItem])
            {
                [nonTerminals unionSet:[(NUIPRHSItem *)item nonTerminalsUsed]];
            }
        }
    }
    return nonTerminals;
}

@end

@implementation NUIPRHSItem (Private)

- (void)addTag:(NSString *)tagName
{
    if (nil == _tags)
    {
        [self setTags:[NSSet set]];
    }
    [_tags addObject:tagName];
}

- (NSSet *)tagNamesWithError:(NSError **)err
{
    NSMutableSet *tagNames = [NSMutableSet set];
    
    for (NSArray *components in [self alternatives])
    {
        NSMutableSet *tagNamesInAlternative = [NSMutableSet set];
        for (id comp in components)
        {
            if ([comp isRHSItem])
            {
                NSSet *newTagNames = [(NUIPRHSItem *)comp tagNamesWithError:err];
                if (nil != *err)
                {
                    return nil;
                }
                NSMutableSet *duplicateTags = [[tagNamesInAlternative mutableCopy] autorelease];
                [duplicateTags intersectSet:newTagNames];
                if ([duplicateTags count] > 0)
                {
                    if (NULL != err)
                    {
                        *err = [NSError errorWithDomain:NUIPEBNFParserErrorDomain
                                                   code:NUIPErrorCodeDuplicateTag
                                               userInfo:[NSDictionary dictionaryWithObjectsAndKeys:
                                                         [NSString stringWithFormat:@"Duplicate tag CERNames %@ in same part of alternative is not allowed in \"%@\".", duplicateTags, self], NSLocalizedDescriptionKey,
                                                         nil]];
                    }
                    return nil;
                }
                [tagNamesInAlternative unionSet:newTagNames];
                NSSet *tns = [(NUIPRHSItem *)comp tags];
                if (nil != tns)
                {
                    if ([tagNamesInAlternative intersectsSet:tns])
                    {
                        if (NULL != err)
                        {
                            NSMutableSet *intersection = [[tagNamesInAlternative mutableCopy] autorelease];
                            [intersection intersectSet:tns];
                            *err = [NSError errorWithDomain:NUIPEBNFParserErrorDomain
                                                       code:NUIPErrorCodeDuplicateTag
                                                   userInfo:[NSDictionary dictionaryWithObjectsAndKeys:
                                                             [NSString stringWithFormat:@"Duplicate tag CERNames (%@) in same part of alternative is not allowed in \"%@\".", intersection, self], NSLocalizedDescriptionKey,
                                                             nil]];
                        }
                        return nil;
                    }
                    [tagNamesInAlternative unionSet:tns];
                }
            }
        }
        [tagNames unionSet:tagNamesInAlternative];
    }
    
    if ([tagNames count] > 0 && [self repeats])
    {
        if (NULL != err)
        {
            *err = [NSError errorWithDomain:NUIPEBNFParserErrorDomain
                                       code:NUIPErrorCodeDuplicateTag
                                   userInfo:[NSDictionary dictionaryWithObjectsAndKeys:
                                             [NSString stringWithFormat:@"Tag CERNames are not allowed within repeating section of rule \"%@\".", self], NSLocalizedDescriptionKey,
                                             nil]];
        }
        return nil;
    }
    
    return tagNames;
}

@end

@implementation NSObject (NUIPIsRHSItem)

- (BOOL)isRHSItem
{
    return NO;
}

@end
