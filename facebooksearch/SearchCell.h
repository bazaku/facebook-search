//
//  SearchCell.h
//  facebooksearch
//
//  Created by Ringo on 5/3/56 BE.
//  Copyright (c) 2556 Bazaku. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UILabel *messageLabel;
@property (nonatomic, retain) IBOutlet UIImageView *profileImageView;
@property (nonatomic, retain) IBOutlet UIView *contentView;

-(void) setContent:(NSDictionary*)content;

+(float) cellHeightFromData:(NSDictionary*)_data;

@end
