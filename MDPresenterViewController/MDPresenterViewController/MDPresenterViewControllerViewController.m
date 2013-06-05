//
//  MDPresenterViewControllerViewController.m
//  MDPresenterViewController
//
//  Created by Mohammed Eldehairy on 6/5/13.
//  Copyright (c) 2013 Mohammed Eldehairy. All rights reserved.
//

#import "MDPresenterViewControllerViewController.h"

@interface MDPresenterViewControllerViewController ()

@end

@implementation MDPresenterViewControllerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
}
-(void)Present:(id)sender
{
    [self presentViewController:[[PresentedViewContorller alloc] initWithNibName:@"PresentedViewContorller" bundle:nil] animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
