//
//  ViewController.swift
//  tips
//
//  Created by Justin on 8/23/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    let defaultTipPercentageIndexKey = "defaultTipPercentageIndex"
    let billAmountEditedAtKey = "billAmountEditedAt"
    let billAmountKey = "billAmount"
    let tipPercentageIndexKey = "tipPercentageIndex"
    
    let tipPercentages:[Double] = [0.18, 0.20, 0.22]
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if ((defaults.objectForKey(billAmountEditedAtKey) != nil) && (defaults.objectForKey(billAmountKey) != nil)) {
            var billLastEditedAt = defaults.objectForKey(billAmountEditedAtKey) as NSDate
            var now = NSDate()
            var secondsSinceEdit = now.timeIntervalSinceDate(billLastEditedAt)
            if secondsSinceEdit < 60 {
                var billAmount = defaults.objectForKey(billAmountKey) as String
                var tipPercentageIndex = defaults.integerForKey(tipPercentageIndexKey)
                billField.text = billAmount
                tipControl.selectedSegmentIndex = tipPercentageIndex
            }
        }
        
        // IMO setting a default value shouldn't change current values, which is why this is here.
        // If we wanted it to update on return from the modal, we could move this to viewWillAppear.
        if ((billField.text.isEmpty) && (defaults.objectForKey(defaultTipPercentageIndexKey) != nil)) {
            var defaultTipPercentageIndex = defaults.integerForKey(defaultTipPercentageIndexKey)
            tipControl.selectedSegmentIndex = defaultTipPercentageIndex
        }
        
        calculateTip()
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(billField.text, forKey: billAmountKey)
        defaults.setObject(NSDate(), forKey: billAmountEditedAtKey)
        defaults.setInteger(tipControl.selectedSegmentIndex, forKey: tipPercentageIndexKey)
        defaults.synchronize()
        
        calculateTip()
    }
    
    func calculateTip() {
        var billAmount = (billField.text as NSString).doubleValue
        var tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        var tip = billAmount * tipPercentage
        var total = billAmount + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
}
