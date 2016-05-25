//
//  ImageViewController.m
//  Imaginarium
//
//  Created by Leo Peng on 5/24/16.
//  Copyright © 2016 Leo Peng. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController () <UIScrollViewDelegate>
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIImage *image;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@end

@implementation ImageViewController

- (void)setScrollview:(UIScrollView *)scrollview {
    _scrollview = scrollview;
    _scrollview.minimumZoomScale = 0.2;
    _scrollview.maximumZoomScale = 2.0;
    _scrollview.delegate = self;
    self.scrollview.contentSize = self.image ? self.image.size : CGSizeZero;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (void)setImageURL:(NSURL *)imageURL {
    _imageURL = imageURL;
    [self startDownloadingImage];
}

- (void)startDownloadingImage {
    self.image = nil;
    if (self.imageURL) {
        [self.spinner stopAnimating];
        NSURLRequest *request = [NSURLRequest requestWithURL:self.imageURL];
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
        NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable localfile, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (!error) {
                if ([request.URL isEqual:self.imageURL]) {
                    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:localfile]];
                    [self performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:NO];
                }
            }
        }];
        [task resume];
    }
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    
    return _imageView;
}

- (UIImage *)image {
    return self.imageView.image;
}

- (void)setImage:(UIImage *)image {
    self.imageView.image = image;
    [self.imageView sizeToFit];
    self.scrollview.contentSize = self.image ? self.image.size : CGSizeZero;
    [self.spinner stopAnimating];
    self.scrollview.zoomScale = 0.5;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.scrollview addSubview:self.imageView];
}
@end
