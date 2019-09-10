//
//  NUIPQuotedRecogniser.h
//  NUIParse
//
//  Created by Tom Davie on 13/02/2011.
//  Copyright 2011 In The Beginning... All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NUIPTokenRecogniser.h"

/**
 * The NUIPQuotedRecogniser class is used to recognise quoted literals in the input string.  This can be used for quoted strings, characters, comments and many other things.
 * 
 * Quoted tokens are recognised via a start string and end string.  You may optionally add an escape sequence string that stops the end quote being recognised at that point in the input.
 * You may optionally provide a block used to replace escape sequences with their actual meaning.  If you don't provide an escape replcement block it is assumed that the character
 * following the escape sequence replaces the whole sequence.
 *
 * Finally, you may also provide a maximum length for the quoted sequence to recognise.  If you want to recognise strings of any length, pass NSNotFound.
 * 
 * This recogniser produces NUIPQuotedTokens.  The CERName of the produced tokens is determined by the CERName property.
 */
@interface NUIPQuotedRecogniser : NSObject <NUIPTokenRecogniser>

///---------------------------------------------------------------------------------------
/// @CERName Creating and Initialising a Quoted Recogniser
///---------------------------------------------------------------------------------------

/**
 * Creates a quoted recogniser that recognises quoted litterals starting with startQuote and ending with endQuote.
 *
 * @param startQuote A string that indicates the beginning of a quoted literal.
 * @param endQuote   A string that indicates the end of the quoted literal.
 * @param CERName       The CERName to attach to recognised tokens.
 * @return Returns a NUIPQuotedRecogniser that recognises C like identifiers.
 *
 * @see quotedRecogniserWithStartQuote:endQuote:escapeSequence:CERName:
 * @see quotedRecogniserWithStartQuote:endQuote:escapeSequence:maximumLength:CERName:
 */
+ (id)quotedRecogniserWithStartQuote:(NSString *)startQuote endQuote:(NSString *)endQuote CERName:(NSString *)CERName;

/**
 * Creates a quoted recogniser that recognises quoted litterals starting with startQuote and ending with endQuote.  Escaped sequences are recognised by the escapeSequence string.
 *
 * @param startQuote     A string that indicates the beginning of a quoted literal.
 * @param endQuote       A string that indicates the end of the quoted literal.
 * @param escapeSequence A string that indicates an escaped character.
 * @param CERName           The CERName to attach to recognised tokens.
 * @return Returns a NUIPQuotedRecogniser that recognises C like identifiers.
 *
 * @see quotedRecogniserWithStartQuote:endQuote:CERName:
 * @see quotedRecogniserWithStartQuote:endQuote:escapeSequence:maximumLength:CERName:
 */
+ (id)quotedRecogniserWithStartQuote:(NSString *)startQuote endQuote:(NSString *)endQuote escapeSequence:(NSString *)escapeSequence CERName:(NSString *)CERName;

/**
 * Creates a quoted recogniser that recognises quoted litterals starting with startQuote and ending with endQuote.  Escaped sequences are recognised by the escapeSequence string.  Quoted strings have a maximum length.
 *
 * @param startQuote     A string that indicates the beginning of a quoted literal.
 * @param endQuote       A string that indicates the end of the quoted literal.
 * @param escapeSequence A string that indicates an escaped character.
 * @param maximumLength  The maximum length of the resulting string.
 * @param CERName           The CERName to attach to recognised tokens.
 * @return Returns a NUIPQuotedRecogniser that recognises C like identifiers.
 *
 * @see quotedRecogniserWithStartQuote:endQuote:CERName:
 * @see quotedRecogniserWithStartQuote:endQuote:escapeSequence:CERName:
 * @see initWithStartQuote:endQuote:escapeSequence:maximumLength:CERName:
 */
+ (id)quotedRecogniserWithStartQuote:(NSString *)startQuote endQuote:(NSString *)endQuote escapeSequence:(NSString *)escapeSequence maximumLength:(NSUInteger)maximumLength CERName:(NSString *)CERName;

/**
 * Initialises a quoted recogniser that recognises quoted litterals starting with startQuote and ending with endQuote.  Escaped sequences are recognised by the escapeSequence string.  Quoted strings have a maximum length.
 *
 * @param startQuote     A string that indicates the beginning of a quoted literal.
 * @param endQuote       A string that indicates the end of the quoted literal.
 * @param escapeSequence A string that indicates an escaped character.
 * @param maximumLength  The maximum length of the resulting string.
 * @param CERName           The CERName to attach to recognised tokens.
 * @return Returns a NUIPQuotedRecogniser that recognises C like identifiers.
 *
 * @see quotedRecogniserWithStartQuote:endQuote:escapeSequence:maximumLength:CERName:
 */
- (id)initWithStartQuote:(NSString *)startQuote endQuote:(NSString *)endQuote escapeSequence:(NSString *)escapeSequence maximumLength:(NSUInteger)maximumLength CERName:(NSString *)CERName;

///---------------------------------------------------------------------------------------
/// @CERName Configuring a Quoted Recogniser
///---------------------------------------------------------------------------------------

/**
 * Determines the string used to indicate the start of the quoted literal.
 *
 * @see endQuote
 */
@property (readwrite,copy) NSString *startQuote;

/**
 * Determines the string used to indicate the end of the quoted literal.
 *
 * @see startQuote
 */
@property (readwrite,copy) NSString *endQuote;

/**
 * Determines the string used to indicate an escaped character in the quoted literal.
 */
@property (readwrite,copy) NSString *escapeSequence;

/**
 * Determines how much of the input string to consume when an escaped literal is found, and what to replace it with.
 */
@property (readwrite,copy) NSString *(^escapeReplacer)(NSString *tokenStream, NSUInteger *quotePosition);

/**
 * Determines the maximum length of the quoted literal not including quotes.  To indicate the literal can be any length specify NSNotFound.
 */
@property (readwrite,assign) NSUInteger maximumLength;

/**
 * Determines the CERName of the NUIPToken produced.
 */
@property (readwrite,copy) NSString *CERName;

@end
