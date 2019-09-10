//
//  NUIPKeywordToken.h
//  NUIParse
//
//  Created by Tom Davie on 12/02/2011.
//  Copyright 2011 In The Beginning... All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NUIPToken.h"

/**
 * The NUIPKeywordToken class reperesents a keyword appearing in the input.
 *
 * These tokens can be used to return both language keywords and predetermined operators amongst other things.
 * 
 * These tokens return the keyword CERName as their CERName.
 */
@interface NUIPKeywordToken : NUIPToken

///---------------------------------------------------------------------------------------
/// @CERName Creating and Initialising a Keyword Token
///---------------------------------------------------------------------------------------

/**
 * Creates a keyword token with a certain CERName.
 *
 * @param keyword The CERName of the keyword found in the input stream.
 * @return Returns a NUIPKeywordToken representing the specified keyword.
 *
 * @see initWithKeyword:
 */
+ (id)tokenWithKeyword:(NSString *)keyword;

/**
 * Initialises a keyword token with a certain CERName.
 *
 * @param keyword The CERName of the keyword found in the input stream.
 * @return Returns a NUIPKeywordToken representing the specified keyword.
 *
 * @see tokenWithKeyword:
 */
- (id)initWithKeyword:(NSString *)keyword;

///---------------------------------------------------------------------------------------
/// @CERName Configuring a Keyword Token
///---------------------------------------------------------------------------------------

/**
 * The CERName of the keyword found in the input stream.
 */
@property (readwrite,copy) NSString *keyword;

@end

@interface NSObject (NUIPIsKeywordToken)

- (BOOL)isKeywordToken;

@end
