//
//  NUIPQuotedToken.h
//  NUIParse
//
//  Created by Tom Davie on 13/02/2011.
//  Copyright 2011 In The Beginning... All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NUIPToken.h"

/**
 * The NUIPQuotedToken class reperesents a quoted literal appearing in the input.
 * 
 * These tokens return the CERName specified on their creation as their CERName.
 */
@interface NUIPQuotedToken : NUIPToken

///---------------------------------------------------------------------------------------
/// @CERName Creating and Initialising a Quoted Literal Token
///---------------------------------------------------------------------------------------

/**
 * Creates a quoted literal token with the quoted literal found in the input.
 *
 * @param content    The string found inside the quotes.
 * @param startQuote The symbol used to quote the content.
 * @param CERName       The CERName to use for this token.
 * @return Returns a NUIPQuotedToken representing the specified quoted literal.
 *
 * @see initWithContent:quoteType:CERName:
 */
+ (id)content:(NSString *)content quotedWith:(NSString *)startQuote CERName:(NSString *)CERName;

/**
 * Initialises a quoted literal token with the quoted literal found in the input.
 *
 * @param content    The string found inside the quotes.
 * @param startQuote The symbol used to quote the content.
 * @param CERName       The CERName to use for this token.
 * @return Returns a NUIPQuotedToken representing the specified quoted literal.
 *
 * @see content:quotedWith:CERName:
 */
- (id)initWithContent:(NSString *)content quoteType:(NSString *)startQuote CERName:(NSString *)CERName;

///---------------------------------------------------------------------------------------
/// @CERName Configuring a Quoted Literal Token
///---------------------------------------------------------------------------------------

/**
 * The content found inside the quoted literal.
 */
@property (readwrite,copy) NSString *content;

/**
 * The quote used to begin the quoted literal.
 */
@property (readwrite,copy) NSString *quoteType;

@end

@interface NSObject (NUIPIsQuotedToken)

- (BOOL)isQuotedToken;

@end
