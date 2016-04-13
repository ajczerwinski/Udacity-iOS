//
//  AlertConvenience.swift
//  On the Map
//
//  Created by Allen Czerwinski on 4/7/16.
//  Copyright © 2016 Allen Czerwinski. All rights reserved.
//

import Foundation
import UIKit

// Convenience Class for managing Alerts in the UI
class AlertConvenience {
    
    class func showAlert(caller: UIViewController, error: NSError) {
        print((error.domain), (error.localizedDescription))
        let alert = UIAlertController(title: error.domain, message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        caller.presentViewController(alert, animated: true, completion: nil)
    }
    
}