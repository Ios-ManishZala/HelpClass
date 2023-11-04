//
//  UserDefaultsManager.swift
//  InterviewTask
//
//  Created by d3vil_mind on 03/08/21.
//

import Foundation


enum UserDefaultsKeys : String {
    case DISPLAY_MODE
    case CURRENT_THEME
    case ADS_DATA
}

extension UserDefaults {

    func setTheme(value: Bool) {
        set(value, forKey: UserDefaultsKeys.DISPLAY_MODE.rawValue)
    }

    func getTheme()-> Bool {
        return bool(forKey: UserDefaultsKeys.DISPLAY_MODE.rawValue)
    }
    
    func setCurrentTheme(value: Bool) {
        set(value, forKey: UserDefaultsKeys.CURRENT_THEME.rawValue)
    }
    
    func getCurrentTheme()-> Bool {
        return bool(forKey: UserDefaultsKeys.CURRENT_THEME.rawValue)
    }
    
    func setJsonAdsData(value : Data){
        set(value, forKey:  UserDefaultsKeys.ADS_DATA.rawValue)
    }
    
    func getJsonAdsData()-> Data {
        return value(forKey: UserDefaultsKeys.ADS_DATA.rawValue) as? Data ?? Data()
    }
}
