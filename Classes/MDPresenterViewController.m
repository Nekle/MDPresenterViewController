//
//  MDPresenterViewController.m
//  MDPresenterViewController
//
//  Created by Mohammed Eldehairy on 6/5/13.
//  Copyright (c) 2013 Mohammed Eldehairy. All rights reserved.
//

#import "MDPresenterViewController.h"

@interface MDPresenterViewController ()

@end

@implementation MDPresenterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
    animationLayer = [CALayer layer] ;
    CGRect layerFrame = self.view.frame;
    animationLayer.frame = layerFrame;
    animationLayer.masksToBounds = YES;
    animationLayer.position = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height);
    animationLayer.anchorPoint = CGPointMake(0.5, 1.0);
    [animationLayer setContentsGravity:kCAGravityBottomLeft];
    [self.view.window.layer addSublayer:animationLayer];
    animationLayer.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)LoadLayerWithImage
{
    
    UIGraphicsBeginImageContext(self.view.bounds.size);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    [animationLayer setContents: (id)viewImage.CGImage];
    [animationLayer setHidden:NO];
    
    viewImage = nil;
    
}
-(void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion
{
     
    [animationLayer removeFromSuperlayer];
    [self.view.window.layer addSublayer:animationLayer];
    if(flag==YES)
    {
        //Load the CALayer Animation Layer with the Presenting view bitmap
        [self LoadLayerWithImage];
        
        
        
        CATransform3D rotationIdentity = CATransform3DIdentity;
        rotationIdentity.m34 = 1.0/-550;
        self.view.window.layer.sublayerTransform = rotationIdentity;
        
        // Rotate the Presenting View copied to the Animation layer
        
        CABasicAnimation *RotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
        [RotateAnimation setFromValue:[NSValue valueWithCATransform3D:CATransform3DIdentity]];
        CATransform3D rotationTransform = CATransform3DMakeRotation(M_PI*0.1, 1.0, 0.0, 0.0);
        [RotateAnimation setToValue:[NSValue valueWithCATransform3D:rotationTransform]];
        [RotateAnimation setDuration:0.3];
        RotateAnimation.delegate = self;
        RotateAnimation.removedOnCompletion = NO;
        RotateAnimation.fillMode = kCAFillModeBoth;
        [animationLayer addAnimation:RotateAnimation forKey:@"Rotation"];
        
        //Present the presented view
        
        CABasicAnimation *presentaionAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
        [presentaionAnimation setFromValue:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, self.view.frame.size.height, 0)]];
        [presentaionAnimation setToValue:[NSValue valueWithCATransform3D:CATransform3DIdentity]];
        [presentaionAnimation setDuration:0.3];
        presentaionAnimation.delegate = self;
        presentaionAnimation.removedOnCompletion = NO;
        presentaionAnimation.fillMode = kCAFillModeBoth;
        [viewControllerToPresent.view.layer addAnimation:presentaionAnimation forKey:@"Rotation"];
    }
    [super presentViewController:viewControllerToPresent animated:NO completion:completion];
   
}
-(void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion
{
    
    if(flag==YES)
    {
        [animationLayer removeFromSuperlayer];
        [self.view.window.layer addSublayer:animationLayer];
        //Load the CALayer Animation Layer with the Presenting view bitmap
        [self LoadLayerWithImage];
        
        
        CATransform3D rotationIdentity = CATransform3DIdentity;
        rotationIdentity.m34 = 1.0/-550;
        self.view.window.layer.sublayerTransform = rotationIdentity;
        
        
        //Dismiss the presented view
        
        CABasicAnimation *RotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
        CATransform3D rotationTransform = CATransform3DMakeRotation(M_PI*0.1, 1.0, 0.0, 0.0);
        [RotateAnimation setFromValue:[NSValue valueWithCATransform3D:rotationTransform]];
        [RotateAnimation setToValue:[NSValue valueWithCATransform3D:CATransform3DIdentity]];
        [RotateAnimation setDuration:0.3];
        RotateAnimation.delegate = self;
        RotateAnimation.removedOnCompletion = NO;
        RotateAnimation.fillMode = kCAFillModeBoth;
        self.presentingViewController.view.layer.position = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height);
        self.presentingViewController.view.layer.anchorPoint = CGPointMake(0.5, 1.0);
        [self.presentingViewController.view.layer addAnimation:RotateAnimation forKey:@"Rotation"];
        
        // Animate the Presented View copied to the Animation layer
        
        CABasicAnimation *presentaionAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
        [presentaionAnimation setFromValue:[NSValue valueWithCATransform3D:CATransform3DIdentity]];
        [presentaionAnimation setToValue:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, self.view.frame.size.height, 0)]];
        
        [presentaionAnimation setDuration:0.3];
        presentaionAnimation.delegate = self;
        presentaionAnimation.removedOnCompletion = NO;
        presentaionAnimation.fillMode = kCAFillModeBoth;
        [animationLayer addAnimation:presentaionAnimation forKey:@"Rotation"];
        
        
    }
    [super dismissViewControllerAnimated:NO completion:completion];
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [animationLayer setContents:nil];
    
    
}
@end
