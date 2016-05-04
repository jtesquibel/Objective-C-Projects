//
//  ViewController.m
//  Lab4_
//
//  Created by Jonathan Esquibel on 3/1/16.
//  Copyright © 2016 Jonathan Esquibel. All rights reserved.
//

#import "ViewController.h"
#import "FlashcardsModel.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

static NSString const *questionAudioFile = @"fadein.wav";
static NSString const *answerAudioFile = @"TaDa.wav";

@interface ViewController ()

// IBOutlets
@property (weak, nonatomic) IBOutlet UILabel *QALabel;



// private properties
@property (strong, nonatomic) FlashcardsModel *model;
@property (strong, nonatomic) NSString *answer;
@property (strong, nonatomic) AVAudioPlayer *questionPlayer;
@property (strong, nonatomic) AVAudioPlayer *answerPlayer;
@property (readonly) SystemSoundID questionFileID;
@property (readonly) SystemSoundID answerFileID;
@property (strong, nonatomic) UIImage *star;
@property (strong, nonatomic) UIImage *starFilled;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.model = [FlashcardsModel sharedModel];
    NSDictionary *flashcard = [self.model randomFlashcard];
    self.QALabel.text = flashcard[kQuestionKey];
    self.answer = flashcard[kAnswerKey];
    
    self.star = [UIImage imageNamed:@"star.png"];
    self.starFilled = [UIImage imageNamed:@"starFilled.png"];
    
    // single tap
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(singleTapRecognized:)];
    [self.view addGestureRecognizer:singleTap];
    
    // double tap
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(doubleTapRecognized:)];
    doubleTap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:doubleTap];
    
    [singleTap requireGestureRecognizerToFail:doubleTap];
    
    // swipe left
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(swipeGestureRecognized:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeft];
    
    // swipe right
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(swipeGestureRecognized:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];
    
    // question audio
    NSString *questionPath = [NSString stringWithFormat:@"%@/fadein.wav",
                              [[NSBundle mainBundle] resourcePath]];
    NSURL *questionURL = [NSURL fileURLWithPath:questionPath];
    
    NSError *error;
    self.questionPlayer= [[AVAudioPlayer alloc] initWithContentsOfURL:questionURL error:&error];
    [self.questionPlayer prepareToPlay];
    
    // answer audio
    NSString *answerPath = [NSString stringWithFormat:@"%@/TaDa.wav",
                            [[NSBundle mainBundle] resourcePath]];
    NSURL *answerURL = [NSURL fileURLWithPath:answerPath];
    
    self.answerPlayer= [[AVAudioPlayer alloc] initWithContentsOfURL:answerURL error:&error];
    [self.answerPlayer prepareToPlay];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) singleTapRecognized: (UITapGestureRecognizer *) recognizer {
    [self.questionPlayer play];
    self.QALabel.alpha = 0;
    
    NSDictionary *flashcard = [self.model randomFlashcard];
    self.QALabel.text = flashcard[kQuestionKey];
    
    [UIView animateWithDuration:2
                     animations:^{self.QALabel.alpha = 1;}];
    self.answer = flashcard[kAnswerKey];
}

- (void) doubleTapRecognized: (UITapGestureRecognizer *) recognizer {
    [self.answerPlayer play];
    self.QALabel.alpha = 0;
    self.QALabel.text = self.answer;
    
    [UIView animateWithDuration:2
                     animations:^{self.QALabel.alpha = 1;}];
}

- (void) swipeGestureRecognized: (UISwipeGestureRecognizer *) recognizer {
    
    if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
        NSDictionary *flashcard = [self.model prevFlashcard];
        self.QALabel.text = flashcard[kQuestionKey];
        self.answer = flashcard[kAnswerKey];
    }
    else if (recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
        NSDictionary *flashcard = [self.model nextFlashcard];
        self.QALabel.text = flashcard[kQuestionKey];
        self.answer = flashcard[kAnswerKey];
    }
    
}

- (void) motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        self.QALabel.alpha = 0;
        NSDictionary *flashcard = [self.model randomFlashcard];
        self.QALabel.text = flashcard[kQuestionKey];
        self.answer = flashcard[kAnswerKey];
        [UIView animateWithDuration:2
                         animations:^{self.QALabel.alpha = 1;}];
    }
}

- (BOOL) canBecomeFirstResponder {
    return YES;
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
}

- (IBAction)favoriteTouched:(id)sender {
    if ([sender isSelected]) {
        [sender setImage:self.star forState:UIControlStateNormal];
        [sender setSelected:NO];
        
    } else {
        [sender setImage:self.starFilled forState:UIControlStateSelected];
        [sender setSelected:YES];
        NSDictionary *flashcard = [self.model flashcardAtIndex:self.model.currentIndex];
        [self.model insertFavorite:flashcard];
    }
}

@end
