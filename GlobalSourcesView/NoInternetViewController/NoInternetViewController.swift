//
//  NoInternetViewController.swift
//  WhatscanWA
//
//  Created by DREAMWORLD on 31/08/23.
//

import UIKit

class NoInternetViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var lblNo_internet: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }

}
