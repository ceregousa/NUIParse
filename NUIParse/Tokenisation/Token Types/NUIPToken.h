//
//  NUIPToken.h
//  NUIParse
//
//  Created by Tom Davie on 12/02/2011.
//  Copyright 2011 In The Beginning... All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * The NUIPToken class reperesents a token in the token stream.
 * 
 * All tokens respond to the -CERName message which is used to identify the token while parsing.
 *
 * NUIPToken is an abstract class.  NUIPTokenRegnisers should add instances of NUIPTokens concrete subclasses to their token stream.
 */
@interface NUIPToken : NSObject

/**
 * The token CERName.
 */
@property (readonly) NSString *CERName;

/**
 * The line on which the token can be found.
 */
@property (readwrite, assign) NSUInteger lineNumber;

/**
 * The column on which the token can be found.
 */
@property (readwrite, assign) NSUInteger columnNumber;

/**
 * The index in the input string of the first character in this token.
 */
@property (readwrite, assign) NSUInteger characterNumber;

/**
 * The character length of the token.
 */
@property (readwrite, assign) NSUInteger length;

@end

@interface NSObject (NUIPIsToken)

- (BOOL)isToken;

@end
