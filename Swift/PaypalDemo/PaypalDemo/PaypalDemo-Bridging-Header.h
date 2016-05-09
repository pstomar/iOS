//
//  Use this file to import your target's public headers that you would like to expose to Swift.
//

#import "PayPalPayment.h"
#import "PayPalConfiguration.h"
#import "PayPalMobile.h"
#import "PayPalPaymentViewController.h"



/*******************  Setup Project for PayPal  **************************
 
1. setup cocoapod for paypal framework
2. setup bridging-header for objective-c and swift communication
3. setup didfinishlaunchingwithoptions method in appdelegate for paypal framework launching
    with original clientId generated from paypal site
4. setup delegate methods of PayPalPaymentDelegate in your ViewController.
5. create Object of PayPalPayment and set it up
6. on button tap on payment setup payment description
7. if payment is processable then launch PayPalPaymentViewController
    now paypal will handle it by ownself.
 
********************  End of Description  ***********************/



