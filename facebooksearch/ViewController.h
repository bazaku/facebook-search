//
//  ViewController.h
//  facebooksearch
//
//  Created by Ringo on 5/3/56 BE.
//  Copyright (c) 2556 Bazaku. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
    NSArray *searchResult;
}

@property (nonatomic, retain) IBOutlet UITextField *searchField;
@property (nonatomic, retain) IBOutlet UITableView *table;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *busy;

-(IBAction)search:(id)sender;

@end
