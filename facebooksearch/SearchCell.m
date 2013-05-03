//
//  SearchCell.m
//  facebooksearch
//
//  Created by Ringo on 5/3/56 BE.
//  Copyright (c) 2556 Bazaku. All rights reserved.
//

#import "SearchCell.h"

@implementation SearchCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [[NSBundle mainBundle] loadNibNamed:@"SearchCell" owner:self options:nil];
        [self addSubview:self.contentView];
    }
    return self;
}

-(void) dealloc{
    self.nameLabel = nil;
    self.messageLabel = nil;
    self.profileImageView = nil;
    self.contentView = nil;
    [super dealloc];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setContent:(NSDictionary*)content{
    self.profileImageView.image = nil;
    self.nameLabel.text = [[content objectForKey:@"from"] objectForKey:@"name"];
    //NSLog(@"%@",data);
    self.messageLabel.text = [content objectForKey:@"message"];
    CGRect f = self.messageLabel.frame;
    f.size.width = 262.0;
    self.messageLabel.frame = f;
    [self.messageLabel sizeToFit];
    NSURL *profilePictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://graph.facebook.com/%@/picture",[[content objectForKey:@"from"] objectForKey:@"id"]]];
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:profilePictureURL cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:5.0] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *urlData, NSError *error) {
        if(!error){
            [self.profileImageView setImage:[UIImage imageWithData:urlData]];
        }
    }];
}

+(float) cellHeightFromData:(NSDictionary*)_data{
    NSString *text = [_data objectForKey:@"message"];
    float messageHeight = [text sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(252.0, 10000.0) lineBreakMode:NSLineBreakByWordWrapping].height;
    float height = messageHeight+29;
    if(height < 60){
        height = 60;
    }
    return height;
}

@end
