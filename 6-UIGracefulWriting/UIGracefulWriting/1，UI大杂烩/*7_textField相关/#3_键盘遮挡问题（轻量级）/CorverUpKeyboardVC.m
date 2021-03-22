//
//  CorverUpKeyboardVC.m
//  UIGracefulWriting
//
//  Created by gjfax on 2019/4/12.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "CorverUpKeyboardVC.h"
#import "FKTextView.h"

static CGFloat const kTextDefaultWidth  = 70.f;
static CGFloat const kTextDefaultHeight = 40.f;

@interface CorverUpKeyboardVC ()
@property(nonatomic, strong)FKTextView *textView;
@end

@implementation CorverUpKeyboardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeRed];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.textView) {
        [self.textView setBackgroundColor:[UIColor clearColor]];
        [self.textView setEditable:NO];
        [self.textView resignFirstResponder];
        self.textView = nil;
    }else{
        UITouch *touch = [[event allTouches]anyObject];
        CGPoint point = [touch locationInView:[touch view]];
        self.textView = ({
            FKTextView *textView = [FKTextView new];
            /**
             设置了默认属性则不需要单独设置，可单独关闭floatable
             [textView setFloatable:YES];
             */
            [textView setTextColor:[UIColor redColor]];
            [textView setFont:[UIFont systemFontOfSize:20]];
            [textView setBackgroundColor:[UIColor whiteColor]];
            [textView setTranslatesAutoresizingMaskIntoConstraints:NO];
            [self.view addSubview:textView];
            NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:textView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:kTextDefaultWidth];
            NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:textView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:kTextDefaultHeight];
            NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:textView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:point.x-kTextDefaultWidth/2];
            NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:textView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:point.y-kTextDefaultHeight/2];
            [self.view addConstraint:topConstraint];
            [self.view addConstraint:leftConstraint];
            [self.view addConstraint:topConstraint];
            [textView addConstraint:widthConstraint];
            [textView addConstraint:heightConstraint];
            textView;
        });
    }
    
}

@end
