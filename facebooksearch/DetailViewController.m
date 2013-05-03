//
//  DetailViewController.m
//  facebooksearch
//
//  Created by Ringo on 5/3/56 BE.
//  Copyright (c) 2556 Bazaku. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil content:(NSDictionary*)content
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        contentData = [content retain];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [tap setNumberOfTapsRequired:1];
    [tap setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:tap];
    [tap release];
    
    self.nameLabel.text = [[contentData objectForKey:@"from"] objectForKey:@"name"];
    self.dateLabel.text = [contentData objectForKey:@"updated_time"];
    NSString *messageString = [contentData objectForKey:@"message"];
    if(messageString != nil){
        self.messageLabel.text = messageString;
        [self.messageLabel sizeToFit];
        CGSize contentSize = CGSizeMake(self.view.bounds.size.width, self.messageLabel.frame.origin.y + self.messageLabel.frame.size.height + 10);
        [self.textView setContentSize:contentSize];
        if (contentSize.height > self.view.frame.size.height) {
            contentSize.height = self.view.frame.size.height;
        }
        CGRect f = self.textView.frame;
        f.size.height = contentSize.height;
        self.textView.frame = f;
    }
    NSURL *profilePictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://graph.facebook.com/%@/picture",[[contentData objectForKey:@"from"] objectForKey:@"id"]]];
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:profilePictureURL cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:5.0] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *urlData, NSError *error) {
        if(!error){
            [self.profileImageView setImage:[UIImage imageWithData:urlData]];
        }
    }];
    NSString *pictureUrlString = [contentData objectForKey:@"picture"];
    if(pictureUrlString != nil){
        pictureUrlString = [pictureUrlString stringByReplacingOccurrencesOfString:@"s.jpg" withString:@"n.jpg"];
        NSURL *profilePictureURL = [NSURL URLWithString:pictureUrlString];
        [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:profilePictureURL cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:5.0] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *urlData, NSError *error) {
            if(!error){
                [self.photoImageView setImage:[UIImage imageWithData:urlData]];
                [self.photoImageView setHidden:NO];
            }
        }];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) dealloc{
    [contentData release];
    contentData = nil;
    self.nameLabel = nil;
    self.dateLabel = nil;
    self.messageLabel = nil;
    self.profileImageView = nil;
    self.photoImageView = nil;
    self.textView = nil;
    [super dealloc];
}

-(void) tap:(UITapGestureRecognizer*)tap{
    if(self.photoImageView.isHidden){
        return;
    }
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        if(self.textView.hidden){
            [self.textView setHidden:NO];
            self.textView.alpha = 1;
        }else{
            self.textView.alpha = 0;
        }
    } completion:^(BOOL finished) {
        if(self.textView.alpha == 0){
            [self.textView setHidden:YES];
        }else{
            [self.textView setHidden:NO];
        }
    }];
}

@end
