//
//  ViewController.m
//  My-original
//
//  Created by 中村　龍太郎 on 2015/01/13.
//  Copyright (c) 2015年 中村　龍太郎. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    player_view = [[UIImageView alloc]initWithFrame:CGRectMake(230, 510, 80, 80)];
    
    player_view.backgroundColor = [UIColor blackColor];
   
    
    [self.view addSubview:player_view];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panAction:)];
    
    [player_view addGestureRecognizer:pan];
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)panAction:(UIPanGestureRecognizer *)sender
{
    CGPoint p = [sender translationInView:self.view];
    
    CGPoint movedPoint = CGPointMake(player_view.center.x + p.x, player_view.center.y + p.y);
    
    player_view.center = movedPoint;
    
    [sender setTranslation:CGPointZero inView:self.view];
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        player_view.center = CGPointMake(270, 550);
        
       
    if (CGRectContainsPoint(gate_view.frame, player_view.center)) {
        NSLog(@"成功");
        stage_Nb = stage_Nb + 1;
        [self makeKey];
        
    } 
        
        
        
    }
    
}

-(void)makeKey{
    key_Nb = 0;
    while (key_Nb < stage_Nb) {
        int Xrandum =arc4random_uniform(275) + 50;
        int Yrandum =arc4random_uniform(390) + 45;
        
        key_view[key_Nb] = [[UIImageView alloc]initWithFrame:CGRectMake(Xrandum, Yrandum, 50, 50)];
        
        key_view[key_Nb].backgroundColor = [UIColor yellowColor];
        
        [self.view addSubview:key_view[key_Nb]];
        
        key_Nb = key_Nb ++;
    }
}


-(IBAction)reset{
    
}
@end
