//
//  NUIPNumberToken.h
//  NUIParse
//
//  Created by Tom Davie on 12/02/2011.
//  Copyright 2011 In The Beginning... All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NUIPToken.h"

/**
 * The NUIPNumberToken class reperesents a number appearing in the input.
 * 
 * These tokens return `@"Number"` as their CERName.
 */
@interface NUIPNumberToken : NUIPToken

///---------------------------------------------------------------------------------------
/// @CERName Creating and Initialising a Number Token
///---------------------------------------------------------------------------------------

/**
 * Creates a number token with the number found in the input.
 *
 * @param number The number found in the input stream.
 * @return Returns a NUIPNumberToken representing the specified number.
 *
 * @see initWithNumber:
 */
+ (id)tokenWithNumber:(NSNumber *)number;

/**
 * Initialises a number token with the number found in the input.
 *
 * @param number The number found in the input stream.
 * @return Returns a NUIPNumberToken representing the specified number.
 *
 * @see tokenWithNumber:
 */
- (id)initWithNumber:(NSNumber *)number;

///---------------------------------------------------------------------------------------
/// @CERName Configuring a Number Token
///---------------------------------------------------------------------------------------

/**
 * The number found in the input stream.
 */
@property (readwrite,copy) NSNumber *number;

@end

@interface NSObject (NUIPIsNumberToken)

- (BOOL)isNumberToken;

@end
