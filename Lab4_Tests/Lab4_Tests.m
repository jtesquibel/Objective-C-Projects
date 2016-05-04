//
//  Lab4_Tests.m
//  Lab4_Tests
//
//  Created by Jonathan Esquibel on 3/1/16.
//  Copyright © 2016 Jonathan Esquibel. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FlashcardsModel.h"

@interface Lab4_Tests : XCTestCase

@property (strong, nonatomic) FlashcardsModel *model;

@end

@implementation Lab4_Tests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    self.model = [[FlashcardsModel alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void) logArray {
    NSDictionary *flashcard;
    for (NSUInteger i = 0; i < [self.model numberOfFlashcards]; i++) {
        flashcard = [self.model flashcardAtIndex:i];
        NSLog(@"%@ %@", flashcard[kQuestionKey], flashcard[kAnswerKey]);
    }
    NSLog(@" ");
}

- (void) testFlashcardModel {
    // local variables
    NSDictionary *flashcard;
    NSUInteger num;
    
    // test init
    num = 8;
    XCTAssertEqual(num, [self.model numberOfFlashcards]);
    NSLog(@"Initial array:");
    [self logArray];
    
    // test insert student
    flashcard = [[NSDictionary alloc] initWithObjectsAndKeys:@"What is 5+5?", kQuestionKey, @"10", kAnswerKey, nil];
    [self.model insertFlashcard:flashcard];
    num++;
    XCTAssertEqual(num, [self.model numberOfFlashcards]);
    NSLog(@"Insert 5+5 at end");
    [self logArray];
    
    // test remove flashcard at index
    [self.model removeFlashcardAtIndex:0];
    num--;
    XCTAssertEqual(num, [self.model numberOfFlashcards]);
    NSLog(@"Remove the first flashcard");
    [self logArray];
}
                   
                

@end
