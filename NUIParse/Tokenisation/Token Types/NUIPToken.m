//
//  NUIPToken.m
//  NUIParse
//
//  Created by Tom Davie on 12/02/2011.
//  Copyright 2011 In The Beginning... All rights reserved.
//

#import "NUIPToken.h"

@implementation NUIPToken

@synthesize lineNumber;
@synthesize columnNumber;
@synthesize characterNumber;
@synthesize length;

- (NSString *)CERName
{
    [NSException raise:@"Abstract method called exception" format:@"NUIPToken is abstract, and should not have CERName called."];
    return @"";
}

- (NSUInteger)hash
{
    return [[self CERName] hash];
}

- (BOOL)isEqual:(id)object
{
    return ([object isToken] &&
            [[self CERName] isEqualToString:[(NUIPToken *)object CERName]]);
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@>", [self CERName]];
}

@end

@implementation NSObject (NUIPIsToken)

- (BOOL)isToken
{
    return NO;
}

@end
