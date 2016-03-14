//
//  ViewController.swift
//  TouchID-POC
//
//  Created by Rohit Singh on 04/01/16.
//  Copyright © 2016 Home. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func passcode() {

    }

    @IBAction func tapAuthenticate(sender: UIButton) {
        let context : LAContext = LAContext()
        
        var err : NSError?
        
        if context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &err)
        {
            [context.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: "Touch id authentication", reply: { (isSuccess : Bool, errLA:NSError?) -> Void in
         
                if isSuccess
                {
                    self.showOKAlertView("Success", strMessage: "Finger print Authentication is successful")
                }
                else
                {
                    switch errLA!.code {
                    case LAError.SystemCancel.rawValue:
                        print("Authentication was cancelled by the system")
                        self.showOKAlertView("Error", strMessage: "SystemCancel")
                        break;
                    case LAError.UserCancel.rawValue:
                        print("Authentication was cancelled by user")
                        self.showOKAlertView("Error", strMessage: "UserCancel")
                        break
                    case LAError.UserFallback.rawValue:
                        self.showOKAlertView("Error", strMessage: "UserFallback");
                        print("User wants to enter password")
                        /*
                        // Determine a string which the device will display in the fingerprint view explaining the reason for the fingerprint scan.
                        NSString * secUseOperationPrompt = @"Authenticate for server login";
                        
                        // The keychain operation shall be performed by the global queue. Otherwise it might just nothing happen.
                        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
                        
                        // Create the keychain query attributes using the values from the first part of the code.
                        NSMutableDictionary * query = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                        (__bridge id)(kSecClassGenericPassword), kSecClass,
                        keychainItemIdentifier, kSecAttrAccount,
                        keychainItemServiceName, kSecAttrService,
                        secUseOperationPrompt, kSecUseOperationPrompt,
                        nil];
                        
                        // Start the query and the fingerprint scan and/or device passcode validation
                        CFTypeRef result = nil;
                        OSStatus userPresenceStatus = SecItemCopyMatching((__bridge CFDictionaryRef)query, &result);
                        
                        // Ignore the found content of the key chain entry (the dummy password) and only evaluate the return code.
                        if (noErr == userPresenceStatus)
                        {
                        NSLog(@"Fingerprint or device passcode validated.");
                        }
                        else
                        {
                        NSLog(@"Fingerprint or device passcode could not be validated. Status %d.", (int) userPresenceStatus);
                        }
                        
                        // To process the result at this point there would be a call to delegate method which 
                        // would do its work like GUI operations in the main queue. That means it would start
                        // with something like:
                        //   dispatch_async(dispatch_get_main_queue(), ^{
                        });
                        */
                    
                    default:
                        break;
                    }

                }
            
           })]
        
        } else {
            switch err!.code {
                
            case LAError.TouchIDNotAvailable.rawValue:
                print("TouchIDNotAvailable")
                self.showOKAlertView("Error", strMessage: "TouchIDNotAvailable")
                break;
                
            case LAError.TouchIDNotEnrolled.rawValue:
                print("TouchIDNotEnrolled")
                self.showOKAlertView("Error", strMessage: "TouchIDNotEnrolled")
                
                break;
                
            default:
                break;
                
                
            }


        }
    }

    //MARK: Alert view methods
    
    func showOKAlertView(strTitle : String, strMessage : String){
        let alert : UIAlertController = UIAlertController(title: strTitle, message: strMessage, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) -> Void in
        })

        
        alert.addAction(okAction)
       // alert.addAction(cancelAction)
        dispatch_async(dispatch_get_main_queue(), {
            // code here
            self.presentViewController(alert, animated: true, completion: { () -> Void in
                
            })
        })    }
    
        func showOKAndCancelAlertView(strTitle : String, strMessage : String){
            let alert : UIAlertController = UIAlertController(title: strTitle, message: strMessage, preferredStyle: UIAlertControllerStyle.Alert)
            let okAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) -> Void in
            })
            
                    let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) -> Void in
                    })
            
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            dispatch_async(dispatch_get_main_queue(), {
                // code here
                self.presentViewController(alert, animated: true, completion: { () -> Void in
                    
                })
            })
           
        

    }
    
    

}


