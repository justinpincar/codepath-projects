//
//  SettingsViewController.swift
//  tips
//
//  Created by Justin on 8/23/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    let defaultTipPercentageIndexKey = "defaultTipPercentageIndex"
    
    override func viewDidLoad() {
        let defaults = NSUserDefaults.standardUserDefaults()
        if (defaults.objectForKey(defaultTipPercentageIndexKey) != nil) {
            var tipPercentageIndex = defaults.integerForKey(defaultTipPercentageIndexKey)
            tipControl.selectedSegmentIndex = tipPercentageIndex
        }
    }
    
    @IBAction func onValueChanged(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(tipControl.selectedSegmentIndex, forKey: defaultTipPercentageIndexKey)
        defaults.synchronize()
    }

    @IBAction func onClickReturn(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
