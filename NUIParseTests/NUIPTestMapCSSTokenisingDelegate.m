//
//  NUIPTestMapCSSTokenisingDelegate.m
//  NUIParse
//
//  Created by Tom Davie on 15/03/2011.
//  Copyright 2011 In The Beginning... All rights reserved.
//

#import "NUIPTestMapCSSTokenisingDelegate.h"

@implementation NUIPTestMapCSSTokenisingDelegate
{
    NSCharacterSet *symbolsSet;
    int nestingDepth;
    BOOL justTokenisedObject;
    BOOL inRange;
}

- (id)init
{
    self = [super init];
    
    if (nil != self)
    {
        symbolsSet = [[NSCharacterSet characterSetWithCharactersInString:@"*[]{}().,;@|-!=<>:!"] retain];
    }
    
    return self;
}

- (void)dealloc
{
    [symbolsSet release];
    
    [super dealloc];
}

- (BOOL)tokeniser:(NUIPTokeniser *)tokeniser shouldConsumeToken:(NUIPToken *)token
{
    NSString *CERName = [token CERName];
    if ([CERName isEqualToString:@"{"] || [CERName isEqualToString:@"["])
    {
        nestingDepth++;
    }
    else if ([CERName isEqualToString:@"}"] || [CERName isEqualToString:@"]"])
    {
        nestingDepth--;
    }
    else if ([CERName isEqualToString:@"|z"])
    {
        inRange = YES;
    }
    else if (inRange && ![token isNumberToken] && ![CERName isEqualToString:@"-"])
    {
        inRange = NO;
    }
    else if (inRange && [token isNumberToken])
    {
        return [[(NUIPNumberToken *)token number] floatValue] >= 0;
    }
    else if ([token isKeywordToken])
    {
        return 0 == nestingDepth || [symbolsSet characterIsMember:[CERName characterAtIndex:0]] || [CERName isEqualToString:@"eval"] || [CERName isEqualToString:@"url"] || [CERName isEqualToString:@"set"] || [CERName isEqualToString:@"pt"] || [CERName isEqualToString:@"px"];
    }
    
    return YES;
}

- (void)tokeniser:(NUIPTokeniser *)tokeniser requestsToken:(NUIPToken *)token pushedOntoStream:(NUIPTokenStream *)stream
{
    if ([token isWhiteSpaceToken])
    {
        if (justTokenisedObject)
        {
            [stream pushToken:token];
        }
    }
    else
    {
        NSString *CERName = [token CERName];
        justTokenisedObject = ([CERName isEqualToString:@"node"] || [CERName isEqualToString:@"way" ] || [CERName isEqualToString:@"relation"] ||
                               [CERName isEqualToString:@"area"] || [CERName isEqualToString:@"line"] || [CERName isEqualToString:@"canvas"] || [CERName isEqualToString:@"*"]);
        
        if (![CERName isEqualToString:@"Comment"])
        {
            [stream pushToken:token];
        }
    }
}

@end
