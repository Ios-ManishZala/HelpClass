//
//  CommonTbvHeaderView.swift
//  Salon
//
//  Created by Keyur Baravaliya on 22/09/22.
//

import UIKit

class CommonTbvHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var btnSeeAll: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    
    var onTapSeeAll:(()->())? = nil
    
    @IBAction func btnSeeAllAction(_ sender: UIButton) {
        if let getAct = self.onTapSeeAll {
            getAct()
        }
    }
}
