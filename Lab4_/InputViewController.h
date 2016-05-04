//
//  InputViewController.h
//  Lab4_
//
//  Created by Jonathan Esquibel on 3/26/16.
//  Copyright © 2016 Jonathan Esquibel. All rights reserved.
//

#import "ViewController.h"

typedef void(^AddFlashcardCompletionHandler) (NSString *question, NSString *answer);

@interface InputViewController : ViewController

@property (copy, nonatomic) AddFlashcardCompletionHandler completionHandler;

@end
