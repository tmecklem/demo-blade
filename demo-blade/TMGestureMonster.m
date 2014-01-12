//
//  TMGestureMonster.m
//  demo-blade
//
//  Created by Timothy Mecklem on 1/10/14.
//  Copyright (c) 2014 Tim Mecklem. All rights reserved.
//

#import "TMGestureMonster.h"

@interface TMGestureMonster()

@property(nonatomic, strong) UIPanGestureRecognizer *panRecognizer;
@property(nonatomic, strong) UITapGestureRecognizer *tapRecognizer;
@property(nonatomic, weak) UIView *view;
@property(nonatomic, strong) UIImageView *panImageView;

@end

@implementation TMGestureMonster

-(id)initWithView:(UIView *)view {
    self = [super init];
    if(self) {
        self.view = view;
        [self setupRecognizersForView:view];
    }
    return self;
}

-(void)setupRecognizersForView:(UIView *)view {
    self.panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panPerformed:)];
    [view addGestureRecognizer:self.panRecognizer];
    self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPerformed:)];
    [view addGestureRecognizer:self.tapRecognizer];
}


-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return gestureRecognizer == self.panRecognizer || otherGestureRecognizer == self.panRecognizer
            || gestureRecognizer == self.tapRecognizer || otherGestureRecognizer == self.tapRecognizer;
}

-(IBAction)panPerformed:(UIPanGestureRecognizer *)panGestureRecognizer {
    if(UIGestureRecognizerStateBegan == panGestureRecognizer.state) {
        UIImage *image = [UIImage imageNamed:@"star.png"];
        self.panImageView = [[UIImageView alloc] initWithImage:image];
        
        [self.view addSubview:self.panImageView];
        [UIView animateWithDuration:0.05f animations:^{
            CGPoint location = [panGestureRecognizer locationInView:self.view];
            self.panImageView.frame = CGRectMake(location.x - (image.size.width/2), location.y - (image.size.height/2), image.size.width, image.size.height);
        } completion:nil];
        
    } else if (UIGestureRecognizerStateChanged == panGestureRecognizer.state) {
        CGPoint location = [panGestureRecognizer locationInView:self.view];
        self.panImageView.frame = CGRectMake(location.x - (self.panImageView.frame.size.width/2), location.y - (self.panImageView.frame.size.height/2), self.panImageView.frame.size.width, self.panImageView.frame.size.height);
    } else if(UIGestureRecognizerStateEnded == panGestureRecognizer.state) {
        UIImageView *fadingImageView = self.panImageView;
        [UIView animateWithDuration:0.2f delay:1.0f options:0 animations:^{
            fadingImageView.alpha = 0.0f;
        } completion:^(BOOL finished) {
            [fadingImageView removeFromSuperview];
        }];

    }
}

-(IBAction)tapPerformed:(UIGestureRecognizer *)tapGestureRecognizer {
    if(UIGestureRecognizerStateRecognized == tapGestureRecognizer.state){
        UIImage *image = [UIImage imageNamed:@"star.png"];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        
        [self.view addSubview:imageView];
        [UIView animateWithDuration:0.2f animations:^{
            CGPoint location = [tapGestureRecognizer locationInView:nil];
            imageView.frame = CGRectMake(location.x - (image.size.width/2), location.y - (image.size.height/2), image.size.width, image.size.height);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2f delay:1.0f options:0 animations:^{
                imageView.alpha = 0.0f;
            } completion:^(BOOL finished) {
                [imageView removeFromSuperview];
            }];
        }];
        
        
    }
}

@end
