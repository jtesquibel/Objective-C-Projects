//
//  InputViewController.m
//  Lab4_
//
//  Created by Jonathan Esquibel on 3/26/16.
//  Copyright © 2016 Jonathan Esquibel. All rights reserved.
//

#import "InputViewController.h"
#import "FlashcardsModel.h"

@interface InputViewController () <UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UITextView *questionTextView;
@property (weak, nonatomic) IBOutlet UITextField *answerTextField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;


@end

@implementation InputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.saveButton.enabled = false;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.questionTextView becomeFirstResponder];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    if (self.completionHandler) {
        self.completionHandler(self.questionTextView.text, self.answerTextField.text);
    }
    
    self.questionTextView.text = nil;
    self.answerTextField.text = nil;
    
    return YES;
}

- (void) enableSaveButtonForFlashcard: (NSString *) questionText answer: (NSString *) answerText {
    // self.saveButton.enabled = (questionText.length > 0 && answerText.length > 0);
    if (questionText.length > 0 && answerText.length > 0) {
        self.saveButton.enabled = true;
    }
    else if (questionText.length == 0 || answerText.length == 0) {
        self.saveButton.enabled = false;
    }
}

- (BOOL) textView:(UITextView *)textView shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString *changedString = [textView.text stringByReplacingCharactersInRange:range withString:string];
    [self enableSaveButtonForFlashcard:changedString answer:self.answerTextField.text];
    
    return YES;
}

- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString *changedString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    [self enableSaveButtonForFlashcard:self.questionTextView.text answer:changedString];
    
    return YES;
}


- (IBAction)cancelButtonTapped:(id)sender {
    // add code to make keyboard go away (resignFirstResponder)
    [self.questionTextView resignFirstResponder];
    
    if (self.completionHandler) {
        self.completionHandler(nil, nil);
    }
    
    self.questionTextView.text = nil;
    self.answerTextField.text = nil;
}

- (IBAction)saveButtonTapped:(id)sender {
    // add code to make keyboard go away (resignFirstResponder)
    [self.questionTextView resignFirstResponder];
    
    if (self.completionHandler) {
        self.completionHandler(self.questionTextView.text, self.answerTextField.text);
    }
    
    self.questionTextView.text = nil;
    self.answerTextField.text = nil;
}



@end
