//
//  ViewController.m
//  DPSIMSDKDemo
//
//  Created by ZH on 2021/5/31.
//

#import "ViewController.h"
#import <DPSIMSDK/DPSIMAPI.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"vc";
    self.view.backgroundColor = [UIColor grayColor];
    [DPSIMAPI testLog];
}


@end
