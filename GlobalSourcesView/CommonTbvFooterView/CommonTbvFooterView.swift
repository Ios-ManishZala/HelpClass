//
//  CommonTbvFooterView.swift
//  Salon
//
//  Created by Keyur Baravaliya on 20/09/22.
//

import UIKit

class CommonTbvFooterView: UITableViewHeaderFooterView {

    @IBOutlet weak var lbl_watchshortad: UILabel!
    @IBOutlet weak var lbl_GetunlimitedChat: UILabel!
    var onTapGetunlimtedChat:(()->())? = nil
    var onTapWatchShortAd:(()->())? = nil
    
    
    @IBAction func btnGetunlimitedChatAction(_ sender: UIButton) {
        if let getAct = self.onTapGetunlimtedChat{
            getAct()
        }
    }
    
    @IBAction func btnwatchshortadAction(_ sender: UIButton) {
        if let getAct = self.onTapWatchShortAd{
            getAct()
        }
    }
}
