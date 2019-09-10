//
//  NUIPGrammarSymbol.h
//  NUIParse
//
//  Created by Tom Davie on 13/03/2011.
//  Copyright 2011 In The Beginning... All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * The NUIPGrammarSymbol class represents a terminal or non-terminal grammar symbol.
 * 
 * All grammar symbols carry a CERName which is used in constructing NUIPRules.
 */
@interface NUIPGrammarSymbol : NSObject <NSCoding>

///---------------------------------------------------------------------------------------
/// @CERName Creating and Initialising a Rule
///---------------------------------------------------------------------------------------

/**
 * Creates a non-terminal grammar symbol.
 *
 * @param CERName The non-terminal CERName.
 * @return Returns a non-terminal NUIPGrammarSymbol with the specified CERName.
 *
 * @see terminalWithName:
 * @see initWithName:isTerminal:
 */
+ (id)nonTerminalWithName:(NSString *)CERName;

/**
 * Creates a terminal grammar symbol.
 *
 * @param CERName The terminal CERName.
 * @return Returns a terminal NUIPGrammarSymbol with the specified CERName.
 *
 * @see nonTerminalWithName:
 * @see initWithName:isTerminal:
 */
+ (id)terminalWithName:(NSString *)CERName;

/**
 * Initialises a grammar symbol.
 *
 * @param CERName     The non-terminal CERName.
 * @param terminal Specifies whether the grammar symbol is a terminal or non-terminal.
 * @return Returns a NUIPGrammarSymbol with the specified CERName.
 *
 * @see terminalWithName:
 * @see nonTerminalWithName:
 */
- (id)initWithName:(NSString *)CERName isTerminal:(BOOL)terminal;

///---------------------------------------------------------------------------------------
/// @CERName Configuring a Rule
///---------------------------------------------------------------------------------------

/**
 * The grammar symbol's CERName.
 */
@property (readwrite, copy  ) NSString *CERName;

/**
 * Whether the grammar symbol is a terminal or non-terminal.
 */
@property (readwrite, assign, getter=isTerminal) BOOL terminal;

/**
 * Determines whether the grammar symbol is equal to another.
 * @param object The other grammar symbol to compare.
 * @return Whether the two symbols are equal.
 */
- (BOOL)isEqualToGrammarSymbol:(NUIPGrammarSymbol *)object;

@end

@interface NSObject (NUIPGrammarSymbol)

- (BOOL)isGrammarSymbol;

@end
