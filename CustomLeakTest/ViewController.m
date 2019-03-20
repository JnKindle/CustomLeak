//
//  ViewController.m
//  CustomLeakTest
//
//  Created by Jn on 2019/3/20.
//  Copyright © 2019年 DaiMaZhenYa. All rights reserved.
//

#import "ViewController.h"
#import "OneController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)next:(id)sender {
    OneController *vc = [[OneController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
