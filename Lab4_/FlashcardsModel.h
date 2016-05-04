//
//  FlashcardsModel.h
//  Lab4_
//
//  Created by Jonathan Esquibel on 3/1/16.
//  Copyright © 2016 Jonathan Esquibel. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const kQuestionKey = @"question";
static NSString * const kAnswerKey = @"answer";
// static NSInteger * const kFavoriteKey = 0;

@interface FlashcardsModel : NSObject

@property NSInteger currentIndex;
@property NSInteger favoriteIndex;

+ (instancetype) sharedModel;
- (NSDictionary *) randomFlashcard;
- (NSUInteger) numberOfFlashcards;
- (NSUInteger) numberOfFavorites;
- (NSDictionary *) flashcardAtIndex: (NSUInteger) index;
- (void) removeFlashcardAtIndex: (NSUInteger) index;
- (void) insertFlashcard: (NSDictionary *) flashcard;
- (void) insertFlashcard: (NSString *) question
                  answer: (NSString *) answer;
- (void) insertFlashcard: (NSDictionary *) flashcard
                 atIndex: (NSUInteger) index;
- (void) insertFlashcard: (NSString *) flashcard
                  answer: (NSString *) author
                 atIndex: (NSUInteger) index;
- (NSDictionary *) nextFlashcard;
- (NSDictionary *) prevFlashcard;
- (void) insertFavorite: (NSDictionary *) flashcard;
- (void) removeFavoriteAtIndex: (NSUInteger) index;


@end
