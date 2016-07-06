//
//  ViewController.swift
//  App Rating Alert
//
//  Created by Pablo Guardiola on 05/07/16.
//  Copyright © 2016 Pablo Guardiola. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var countDownButton: UIButton!
    
    override func viewDidLoad() {
        setCountDownButton()
    }

    @IBAction func testShowAlert(sender: AnyObject) {
        showRateAlertInmediatly(self)
    }
    
    
    @IBAction func testViewAppears(sender: AnyObject) {
        rateApp(self, immediatly: nil)
        
        setCountDownButton()
    }
    
    func setCountDownButton() {
        let count = getRateAlertCountdown()
        
        if count >= 0 {
            let rateString = "Show Alert countdown (\(count) clicks left)"
            
            countDownButton.setTitle(rateString, forState: .Normal)
        }
    }
}

