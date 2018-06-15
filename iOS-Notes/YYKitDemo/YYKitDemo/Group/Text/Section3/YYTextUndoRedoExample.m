//
//  YYTextUndoRedoExample.m
//  YYKitExample
//
//  Created by ibireme on 15/9/12.
//  Copyright (c) 2015 ibireme. All rights reserved.
//

#import "YYTextUndoRedoExample.h"
#import "Constant.h"

@interface YYTextUndoRedoExample ()<YYTextViewDelegate>
@property (nonatomic, assign) YYTextView *textView;
@end

@implementation YYTextUndoRedoExample

#pragma mark - Initialize
- (void)InitializeData{
    self.view.backgroundColor = [UIColor whiteColor];
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    NSString *text = @"You can shake the device to undo and redo.";
    
    YYTextView *textView = [YYTextView new];
    textView.text = text;
    textView.font = [UIFont systemFontOfSize:17];
    textView.size = [UIScreen mainScreen].bounds.size;
    textView.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
    textView.delegate = self;
    textView.allowsUndoAndRedo = YES; /// Undo and Redo
    textView.maximumUndoLevel = 10; /// Undo level
    if (kiOS7Later) {
        textView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    }
    textView.contentInset = UIEdgeInsetsMake((kiOS7Later ? 88 : 0), 0, 0, 0);
    textView.scrollIndicatorInsets = textView.contentInset;
    [self.view addSubview:textView];
    self.textView = textView;
    
    textView.selectedRange = NSMakeRange(text.length, 0);
    [textView becomeFirstResponder];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self InitializeData];
}
- (void)edit:(UIBarButtonItem *)item {
    if (_textView.isFirstResponder) {
        [_textView resignFirstResponder];
    } else {
        [_textView becomeFirstResponder];
    }
}
- (void)textViewDidBeginEditing:(YYTextView *)textView {
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(edit:)];
    self.navigationItem.rightBarButtonItem = buttonItem;
}
- (void)textViewDidEndEditing:(YYTextView *)textView {
    self.navigationItem.rightBarButtonItem = nil;
}

@end
