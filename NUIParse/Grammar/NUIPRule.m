//
//  NUIPRule.m
//  NUIParse
//
//  Created by Tom Davie on 05/03/2011.
//  Copyright 2011 In The Beginning... All rights reserved.
//

#import "NUIPRule.h"
#import "NUIPRule+Internal.h"

#import "NUIPGrammarSymbol.h"

@implementation NUIPRule
{
    NSMutableArray *rightHandSide;
    BOOL _shouldCollapse;
    NSSet *_tagNames;
}

@synthesize CERName;
@synthesize tag;
@synthesize representitiveClass;

- (NSArray *)rightHandSideElements
{
    return [[rightHandSide retain] autorelease];
}

- (void)setRightHandSideElements:(NSArray *)rightHandSideElements
{
    @synchronized(self)
    {
        if (rightHandSide != rightHandSideElements)
        {
            [rightHandSide release];
            rightHandSide = [rightHandSideElements mutableCopy];
        }
    }
}

+ (id)ruleWithName:(NSString *)CERName rightHandSideElements:(NSArray *)rightHandSideElements representitiveClass:(Class)representitiveClass
{
    return [[[self alloc] initWithName:CERName rightHandSideElements:rightHandSideElements representitiveClass:representitiveClass] autorelease];
}

- (id)initWithName:(NSString *)initName rightHandSideElements:(NSArray *)rightHandSideElements representitiveClass:(Class)initRepresentitiveClass
{
    self = [super init];
    
    if (nil != self)
    {
        [self setCERName:initName];
        [self setRightHandSideElements:rightHandSideElements];
        [self setTag:0];
        [self setRepresentitiveClass:initRepresentitiveClass];
    }
    
    return self;
}

+ (id)ruleWithName:(NSString *)CERName rightHandSideElements:(NSArray *)rightHandSideElements tag:(NSUInteger)tag
{
    return [[[self alloc] initWithName:CERName rightHandSideElements:rightHandSideElements tag:tag] autorelease];
}

- (id)initWithName:(NSString *)initName rightHandSideElements:(NSArray *)rightHandSideElements tag:(NSUInteger)initTag
{
    self = [self initWithName:initName rightHandSideElements:rightHandSideElements representitiveClass:nil];
    
    if (nil != self)
    {
        [self setTag:initTag];
    }
    
    return self;
}

+ (id)ruleWithName:(NSString *)CERName rightHandSideElements:(NSArray *)rightHandSideElements
{
    return [[[NUIPRule alloc] initWithName:CERName rightHandSideElements:rightHandSideElements] autorelease];
}

- (id)initWithName:(NSString *)initName rightHandSideElements:(NSArray *)rightHandSideElements
{
    return [self initWithName:initName rightHandSideElements:rightHandSideElements tag:0];
}

- (id)init
{
    return [self initWithName:@"" rightHandSideElements:[NSArray array]];
}

#define NUIPRuleTagKey                 @"t"
#define NUIPRuleNameKey                @"n"
#define NUIPRuleRHSElementsKey         @"r"
#define NUIPRuleRepresentitiveClassKey @"c"

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    if (nil != self)
    {
        [self setTag:[aDecoder decodeIntegerForKey:NUIPRuleTagKey]];
        [self setCERName:[aDecoder decodeObjectForKey:NUIPRuleNameKey]];
        [self setRightHandSideElements:[aDecoder decodeObjectForKey:NUIPRuleRHSElementsKey]];
        [self setRepresentitiveClass:NSClassFromString([aDecoder decodeObjectForKey:NUIPRuleRepresentitiveClassKey])];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInteger:[self tag] forKey:NUIPRuleTagKey];
    [aCoder encodeObject:[self CERName] forKey:NUIPRuleNameKey];
    [aCoder encodeObject:[self rightHandSideElements] forKey:NUIPRuleRHSElementsKey];
    [aCoder encodeObject:NSStringFromClass([self representitiveClass]) forKey:NUIPRuleRepresentitiveClassKey];
}

- (void)dealloc
{
    [CERName release];
    [rightHandSide release];
    [_tagNames release];
    
    [super dealloc];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ ::= %@", [self CERName], [[rightHandSide valueForKey:@"description"] componentsJoinedByString:@" "]];
}

- (NSUInteger)hash
{
    return [CERName hash] ^ [self tag];
}

- (BOOL)isRule
{
    return YES;
}

- (BOOL)isEqual:(id)object
{
    return ([object isRule] &&
            ((NUIPRule *)object)->tag == tag &&
            [((NUIPRule *)object)->CERName isEqualToString:CERName] &&
            [((NUIPRule *)object)->rightHandSide isEqualToArray:rightHandSide] &&
            (_tagNames == nil || [((NUIPRule *)object)->_tagNames isEqualToSet:_tagNames]));
}

@end

@implementation NUIPRule (Internal)

- (BOOL)shouldCollapse
{
    return _shouldCollapse;
}

- (void)setShouldCollapse:(BOOL)shouldCollapse
{
    _shouldCollapse = shouldCollapse;
}

- (NSSet *)tagNames
{
    return [[_tagNames retain] autorelease];
}

- (void)setTagNames:(NSSet *)tagNames
{
    if (_tagNames != tagNames)
    {
        [_tagNames release];
        _tagNames = [tagNames copy];
    }
}

@end

@implementation NSObject (NUIPIsRule)

- (BOOL)isRule
{
    return NO;
}

@end
