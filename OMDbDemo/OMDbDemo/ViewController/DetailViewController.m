//
//  DetailViewController.m
//  OMDbDemo
//
//  Created by Prabhat on 08/12/15.
//  Copyright © 2015 TomarTech. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (nonatomic, weak) IBOutlet UILabel *lblTitle;
@property (nonatomic, weak) IBOutlet UIImageView *imgPoster;
@property (nonatomic, weak) IBOutlet UILabel *lblYear;
@property (nonatomic, weak) IBOutlet UILabel *lblCast;
@property (nonatomic, weak) IBOutlet UITextView *lblPlot;
//@property (nonatomic, weak) IBOutlet UILabel *imgPoster;

@end


@implementation DetailViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  Back Button action to pop controller.
 */
-(IBAction) btnBackPressed:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

/**
 *  To set all data on UI
 */
-(void) setUI {
    
    [_lblTitle setText:[_dicSource valueForKey:@"Title"]];
    [_lblYear setText:[_dicSource valueForKey:@"Year"]];
    [_lblCast setText:[_dicSource valueForKey:@"Title"]];
    [_lblPlot  setText:[_dicSource valueForKey:@"Actors"]];
    
    NSString *strPoster = [_dicSource valueForKey:@"Poster"];
    
    if (strPoster.length>10) {
            [_imgPoster setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:strPoster]]]];
    }
    
}

@end
