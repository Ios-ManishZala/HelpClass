//
//  TabNavigationBar.swift
//  Salon
//
//  Created by Keyur Baravaliya on 20/09/22.
//

import UIKit

class TabNavigationBar: UIView {
    
    private static let NIB_NAME2 = "TabNavigationBar"
    
    @IBOutlet weak var premium_view: UIView!
    @IBOutlet weak var btnselect: UIButton!
    @IBOutlet weak var img_line: UIImageView!
    @IBOutlet weak var settingView: UIView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnSetting: UIButton!
    @IBOutlet public weak var titleLabel: UILabel!
    @IBOutlet var contentView: UIView!
    
    var onTapSettingAction:(()->())? = nil
    var onTapSelectAction:(()->())? = nil
    var onTapBackAction:(()->())? = nil
    var onTapPremuimAction:(()->())? = nil
    
    override func awakeFromNib() {
        initWithNib()
    }
    
    private func initWithNib() {
        Bundle.main.loadNibNamed(TabNavigationBar.NIB_NAME2, owner: self, options: nil)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        setupLayout()
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate(
            [
                contentView.topAnchor.constraint(equalTo: topAnchor),
                contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
                contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
                contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            ]
        )
    }
    
    @IBAction func btnPremuimAction(_ sender: UIButton) {
        if let getAct = self.onTapPremuimAction {
            getAct()
        }
    }
    
    @IBAction func btnSettingAction(_ sender: UIButton) {
        if let getAct = self.onTapSettingAction {
            getAct()
        }
    }
    
    @IBAction func btnSelectAction(_ sender: UIButton) {
        if let getAct = self.onTapSelectAction {
            getAct()
        }
    }
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        self.findViewController()?.navigationController?.popViewController(animated: true)
        if let getAct = self.onTapBackAction {
            getAct()
        }
    }
    
}


