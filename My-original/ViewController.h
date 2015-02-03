//
//  ViewController.h
//  My-original
//
//  Created by 中村　龍太郎 on 2015/01/13.
//  Copyright (c) 2015年 中村　龍太郎. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIGestureRecognizerDelegate>
{
    UIView *player_view;
    
    UIView *key_view[100];
    
    IBOutlet UIImageView *gate_view;
    
    int del_Nb;
    int key_Nb;
    int stage_Nb;
}

-(void)panAction:(UIPanGestureRecognizer *)sender;

-(IBAction)reset;
@end

