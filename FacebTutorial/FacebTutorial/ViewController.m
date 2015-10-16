//
//  ViewController.m
//  FacebTutorial
//
//  Created by Prabhat on 05/10/15.
//  Copyright © 2015 Innoeye. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet FBSDKLoginButton *loginButton;
@property (weak, nonatomic) IBOutlet FBSDKProfilePictureView *profilePicture;
@property (weak, nonatomic) IBOutlet FBSDKLikeButton *likeButton;
@property (weak, nonatomic) IBOutlet UILabel *lblUsername;

@end

@implementation ViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    _loginButton.readPermissions = @[@"public_profile" ,@"email", @"user_friends"];
    [self fetchUserInfo];
    
    _likeButton.objectID = @"https://www.facebook.com/ISRO";
    [_likeButton addTarget:self action:@selector(onLikeClicked:) forControlEvents:UIControlEventValueChanged];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) onLikeClicked:(UIControlEvents) event {
    
}


- (void) loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error {
    
    [self fetchUserInfo];
    
}

- (IBAction)btnFriendListClicked:(id)sender {
    FBSDKAppInviteContent *content =[[FBSDKAppInviteContent alloc] init];
    content.appLinkURL = [NSURL URLWithString:@"https://www.facebook.com/myapps"];
    //optionally set previewImageURL
    content.appInvitePreviewImageURL = [NSURL URLWithString:@"https://pbs.twimg.com/profile_images/570569180840083456/bbF0osO_.png"];
    
    // present the dialog. Assumes self implements protocol `FBSDKAppInviteDialogDelegate`
    [FBSDKAppInviteDialog showFromViewController:self withContent:content delegate:self];
}



- (void) loginButtonDidLogOut:(FBSDKLoginButton *)loginButton {
    _lblUsername.text = @"";
    _profilePicture.profileID = nil;
    [_profilePicture setNeedsImageUpdate];
}

- (void) fetchUserInfo {
    if(FBSDKAccessToken.currentAccessToken == nil)
        return;
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc] initWithGraphPath:@"/me" parameters:nil];
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
        if (result) {
            _lblUsername.text = [result valueForKey:@"name"];
            _profilePicture.profileID = [result valueForKey:@"id"];
            [_profilePicture setNeedsImageUpdate];
        }
        
    }];
}


- (void)appInviteDialog:(FBSDKAppInviteDialog *)appInviteDialog didCompleteWithResults:(NSDictionary *)results {
    
}

- (void)appInviteDialog:(FBSDKAppInviteDialog *)appInviteDialog didFailWithError:(NSError *)error {
    
}

@end
