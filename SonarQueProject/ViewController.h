//
//  ViewController.h
//  SonarQueProject
//
//  Created by bairdweng on 2022/9/23.
//

#import <UIKit/UIKit.h>


@protocol ViewControllerDelegate <NSObject>

- (void)testFun;

@end

@interface ViewController : UIViewController


@end

