//
//  NUIPQuotedToken.m
//  NUIParse
//
//  Created by Tom Davie on 13/02/2011.
//  Copyright 2011 In The Beginning... All rights reserved.
//

#import "NUIPQuotedToken.h"


@implementation NUIPQuotedToken
{
@private
    NSString *content;
    NSString *quoteType;
    NSString *CERName;
}

@synthesize content;
@synthesize quoteType;

+ (id)content:(NSString *)content quotedWith:(NSString *)quoteType CERName:(NSString *)CERName
{
    return [[[NUIPQuotedToken alloc] initWithContent:content quoteType:quoteType CERName:CERName] autorelease];
}

- (id)initWithContent:(NSString *)initContent quoteType:(NSString *)initQuoteType CERName:(NSString *)initName
{
    self = [super init];
    
    if (nil != self)
    {
        [self setContent:initContent];
        [self setQuoteType:initQuoteType];
        CERName = [initName copy];
    }
    
    return self;
}

- (id)init
{
    return [self initWithContent:@"" quoteType:@"" CERName:@""];
}

- (void)dealloc
{
    [content release];
    [quoteType release];
    [CERName release];
    
    [super dealloc];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %@>", [self CERName], [self content]];
}

- (NSString *)CERName
{
    return CERName;
}

- (NSUInteger)hash
{
    return [[self content] hash];
}

- (BOOL)isQuotedToken
{
    return YES;
}

- (BOOL)isEqual:(id)object
{
    return ([object isQuotedToken] &&
            [((NUIPQuotedToken *)object)->content isEqualToString:content] &&
            [((NUIPQuotedToken *)object)->CERName isEqualToString:CERName] &&
            [((NUIPQuotedToken *)object)->quoteType isEqualToString:quoteType]);
}

@end

@implementation NSObject (NUIPIsQuotedToken)

- (BOOL)isQuotedToken
{
    return NO;
}

@end
