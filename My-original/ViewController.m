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
    
    int VV;
    for (VV = 0; VV <= 99; VV = VV + 1) {
        yes_no_Nb[VV] = 0;
    }
    
    
    
    remainingKeies_Nb = 0;
    
    
    player_view = [[UIView alloc]initWithFrame:CGRectMake(230, 510, 80, 80)];
    
    player_view.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:player_view];
   
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panAction:)];

    [player_view addGestureRecognizer:pan];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//
- (void)panAction:(UIPanGestureRecognizer *)sender
{

    CGPoint p = [sender translationInView:self.view];

    CGPoint movedPoint = CGPointMake(player_view.center.x + p.x, player_view.center.y + p.y);
    
    player_view.center = movedPoint;
     NSLog(@"移動中");
    [self Getkeys];
    
    [sender setTranslation:CGPointZero inView:self.view];
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        
       NSLog(@"ストップ");
    if (CGRectContainsPoint(gate_view.frame, player_view.center)) {
        NSLog(@"ゲート到着");
        if (remainingKeies_Nb <= 0) {
             NSLog(@"成功");
        stage_Nb = stage_Nb + 1;
        [self makeKey];
        } else {
            NSLog(@"失敗");
        }
       
        
    }
        player_view.center = CGPointMake(270, 550);
        NSLog(@"戻す");
        
    }
    
}

-(void)makeKey{
    key_Nb = 0;
    while (key_Nb < stage_Nb) {
        int Xrandum =arc4random_uniform(275) + 25;
        int Yrandum =arc4random_uniform(390) + 45;
        
        key_view[key_Nb] = [[UIImageView alloc]initWithFrame:CGRectMake(Xrandum, Yrandum, 50, 50)];
        
        key_view[key_Nb].backgroundColor = [UIColor yellowColor];
        yes_no_Nb[key_Nb] = 1;
        [self.view addSubview:key_view[key_Nb]];
        
        key_Nb = key_Nb + 1 ;
        remainingKeies_Nb =remainingKeies_Nb + 1 ;
        
        

    }
    [self.view bringSubviewToFront:player_view];
             NSLog(@"ステージ作成");
}

-(void)Getkeys{
    del_Nb = 0;
    while ( del_Nb < stage_Nb) {
        
        if (CGRectContainsPoint(key_view[del_Nb].frame, player_view.center )&& yes_no_Nb[del_Nb] == 1){
            
            [key_view[del_Nb] removeFromSuperview];
            remainingKeies_Nb = remainingKeies_Nb - 1;
            NSLog(@"鍵ゲット");
            yes_no_Nb[del_Nb] = 0;

            
        }
        
        del_Nb = del_Nb + 1;
    }
}


-(IBAction)reset{
    int VV;
    for (VV = 0; VV <= 99; VV = VV + 1) {
        yes_no_Nb[VV] = 0;
        [key_view[VV] removeFromSuperview];
    }
    stage_Nb = 0;
    remainingKeies_Nb = 0;
}
@end
