//
//  ViewController.h
//  Program 3 Clocks
//
//  Created by Brandon Everett on 3/13/14.
//  Copyright (c) 2014 Brandon Everett. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

{
    int seconds, minutes, hours;
}

@property (nonatomic, strong) CALayer* sArrow;
@property (nonatomic, strong) CALayer* mArrow;
@property (nonatomic, strong) CALayer* hArrow;
@end
