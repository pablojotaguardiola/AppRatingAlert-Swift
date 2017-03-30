//
//  RateApp.swift
//  ParseStarterProject-Swift
//
//  Created by Pablo Guardiola on 27/01/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit

// ----APP RATE SETTINGS ---
let APP_ID = "YOUR_STORE_ID_OF_APP"

let showRateTimes = 3 //Times rateApp() called before alert shows
// -------------------------

let RATED_DEFAULT_KEY = "RATED_APP_KEY"
let RATE_CNT_KEY = "RATE_CNT_KEY"

var defaults: UserDefaults!
var viewLoaded: Int = 0

func showRateAlertInmediatly (_ view: UIViewController) {
    rateApp(view, immediatly: true)
}

func rateApp(_ view: UIViewController, immediatly: Bool?) {
    if  defaults == nil {
        defaults = UserDefaults()
        viewLoaded = defaults.object(forKey: RATE_CNT_KEY) == nil ? 0 : defaults.object(forKey: RATE_CNT_KEY) as! Int
    }
    
    var immed = false
    
    if immediatly != nil {
        immed = immediatly!
    }
    
    if !immed {
        viewLoaded += 1
    }
    
    defaults.set(viewLoaded, forKey: "viewLoadedCntRateApp")
    
    if viewLoaded % showRateTimes == 0 || immed {
        if (defaults.object(forKey: RATED_DEFAULT_KEY) == nil || immed) {
            viewLoaded = 0
            
            let rateAlert = UIAlertController(title: "Please, Rate Us!", message: "How much do you like this App?", preferredStyle: .alert)
            
            let fiveStarsAction = UIAlertAction(title: "★★★★★", style: .default, handler: {(alert: UIAlertAction!) in goToRate(view)})
            rateAlert.addAction(fiveStarsAction)
            let fourStarsAction = UIAlertAction(title: "★★★★✩", style: .default, handler: {(alert: UIAlertAction!) in goToRate(view)})
            rateAlert.addAction(fourStarsAction)
            let threeStarsAction = UIAlertAction(title: "★★★✩✩", style: .default, handler: {(alert: UIAlertAction!) in showCloseAlert(view, title: "Thank you", message: "We appreciate your opinion.")
                noMoreRate()
            })
            rateAlert.addAction(threeStarsAction)
            let twoStarsAction = UIAlertAction(title: "★★✩✩✩", style: .default, handler: {(alert: UIAlertAction!) in showCloseAlert(view, title: "Thank you", message: "We appreciate your opinion.")
                noMoreRate()
            })
            rateAlert.addAction(twoStarsAction)
            let oneStarsAction = UIAlertAction(title: "★✩✩✩✩", style: .default, handler: {(alert: UIAlertAction!) in showCloseAlert(view, title: "Thank you", message: "We appreciate your opinion.")
                noMoreRate()
            })
            rateAlert.addAction(oneStarsAction)
            let notNowAction = UIAlertAction(title: "Not Now", style: .default, handler: nil)
            rateAlert.addAction(notNowAction)
            let noThanksAction = UIAlertAction(title: "Don't Ask Again", style: .default, handler: {(alert: UIAlertAction!) in noMoreRate()})
            rateAlert.addAction(noThanksAction)
            
            view.present(rateAlert, animated: true, completion: nil)
        }
    }
}

func goToRate(_ view: UIViewController) {
    let openStoreAlert = UIAlertController(title: "Great", message: "Now, App Store will open and you just have to write a review in 'Reviews' tabs.", preferredStyle: .alert)
    let openStoreAction = UIAlertAction(title: "Go To App Store", style: .default, handler: {(slert: UIAlertAction) in
        noMoreRate()
        UIApplication.shared.openURL(URL(string : "itms-apps://itunes.apple.com/app/id\(APP_ID)")!);
    })
    
    openStoreAlert.addAction(openStoreAction)
    
    view.present(openStoreAlert, animated: true, completion: nil)
}

func noMoreRate () {
    let defaults = UserDefaults()
    
    defaults.set(true, forKey: RATED_DEFAULT_KEY)
}

func getRateAlertCountdown() -> Int {
    defaults = UserDefaults()
    if defaults.object(forKey: RATED_DEFAULT_KEY) == nil {
        return showRateTimes - viewLoaded
    }
    else {
        return 0
    }
}

func showCloseAlert (_ view: UIViewController, title: String, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let alertAction = UIAlertAction(title: "Close", style: .default, handler: nil)
    alert.addAction(alertAction)
    
    view.present(alert, animated: true, completion: nil)
}
