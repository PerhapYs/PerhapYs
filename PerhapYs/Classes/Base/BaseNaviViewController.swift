//
//  BaseNaviViewController.swift
//  MetaU
//
//  Created by PerhapYs on 2022/4/7.
//

import UIKit

class BaseNaviViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.navigationBar.isHidden = true
    }
}

