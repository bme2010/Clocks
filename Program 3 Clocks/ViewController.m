//
//  ViewController.m
//  Program 3 Clocks
//
//  Created by Brandon Everett on 3/13/14.
//  Copyright (c) 2014 Brandon Everett. All rights reserved.

/*
 Program:    Clocks
 Author:     Brandon Everett
 Date:       March 16th, 2013
 Time spent:  4 hours
 Purpose:     This creates a clock and animates the hands to the current time
 */
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    //make circle
    CALayer* mainLayer = self.view.layer;
    CAShapeLayer* circle = [CAShapeLayer new];
    circle.contentsScale = [UIScreen mainScreen].scale;
    circle.lineWidth =2.0;
    circle.fillColor = [UIColor colorWithRed:.9 green:.95 blue:.93 alpha:.9].CGColor;
    circle.strokeColor = [UIColor grayColor].CGColor;
    CGMutablePathRef p = CGPathCreateMutable();
    CGPathAddEllipseInRect(p,nil, CGRectInset(CGRectMake(0, 0, 250, 250), 3, 3));
    circle.path = p;
    
    [mainLayer addSublayer:circle];
    circle.bounds = CGRectMake(0, 0, 250, 250);
    circle.position = CGPointMake(160, 240);
    
    //create numbers as layers
    for(int i=1; i<=12; i++)
    {
        CATextLayer* t = [CATextLayer new];
        t.contentsScale = [UIScreen mainScreen].scale;
        //t.string = [NSString stringWithFormat:@"%i",i];
        t.string = @"|";
        t.bounds = CGRectMake(0, 0, 40, 40);
        t.position = CGPointMake(CGRectGetMidX(circle.bounds), CGRectGetMidY(circle.bounds));
        CGFloat vert = CGRectGetMidY(circle.bounds) / CGRectGetHeight(t.bounds);
        t.anchorPoint = CGPointMake(.5, vert);
        t.alignmentMode = @"center";
        t.foregroundColor = [UIColor blackColor].CGColor;
        t.affineTransform = CGAffineTransformMakeRotation(i*M_PI/6);
        
        [circle addSublayer:t];
    }
    
    for(int i=1; i<=60; i++)
    {
        if(i%5==0)
            continue;
        CATextLayer* t = [CATextLayer new];
        t.contentsScale = [UIScreen mainScreen].scale;
        //t.string = [NSString stringWithFormat:@"%i",i];
        t.string = @"|";
        t.fontSize = 10;
        t.bounds = CGRectMake(0, 0, 40, 40);
        t.position = CGPointMake(CGRectGetMidX(circle.bounds), CGRectGetMidY(circle.bounds));
        CGFloat vert = CGRectGetMidY(circle.bounds) / CGRectGetHeight(t.bounds);
        t.anchorPoint = CGPointMake(.5, vert);
        t.alignmentMode = @"center";
        t.foregroundColor = [UIColor blackColor].CGColor;
        t.affineTransform = CGAffineTransformMakeRotation(i*M_PI/30);
        
        [circle addSublayer:t];

        
    }
    
    //second hand
    self.sArrow = [CALayer new];
    self.sArrow.contentsScale = [UIScreen mainScreen].scale;
    self.sArrow.bounds = CGRectMake(0, 0, 1,100);
    self.sArrow.position = CGPointMake(160, 240);
    self.sArrow.anchorPoint = CGPointMake(0.5, .8);
    self.sArrow.backgroundColor = [UIColor redColor].CGColor;
    [mainLayer addSublayer:self.sArrow];
    
    
    //minute hand
    self.mArrow = [CALayer new];
    self.mArrow.contentsScale = [UIScreen mainScreen].scale;
    self.mArrow.bounds = CGRectMake(0, 0, 1,110);
    self.mArrow.position = CGPointMake(160, 240);
    self.mArrow.anchorPoint = CGPointMake(0.5, .8);
    self.mArrow.backgroundColor = [UIColor blackColor].CGColor;
    [mainLayer addSublayer:self.mArrow];
    
    self.hArrow = [CALayer new];
    self.hArrow.contentsScale = [UIScreen mainScreen].scale;
    self.hArrow.bounds = CGRectMake(0, 0, 1,80);
    self.hArrow.position = CGPointMake(160, 240);
    self.hArrow.anchorPoint = CGPointMake(0.5, .8);
    self.hArrow.backgroundColor = [UIColor blackColor].CGColor;
    [mainLayer addSublayer:self.hArrow];
    
    NSDate* today =[NSDate date];
    NSCalendar* calender = [NSCalendar currentCalendar];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat: @"HH-mm-ss"];
    NSUInteger unitFlags = NSHourCalendarUnit|NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponents = [calender components:unitFlags fromDate:today];
    hours = dateComponents.hour;
    minutes = dateComponents.minute;
    seconds = dateComponents.second;
    
    
    
    self.hArrow.affineTransform = CGAffineTransformMakeRotation(hours*M_PI/6);
    self.mArrow.affineTransform = CGAffineTransformMakeRotation(minutes*M_PI/30);
    self.sArrow.affineTransform = CGAffineTransformMakeRotation(seconds*M_PI/30);
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(moveHands) userInfo:nil repeats:YES];
    
    

}
- (void)moveHands
{
    seconds++;
    self.sArrow.affineTransform = CGAffineTransformMakeRotation(seconds*M_PI/30);
    
    if(seconds > 59)
    {
        seconds =0;
        self.sArrow.affineTransform = CGAffineTransformMakeRotation(seconds*M_PI/30);
        minutes++;
        self.mArrow.affineTransform = CGAffineTransformMakeRotation(minutes*M_PI/30);
        if(minutes > 59)
        {
            minutes =0;
            self.mArrow.affineTransform = CGAffineTransformMakeRotation(0*M_PI/30);
            hours++;
            self.hArrow.affineTransform = CGAffineTransformMakeRotation(hours*M_PI/6);
            if(hours > 12)
                hours=0;
        }
    }
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
