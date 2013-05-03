//
//  ViewController.m
//  facebooksearch
//
//  Created by Ringo on 5/3/56 BE.
//  Copyright (c) 2556 Bazaku. All rights reserved.
//

#import "ViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "SearchCell.h"
#import "DetailViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) dealloc{
    self.table = nil;
    self.searchField = nil;
    self.busy = nil;
    [searchResult release];
    searchResult = nil;
    [super dealloc];
}

-(IBAction)search:(id)sender{
    [self.searchField resignFirstResponder];
    [self.busy startAnimating];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                   self.searchField.text, @"q",
                                   nil];
    
    [FBRequestConnection startWithGraphPath:@"search" parameters:params HTTPMethod:@"GET"
                          completionHandler:^(FBRequestConnection *connection, NSDictionary *result, NSError *error) {
                              [self.busy stopAnimating];
                              if (error) {
                                    //error
                                    NSLog(@"error: %@",[error localizedDescription]);
                                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"dismiss" otherButtonTitles:nil];
                                    [alert show];
                                    [alert release];
                                    return ;
                              }
                              [searchResult release];
                              searchResult = [[result objectForKey:@"data"] retain];
                              [self.table reloadData];
                          }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [searchResult count];
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID = @"searchcell";
    SearchCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil){
        cell = [[[SearchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] autorelease];
    }
    NSDictionary *content = [searchResult objectAtIndex:indexPath.row];
    [cell setContent:content];
    return cell;
}

-(float) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [SearchCell cellHeightFromData:[searchResult objectAtIndex:indexPath.row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *content = [searchResult objectAtIndex:indexPath.row];
    DetailViewController *detail = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil content:content];
    [self.navigationController pushViewController:detail animated:YES];
    [detail release];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [self search:nil];
    return YES;
}

@end
