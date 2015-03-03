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
    NSTimer *count_down;
    NSUserDefaults *defaults;
    
    IBOutlet UIImageView *gate_view;
    IBOutlet UILabel *timer_label;
    IBOutlet UILabel *plas_label;
    IBOutlet UILabel *score_label;
    IBOutlet UILabel *fscore_label;
    IBOutlet UILabel *koment_label;

    
    int del_Nb;
    int key_Nb;
    int stage_Nb;
    int remainingKeies_Nb;
    int yes_no_Nb[100];
    int count;
    int score;
    int plas_Nb;
    long bestscore;
    int gamemode_Nb;//0=最初の画面 1= 一時停止中　2＝ゲーム中モード０
    int poizen_Nb;
    
    
    
}

-(void)panAction:(UIPanGestureRecognizer *)sender;
-(void)down;
-(void)kekka;
-(IBAction)stop;
-(IBAction)reset;
-(IBAction)shokika;

@end

