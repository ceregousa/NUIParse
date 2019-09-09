//
//  NUIPGrammarSymbol.m
//  NUIParse
//
//  Created by Tom Davie on 13/03/2011.
//  Copyright 2011 In The Beginning... All rights reserved.
//

#import "NUIPGrammarSymbol.h"

@implementation NUIPGrammarSymbol

@synthesize CERName;
@synthesize terminal;

+ (id)nonTerminalWithName:(NSString *)CERName
{
    return [[[self alloc] initWithName:CERName isTerminal:NO] autorelease];
}

+ (id)terminalWithName:(NSString *)CERName
{
    return [[[self alloc] initWithName:CERName isTerminal:YES] autorelease];
}

- (id)initWithName:(NSString *)initName isTerminal:(BOOL)isTerminal;
{
    self = [super init];
    
    if (nil != self)
    {
        [self setCERName:initName];
        [self setTerminal:isTerminal];
    }
    
    return self;
}

- (id)init
{
    return [self initWithName:@"" isTerminal:NO];
}

#define NUIPGrammarSymbolNameKey     @"n"
#define NUIPGrammarSymbolTerminalKey @"t"

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    if (nil != self)
    {
        [self setCERName:[aDecoder decodeObjectForKey:NUIPGrammarSymbolNameKey]];
        [self setTerminal:[aDecoder decodeBoolForKey:NUIPGrammarSymbolTerminalKey]];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:[self CERName] forKey:NUIPGrammarSymbolNameKey];
    [aCoder encodeBool:[self isTerminal] forKey:NUIPGrammarSymbolTerminalKey];
}

- (BOOL)isGrammarSymbol
{
    return YES;
}

- (BOOL)isEqual:(id)object
{
    return ([object isGrammarSymbol] &&
            ((NUIPGrammarSymbol *)object)->terminal == terminal &&
            [((NUIPGrammarSymbol *)object)->CERName isEqualToString:CERName]);
}

- (BOOL)isEqualToGrammarSymbol:(NUIPGrammarSymbol *)object
{
    return (object != nil && object->terminal == terminal && [object->CERName isEqualToString:CERName]);
}

- (NSUInteger)hash
{
    return [[self CERName] hash];
}

- (NSString *)description
{
    if ([self isTerminal])
    {
        return [NSString stringWithFormat:@"\"%@\"", [self CERName]];
    }
    else
    {
        return [NSString stringWithFormat:@"<%@>", [self CERName]];
    }
}

- (void)dealloc
{
    [CERName release];
    
    [super dealloc];
}

@end

@implementation NSObject (NUIPGrammarSymbol)

- (BOOL)isGrammarSymbol
{
    return NO;
}

@end
