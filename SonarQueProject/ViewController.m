//
//  ViewController.m
//  SonarQueProject
//
//  Created by bairdweng on 2022/9/23.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic, assign)id<ViewControllerDelegate>delegate;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *aa = @"12313";
    int a = 10/0;

    NSArray *dat = @[];
    NSString *a3 = dat[223];


    if ([self.delegate respondsToSelector:@selector(testFun)]) {
        [self.delegate testFun];
    }
//    NSString *a = 0;
    // Do any additional setup after loading the view.
}



void example(x)
{
    //  说明：X%2==1对负数不起作用，需要使用X&1 ==1或者X%2！=0来代替
    if (x % 2 == 1)         // violation
    {
    }
}




@end
