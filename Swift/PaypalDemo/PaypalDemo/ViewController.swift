//
//  ViewController.swift
//  PaypalDemo
//
//  Created by Prabhat on 5/8/16.
//  Copyright © 2016 Prabhat. All rights reserved.
//

import UIKit

class ViewController: UIViewController, PayPalPaymentDelegate{
    
    var payPalConfiguration = PayPalConfiguration()
    var environment:String = PayPalEnvironmentNoNetwork{
        willSet(newEnvironment){
            if  (newEnvironment != environment) {
                PayPalMobile.preconnectWithEnvironment(newEnvironment)
            }
        }
    }
    
    var acceptCreditCards:Bool = true{
        didSet{
            payPalConfiguration.acceptCreditCards = acceptCreditCards
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let btn:UIButton = UIButton(frame:CGRectMake(0,0,100,50))
        btn.center = self.view.center;
        btn.setTitle("Pay", forState: .Normal)
        btn.backgroundColor = UIColor.darkGrayColor()
        btn.addTarget(self, action:#selector(ViewController.btnPaymentAction), forControlEvents: .TouchUpInside)
        self.view.addSubview(btn)
        
        
        payPalConfiguration.acceptCreditCards = acceptCreditCards
        payPalConfiguration.merchantName = "Prabhat Singh"
        payPalConfiguration.merchantPrivacyPolicyURL = NSURL(string: "")
        payPalConfiguration.merchantUserAgreementURL = NSURL(string: "")
        payPalConfiguration.languageOrLocale = NSLocale.preferredLanguages()[0] 
        payPalConfiguration.payPalShippingAddressOption = .PayPal
        
        PayPalMobile.preconnectWithEnvironment(environment)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func btnPaymentAction(sender:UIButton) -> Void {
        let item1 = PayPalItem(name: "Demo Item1", withQuantity: 1, withPrice: 4.5, withCurrency: "USD", withSku: "Prabhat")
        let items = [item1]
        let subtotal = PayPalItem.totalPriceForItems(items)
        let shipping = NSDecimalNumber(string:"0.00")
        let tax = NSDecimalNumber(string:"0.00")
        let paymentDetails = PayPalPaymentDetails(subtotal: subtotal, withShipping: shipping, withTax: tax)
        let total = subtotal.decimalNumberByAdding(shipping).decimalNumberByAdding(tax)
        let payment = PayPalPayment(amount: total, currencyCode: "USD", shortDescription: "description of Demo Item1", intent: .Sale)
        payment.items = items;
        payment.paymentDetails = paymentDetails
        
        if payment.processable {
            let paymentViewController = PayPalPaymentViewController(payment: payment, configuration: payPalConfiguration, delegate: self)
            presentViewController(paymentViewController!, animated: true, completion:nil)
        }else{
            print("Payment not processable \(payment)")
        }
    }

    func payPalPaymentDidCancel(paymentViewController: PayPalPaymentViewController) {
        print("Payment cancelled")
        paymentViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func payPalPaymentViewController(paymentViewController: PayPalPaymentViewController, didCompletePayment completedPayment: PayPalPayment) {
        print("Please pay via PayPal")
        paymentViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
}

