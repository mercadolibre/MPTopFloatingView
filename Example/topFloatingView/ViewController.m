//
//  ViewController.m
//
//  Created by Cristian Leonel Gibert on 7/13/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

#import "ViewController.h"
#import <MPTopFloatingView/MPTopFloatingView.h>

@interface ViewController ()

@property (nonatomic, strong) MPTopFloatingView *newsView;
@property (strong, nonatomic) IBOutlet UILabel *exampleLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.navigationController.navigationBar.translucent = NO;
	
	self.newsView = [[MPTopFloatingView alloc] initTopFloatingViewWithOnTapBlock:^{
		self.exampleLabel.text = @"You tap me!";
	}];
	
	[self.view addSubview:self.newsView];
	self.newsView.translatesAutoresizingMaskIntoConstraints = NO;
	
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.newsView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:-40]];
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.newsView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
	
	
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (IBAction)showNewsView:(id)sender {
	[self.newsView startAnimation:MPTopFloatingViewStatusAppear];

}

- (IBAction)hideNewsView:(id)sender {
	[self.newsView startAnimation:MPTopFloatingViewStatusDisappear];
}

@end




