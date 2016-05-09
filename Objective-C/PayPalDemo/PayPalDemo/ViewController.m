//
//  ViewController.m
//  PayPalDemo
//
//  Created by Prabhat on 5/8/16.
//  Copyright © 2016 Prabhat. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong, readwrite) PayPalConfiguration *payPalConfiguration;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *payButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    [payButton setBackgroundColor:[UIColor darkGrayColor]];
    [payButton setTitle:@"Pay" forState:UIControlStateNormal];
    payButton.center = self.view.center;
    [payButton addTarget:self action:@selector(btnPaymentAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:payButton];
    
    _payPalConfiguration = [[PayPalConfiguration alloc] init];
    _payPalConfiguration.acceptCreditCards = YES;
    _payPalConfiguration.payPalShippingAddressOption = PayPalShippingAddressOptionPayPal;
    
    [PayPalMobile preconnectWithEnvironment:PayPalEnvironmentNoNetwork];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(void) btnPaymentAction:(id) sender {
    
    PayPalPayment *payment = [[PayPalPayment alloc] init];
    payment.amount = [[NSDecimalNumber alloc] initWithString:@"4.95"];
    payment.currencyCode = @"USD";
    payment.shortDescription = @"short description";
    payment.intent = PayPalPaymentIntentSale;
    
    if (payment.processable) {
        PayPalPaymentViewController * paymentViewController = [[PayPalPaymentViewController alloc] initWithPayment:payment configuration:_payPalConfiguration delegate:self];
        [self presentViewController:paymentViewController animated:YES completion:nil];
    }else {
        NSLog(@"%@ is not processable",payment);
    }
    
}


- (void)payPalPaymentDidCancel:(nonnull PayPalPaymentViewController *)paymentViewController {
    NSLog(@"Payment Cancelled.");
    [paymentViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)payPalPaymentViewController:(nonnull PayPalPaymentViewController *)paymentViewController
                 didCompletePayment:(nonnull PayPalPayment *)completedPayment {
     NSLog(@"Payment Successfully.");
    [paymentViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
