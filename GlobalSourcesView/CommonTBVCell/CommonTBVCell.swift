//
//  CommonTBVCell.swift
//  SantaCallTracker
//
//  Created by DREAMWORLD on 23/08/23.
//

import UIKit

class CommonTBVCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var bg_image: UIImageView!
    @IBOutlet weak var image_view: UIImageView!
    @IBOutlet weak var lbl_title: UILabel!
    var bgStorkeview = ["tbv_bg1","tbv_bg2","tbv_bg3","tbv_bg4"]
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        self.mainView.addShadow()
        self.bg_image.image = UIImage(named: bgStorkeview.randomElement() ?? "")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
