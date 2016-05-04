//
//  FlashcardsModel.m
//  Lab4_
//
//  Created by Jonathan Esquibel on 3/1/16.
//  Copyright © 2016 Jonathan Esquibel. All rights reserved.
//

#import "FlashcardsModel.h"

static NSString * const kFlashcardsPList = @"Flashcards.plist";

@interface FlashcardsModel()

// private property
@property (strong, nonatomic) NSMutableArray *flashcards;
@property (strong, nonatomic) NSMutableArray *favorites;
@property (strong, nonatomic) NSString *filePath;



@end

NSString *const kFlashcardsArrayKey = @"FlashcardsArray";

@implementation FlashcardsModel

+ (instancetype) sharedModel {
    static FlashcardsModel *_sharedModel = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // code to be executed once - thread safe version
        _sharedModel = [[self alloc] init];
    });
    return _sharedModel;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
        
        NSString *documentDirectory = [paths objectAtIndex:0];
        
        _filePath = [documentDirectory stringByAppendingPathComponent:kFlashcardsPList];
        
        _flashcards = [NSMutableArray arrayWithContentsOfFile:_filePath];
        
        self.favoriteIndex = 0;
        
        if (!_flashcards) {
        
            NSDictionary *flashcard1 = [[NSDictionary alloc] initWithObjectsAndKeys: @"2+2?" , kQuestionKey, @"4", kAnswerKey, nil];
            NSDictionary *flashcard2 = [[NSDictionary alloc] initWithObjectsAndKeys: @"2+3?" , kQuestionKey, @"5", kAnswerKey, nil];
            NSDictionary *flashcard3 = [[NSDictionary alloc] initWithObjectsAndKeys: @"2+4?" , kQuestionKey, @"6", kAnswerKey, 0, nil];
            NSDictionary *flashcard4 = [[NSDictionary alloc] initWithObjectsAndKeys: @"2+5?" , kQuestionKey, @"7", kAnswerKey, 0, nil];
            NSDictionary *flashcard5 = [[NSDictionary alloc] initWithObjectsAndKeys: @"2+6?" , kQuestionKey, @"8", kAnswerKey, 0, nil];
            NSDictionary *flashcard6 = [[NSDictionary alloc] initWithObjectsAndKeys: @"2+7?" , kQuestionKey, @"9", kAnswerKey, 0, nil];
            NSDictionary *flashcard7 = [[NSDictionary alloc] initWithObjectsAndKeys: @"2+8?" , kQuestionKey, @"10", kAnswerKey, 0, nil];
            NSDictionary *flashcard8 = [[NSDictionary alloc] initWithObjectsAndKeys: @"2+9?" , kQuestionKey, @"11", kAnswerKey, 0, nil];
        
            _flashcards = [[NSMutableArray alloc] initWithObjects: flashcard1, flashcard2, flashcard3, flashcard4, flashcard5, flashcard6, flashcard7, flashcard8, nil];
            _favorites = [[NSMutableArray alloc] init];
        }
    }
    return self;
}

//- (NSMutableArray *) flashcards {
//    if (!_flashcards) {
//        NSArray *storedFlashcards = [[NSUserDefaults standardUserDefaults] objectForKey:kFlashcardsArrayKey];
//        
//        if (storedFlashcards) {
//            _flashcards = [storedFlashcards mutableCopy];
//        } else {
//            NSDictionary *flashcard1 = [[NSDictionary alloc] initWithObjectsAndKeys: @"What is 2+2?" , kQuestionKey, @"4", kAnswerKey, nil];
//            NSDictionary *flashcard2 = [[NSDictionary alloc] initWithObjectsAndKeys: @"What is 2+3?" , kQuestionKey, @"5", kAnswerKey, nil];
//            NSDictionary *flashcard3 = [[NSDictionary alloc] initWithObjectsAndKeys: @"What is 2+4?" , kQuestionKey, @"6", kAnswerKey, nil];
//            NSDictionary *flashcard4 = [[NSDictionary alloc] initWithObjectsAndKeys: @"What is 2+5?" , kQuestionKey, @"7", kAnswerKey, nil];
//            NSDictionary *flashcard5 = [[NSDictionary alloc] initWithObjectsAndKeys: @"What is 2+6?" , kQuestionKey, @"8", kAnswerKey, nil];
//            NSDictionary *flashcard6 = [[NSDictionary alloc] initWithObjectsAndKeys: @"What is 2+7?" , kQuestionKey, @"9", kAnswerKey, nil];
//            NSDictionary *flashcard7 = [[NSDictionary alloc] initWithObjectsAndKeys: @"What is 2+8?" , kQuestionKey, @"10", kAnswerKey, nil];
//            NSDictionary *flashcard8 = [[NSDictionary alloc] initWithObjectsAndKeys: @"What is 2+9?" , kQuestionKey, @"11", kAnswerKey, nil];
//            
//            _flashcards = [[NSMutableArray alloc] initWithObjects: flashcard1, flashcard2, flashcard3, flashcard4, flashcard5, flashcard6, flashcard7, flashcard8, nil];
//        }
//    }
//    return _flashcards;
//}

- (NSDictionary *) randomFlashcard {
    if ([self.flashcards count] == 0) {
        NSDictionary *flashcard1 = [[NSDictionary alloc] initWithObjectsAndKeys: @"There are no flashcards!" , kQuestionKey, @"Enter a flashcard to begin!", kAnswerKey, nil];
        return flashcard1;
    }
    else {
        NSUInteger index = arc4random_uniform( (int)[self numberOfFlashcards] );
        NSDictionary *flashcard = self.flashcards[index];
        self.currentIndex = (int)index;
        return flashcard;
    }
}

- (NSUInteger) numberOfFlashcards {
    return [self.flashcards count];
}

- (NSUInteger) numberOfFavorites {
    return [self.favorites count];
}

- (NSDictionary *) flashcardAtIndex: (NSUInteger) index {
    return self.flashcards[index];
}

- (void) removeFlashcardAtIndex: (NSUInteger) index {
    if (index < [self numberOfFlashcards]) {
        [self.flashcards removeObjectAtIndex:index];
        [self save];
    }
}

- (void) insertFlashcard: (NSDictionary *) student {
    [self.flashcards addObject:student];
    [self save];
}

- (void) insertFlashcard: (NSString *) question
                  answer: (NSString *) answer {
    NSDictionary *flashcard1 = [NSDictionary dictionaryWithObjectsAndKeys:question, kQuestionKey, answer, kAnswerKey, nil];
    [self insertFlashcard:flashcard1];
    [self save];
}

- (void) insertFlashcard: (NSDictionary *) flashcard
                 atIndex: (NSUInteger) index {
    [self.flashcards insertObject:flashcard atIndex:index];
    [self save];
}

- (void) insertFlashcard: (NSString *) question
                  answer: (NSString *) answer
                 atIndex: (NSUInteger) index {
    NSDictionary *flashcard1 = [NSDictionary dictionaryWithObjectsAndKeys:question, kQuestionKey, answer, kAnswerKey, nil];
    [self insertFlashcard:flashcard1 atIndex:index];
    [self save];
    
}

- (NSDictionary *) nextFlashcard {
    NSInteger nextIndex = _currentIndex+1;
    if (nextIndex >= self.numberOfFlashcards) {
        _currentIndex = 0;
        return [self flashcardAtIndex:0];
    }
    else {
        _currentIndex++;
        return [self flashcardAtIndex:nextIndex];
    }
    
}
- (NSDictionary *) prevFlashcard {
    NSInteger previousIndex = _currentIndex-1;
    if (previousIndex < 0) {
        NSInteger lastIndex = self.numberOfFlashcards-1;
        _currentIndex = self.numberOfFlashcards-1;
        return [self flashcardAtIndex:lastIndex];
    }
    else {
        _currentIndex--;
        return [self flashcardAtIndex:previousIndex];
    }
    
}

- (void) save {
    [self.flashcards writeToFile:self.filePath atomically:YES];
}

- (void) insertFavorite:(NSDictionary *)flashcard {
    [self.favorites addObject:flashcard];
}

- (void) removeFavoriteAtIndex: (NSUInteger) index {
    
}



@end
