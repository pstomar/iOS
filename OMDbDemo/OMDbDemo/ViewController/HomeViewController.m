//
//  ViewController.m
//  OMDbDemo
//
//  Created by Prabhat on 08/12/15.
//  Copyright © 2015 TomarTech. All rights reserved.
//

#import "HomeViewController.h"
#import "DetailViewController.h"

@interface HomeViewController ()
{
    NSArray *dataSource;
    NSString *strToSearch;
    DetailViewController *detailVC;
    UIAlertView *alertView;
    UIActivityIndicatorView *loader;
}
@property (nonatomic, weak) IBOutlet UITextField *txtSearch;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UIView *viewNoData;

@end

#define window [UIApplication sharedApplication].keyWindow
@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_txtSearch.text.length == 0) {
        [_viewNoData setHidden:NO];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark table delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataSource.count;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    NSDictionary *data= [dataSource objectAtIndex:indexPath.row];
    
    [cell.textLabel  setText:[data valueForKey:@"Title"]];
    [cell.detailTextLabel  setText:[data valueForKey:@"Year"]];    
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self getMovieDetails:[dataSource objectAtIndex:indexPath.row]];
}

#pragma mark textfield delegates
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    strToSearch = [_txtSearch.text stringByTrimmingCharactersInSet:
                   [NSCharacterSet whitespaceCharacterSet]];
    
    
    [_txtSearch resignFirstResponder];
    [self searchMovie];
    return YES;
}

-(void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    strToSearch = [_txtSearch.text stringByTrimmingCharactersInSet:
    [NSCharacterSet whitespaceCharacterSet]];
    if (strToSearch.length == 0) {
        [_viewNoData setHidden:NO];
        [_txtSearch setText:@""];
    }
    [_txtSearch resignFirstResponder];
}

#pragma utilities
/**
 *  To search movies over omdb api and also to show data on
 *  table view.
 */
-(void) searchMovie {
    [self startLoader];
    if (strToSearch.length == 0) {
        return;
    }
    NSString *urlStr = [NSString stringWithFormat:@"http://www.omdbapi.com/?r=json&type=movie&s=%@",strToSearch];
    urlStr = [urlStr stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    
    NSLog(@"%@",urlStr);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlStr]];
    [request setHTTPMethod:@"GET"];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        [self stopLoader];
        if (connectionError) {
            NSLog(@"%@",connectionError);
            [self showAlertView];
            return;
        }
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        if (dict) {
            dataSource = [dict valueForKey:@"Search"];
            if (dataSource.count>0) {
                [_viewNoData setHidden:YES];
            }else{
                [_viewNoData setHidden:NO];
            }
        }
        [self.tableView reloadData];
        
    }];
}

/**
 *  To fetch all information about a perticular movie through id
 *  and show all on detail view controller
 */
-(void) getMovieDetails:(NSDictionary*) dicSource {
    [self startLoader];
    NSString *urlStr = [NSString stringWithFormat:@"http://www.omdbapi.com/?r=json&type=movie&i=%@",[dicSource valueForKey:@"imdbID"]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlStr]];
    [request setHTTPMethod:@"GET"];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        [self stopLoader];
        if (connectionError) {
            [self showAlertView];
            return;
        }
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        if (detailVC==nil) {
            detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
        }
        detailVC.dicSource = dict;
        [self.navigationController pushViewController:detailVC animated:YES];
        
    }];
}

/**
 *  To show Connection Error.
 *
 */
-(void) showAlertView {
    if (alertView == nil) {
        alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Error on fetching data." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    }
    [alertView show];
}

/**
 *  To show loader on center of screen and stop user interaction on controller.
 *
 */
-(void) startLoader {
    if (loader == nil) {
        loader = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        loader.center = self.view.center;
    }
    [window addSubview:loader];
    [loader startAnimating];
    [self.view setUserInteractionEnabled:NO];
}

/**
 *  To hide loader from screen and enable user interaction.
 *
 */
-(void) stopLoader {
    [loader stopAnimating];
    [loader removeFromSuperview];
    [self.view setUserInteractionEnabled:YES];
}

@end
