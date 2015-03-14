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
    
     UIImage *img_sheep = [UIImage imageNamed:@"image001.png"];

   
    
    koment_label.text = @"黒を赤に持ってくとスタートだ！";
    score = 0;
    count = 10;
    plas_Nb = 0;
    
    int VV;
    for (VV = 0; VV <= 99; VV = VV + 1) {
        yes_no_Nb[VV] = 0;
        
    }
    gamemode_Nb = 0;
    
    remainingKeies_Nb = 0;
    
    
    player_view = [[UIImageView alloc]initWithFrame:CGRectMake(230, 510, 80, 80)];
    
    player_view.image = [[UIImageView alloc] initWithImage:img_sheep];
    [self.view addSubview:player_view];
   
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panAction:)];

    [player_view addGestureRecognizer:pan];
    
    defaults = [NSUserDefaults standardUserDefaults];
    bestscore = [defaults integerForKey:@"memo"];
    if (bestscore ==!0) {
        plas_label.text = [NSString stringWithFormat:@"今までのベスト%li点",bestscore];
    }
    
    

    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//
- (void)panAction:(UIPanGestureRecognizer *)sender
{

    
        
    
    
    
    if ( count > 0 && gamemode_Nb != 1 &&  gamemode_Nb != 4)  {
       
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
            
            if (![count_down isValid]) {
                count_down = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                          target:self
                                                        selector:@selector(down)
                                                        userInfo:nil
                                                         repeats:YES];
                gamemode_Nb = 2;
            }
            score = score + plas_Nb;
            count = count + stage_Nb ;
            if (count > 30) {
                count = 30 ;
            }
            
            stage_Nb = stage_Nb + 1;
            
            timer_label.text = [NSString stringWithFormat:@"%i",count];
            plas_label.text = @"";
            score_label.text = [NSString stringWithFormat:@"%i",score];
            
            int AS = 10;
            while (AS < stage_Nb) {
                [key_view[AS] removeFromSuperview];
                AS = AS + 1;
            }
            
            [enemy_view removeFromSuperview];
            
        [self makeKey];
            
        } else {
            NSLog(@"失敗");
        }
       
        
    }else{
        NSLog(@"やり直し");
        
        plas_Nb = 0;
        plas_label.text = @"";
        key_Nb = 0;
        while (key_Nb < stage_Nb) {
            if (yes_no_Nb [key_Nb]== 0) {
                            yes_no_Nb[key_Nb] = 1;
            
            [self.view addSubview:key_view[key_Nb]];
            
            remainingKeies_Nb =remainingKeies_Nb + 1 ;
            }
            
            
            key_Nb = key_Nb + 1 ;
        }
        
    }
        player_view.center = CGPointMake(270, 550);
        NSLog(@"戻す");
        
    }
    
    }else {
        
        
        if (sender.state == UIGestureRecognizerStateEnded && gamemode_Nb == 4) {
            gamemode_Nb = 2;
        }
        NSLog(@"動きません");
    }
}

-(void)makeKey{
    
    if (stage_Nb == 1) {
        koment_label.text = @"";
    }
    
    
    if (stage_Nb % 5 == 0) {
        int Xenrmy =arc4random_uniform(205) + 35;
        int Yenemy =arc4random_uniform(315) + 45;
    
        enemy_view = [[UIImageView alloc]initWithFrame:CGRectMake(Xenrmy, Yenemy, 120, 120)];
        enemy_view.backgroundColor =[UIColor brownColor];
        [self.view addSubview:enemy_view];
    }
    

    
    
    
    
    key_Nb = 0;
    while (key_Nb < stage_Nb) {
         int Xrandum =arc4random_uniform(275) + 35;
         int Yrandum =arc4random_uniform(390) + 45;
        
        yes_no_Nb[key_Nb] = 1;
        key_view[key_Nb] = [[UIImageView alloc]initWithFrame:CGRectMake(Xrandum, Yrandum, 50, 50)];
        
        
        
        
        if (key_Nb > 9) {
            key_view[key_Nb].backgroundColor = [UIColor purpleColor];
          
        }else{
            key_view[key_Nb].backgroundColor = [UIColor yellowColor];

            remainingKeies_Nb =remainingKeies_Nb + 1 ;
        }
        
        
        if (CGRectContainsPoint(enemy_view.frame, key_view[key_Nb].center)) {
            NSLog(@"dameda");
            if (key_Nb <= 9) {
                remainingKeies_Nb =remainingKeies_Nb - 1 ;

            }
            
            
        }else{
            
            [self.view addSubview:key_view[key_Nb]];
        NSLog(@"OK");
        key_Nb = key_Nb + 1 ;
        }
        
    }
    [self.view bringSubviewToFront:player_view];
             NSLog(@"ステージ作成");
}

-(void)Getkeys{
    del_Nb = 0;
    while ( del_Nb < stage_Nb) {
        
        if (CGRectContainsPoint(key_view[del_Nb].frame, player_view.center )&& yes_no_Nb[del_Nb] == 1){
            
            [key_view[del_Nb] removeFromSuperview];
            yes_no_Nb[del_Nb] = 0;

            if (del_Nb < 10) {
                NSLog(@"鍵ゲット");
                remainingKeies_Nb = remainingKeies_Nb - 1;
                
                        plas_Nb = plas_Nb + 100 +count;
            plas_label.text = [NSString stringWithFormat:@"+%i",plas_Nb];

            }else{
                NSLog(@"毒だ！！！");
                count = count - 5;
                if (count <= 0) {
                    count = 1;
                }
                timer_label.text = [NSString stringWithFormat:@"%i",count];
                
                
            }
            
           
            
        }
        
        del_Nb = del_Nb + 1;
    }
    
    
    if (CGRectContainsPoint(enemy_view.frame, player_view.center) && stage_Nb % 5 == 0) {
        NSLog(@"やり直し");
        
        plas_Nb = 0;
        plas_label.text = @"";
        key_Nb = 0;
        while (key_Nb < stage_Nb) {
            if (yes_no_Nb [key_Nb]== 0) {
                yes_no_Nb[key_Nb] = 1;
                
                [self.view addSubview:key_view[key_Nb]];
                
                remainingKeies_Nb =remainingKeies_Nb + 1 ;
            }
            
            
            key_Nb = key_Nb + 1 ;
        }
        
    
    player_view.center = CGPointMake(270, 550);
    NSLog(@"戻す");
        gamemode_Nb = 4;
    
    }
    
    
    
    
    
}




-(void)down{
    count = count - 1;
    
    if (count < 6 && count > 0) {
        timer_label.textColor = [UIColor redColor];
        koment_label.text = @"時間が危ないぞ！";
    }else if (count <= 0 ){
        
        
        int VV;
        for (VV = 0; VV <= 99; VV = VV + 1) {
            yes_no_Nb[VV] = 0;
            [key_view[VV] removeFromSuperview];
        }
        
        if ([count_down isValid]) {
            [count_down invalidate];

        }
        
        [enemy_view removeFromSuperview];
         NSLog(@"time up");
        
        player_view.center = CGPointMake(270, 550);
        NSLog(@"戻す");
        
        plas_label.text = @"";

        timer_label.text = [NSString stringWithFormat:@"%i",count];
        [self kekka];
        
        gamemode_Nb = 0;
        
        
    }else{
        timer_label.textColor = [UIColor blackColor];
        koment_label.text = @"";
    }
    timer_label.text = [NSString stringWithFormat:@"%i",count];
}

-(void)kekka{
    NSLog(@"結果発表");
    
    koment_label.text = @"";
    int KK = 0;
   
    while (KK < score) {
        [[NSRunLoop currentRunLoop]
         runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.0000000001]
         ];
        KK = KK +1 ;
        fscore_label.text = [NSString stringWithFormat:@"%i点",KK];
        
        
    }
    
    
    
    //点数表示
    bestscore = 0;
    defaults = [NSUserDefaults standardUserDefaults];
    bestscore = [defaults integerForKey:@"memo"];
    
    if (score > bestscore) {
        defaults = [NSUserDefaults standardUserDefaults];
        [defaults setInteger:score forKey:@"memo"];
        NSLog(@"記録更新");
        koment_label.text = @"記録更新おめでとう";
    }else{
        koment_label.text = @"頑張ろう";
        
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
    plas_Nb = 0;
    plas_label.text = @"";
    score = 0;
    count = 10;
    timer_label.text = [NSString stringWithFormat:@"%i",count];
    score_label.text = [NSString stringWithFormat:@"%i",score];
    
    koment_label.text = @"黒を赤に持ってくとスタートだ！";
    fscore_label.text = @"";
    timer_label.textColor = [UIColor blackColor];

    defaults = [NSUserDefaults standardUserDefaults];
    bestscore = [defaults integerForKey:@"memo"];
    
    plas_label.text = [NSString stringWithFormat:@"今までのベスト%li点",bestscore];
    if (bestscore ==0) {
        plas_label.text = @"";
    }

    
    if ([count_down isValid]) {
        [count_down invalidate];
        }
    gamemode_Nb = 0;

    
     NSLog(@"最初から");
}

-(IBAction)shokika{
    UIAlertView *zero = [[UIAlertView alloc]initWithTitle:@"警告だよ！"
                                                   message:@"bestscoreをゼロにします。よろしいですか？"
                                                  delegate:self
                                         cancelButtonTitle:@"キャンセル"
                                         otherButtonTitles:@"OK", nil];
    [zero show];
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if( buttonIndex != alertView.cancelButtonIndex )
    {
        [defaults setInteger:0 forKey:@"memo"];
        plas_label.text = @"";

    }
}


-(IBAction)stop{
    
    if (count > 0 && gamemode_Nb != 0 && gamemode_Nb != 1) {
        NSLog(@"ボタン");
    
    koment_label.text = @"一時停止中";
        
        if ([count_down isValid]) {
        [count_down invalidate];
        
        }
    
        
        
    NSLog(@"一時停止");
    
        
        
        player_view.center = CGPointMake(270, 550);
    NSLog(@"戻す");
    
        plas_Nb = 0;
    
        plas_label.text = @"";
    
        
        
        key_Nb = 0;
        
        while (key_Nb < stage_Nb) {
        
        if (yes_no_Nb [key_Nb]== 0) {
            yes_no_Nb[key_Nb] = 1;
            
            [self.view addSubview:key_view[key_Nb]];
            
            remainingKeies_Nb =remainingKeies_Nb + 1 ;
            
            
            }
        key_Nb = key_Nb +1;
    
    
        
        gamemode_Nb = 1;
    
    }
    fscore_label.text = @"";
        
    }else if(gamemode_Nb == 1){
        
        NSLog(@"再会");
        
        
        if (![count_down isValid]) {
            count_down = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                          target:self
                                                        selector:@selector(down)
                                                        userInfo:nil
                                                         repeats:YES];
        }
    gamemode_Nb = 2;
    
    }





}
@end
