//
//  ViewController.swift
//  SwiftFacbook
//
//  Created by Prabhat on 04/11/15.
//  Copyright © 2015 Innoeye. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class HomeViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    @IBOutlet weak var btnFBLogin: FBSDKLoginButton!
    
    @IBOutlet weak var viewDescription: UIView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var profilePic: FBSDKProfilePictureView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnFBLogin.readPermissions = ["public_profile" ,"email", "user_friends"]
        self.viewDescription.hidden = true;
        self.fetchUserInfo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!){
        
    }
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        
    }
    
    func loginButtonWillLogin(loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
    
    func fetchUserInfo () {
        if FBSDKAccessToken.currentAccessToken() == nil {
            return
        }
        self.viewDescription.hidden = false
        let request: FBSDKGraphRequest = FBSDKGraphRequest.init(graphPath: "/me", parameters: nil)
        request.startWithCompletionHandler { (connection:FBSDKGraphRequestConnection!, result:AnyObject!, error:NSError!) -> Void in
            
        }
        
        
    }
}

