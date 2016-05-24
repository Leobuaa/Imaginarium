//
//  ViewController.m
//  Imaginarium
//
//  Created by Leo Peng on 5/24/16.
//  Copyright © 2016 Leo Peng. All rights reserved.
//

#import "ViewController.h"
#import "ImageViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[ImageViewController class]]) {
        ImageViewController *ivc = (ImageViewController *)segue.destinationViewController;
        ivc.imageURL = [NSURL URLWithString:[self imageURLFromIdentifier:segue.identifier]];
        ivc.title = segue.identifier;
    }
}

- (NSString *)imageURLFromIdentifier:(NSString *)identifier {
    NSArray *keys = @[@"image_1", @"image_2", @"image_3"];
    NSArray *values = @[@"http://ww2.sinaimg.cn/mw1024/005YrQnjjw1f414v0gxkaj31jk2224qq.jpg",
                        @"http://ww2.sinaimg.cn/mw1024/005YrQnjjw1f414uyjl5kj31jk222e81.jpg",
                        @"http://ww1.sinaimg.cn/mw1024/005YrQnjgw1f3enzn0qj2j32wa40eu0x.jpg"];
    NSDictionary *imageURLDictionary = [[NSDictionary alloc]initWithObjects:values forKeys:keys];
    NSLog(@"%@", [imageURLDictionary objectForKey:identifier]);
    return [imageURLDictionary objectForKey:identifier];
}

@end
