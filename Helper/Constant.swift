//
//  Constant.swift
//  LieDetector
//
//  Created by DREAMWORLD on 24/08/23.
//

import Foundation
import UIKit

//App Details

let APPLOGO         = UIImage(named: "ic_logo")
let APPNAME         = "Insta Saver"

let APPID           = ""
let AppURL          = "https://itunes.apple.com/app/id\(APPID)?mt=8"
let AppshareLink    = ""
let PRIVACYPOLICY   = ""
let TERM_CONDITION  = ""



class Constant: NSObject{
    
    static let userDefaults = UserDefaults.standard

    static let splaceAPI = "https://iosapplive.appomania.co.in/api/application/com.FBVideoSaver"
    static var customizesAdsData : DataClass?
    static var customizesMyAppAdsList = [AppList]()
    static var boolAppLaunchFromDidLaunching : Bool = false
}

