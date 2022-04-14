//
//  PYSheetViewController.swift
//  MetaU
//
//  Created by PerhapYs on 2022/4/9.
//

import UIKit

class PYSheetViewController: PYPopupViewController {

    var defaultContentBackgroundColor : UIColor = "#30364A".HexColor()
    
    var defaultContentHeight : CGFloat = 100{
        didSet{
            self.containerView.snp.updateConstraints { make in
                make.height.equalTo(defaultContentHeight)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.addSubview(self.containerView)
        self.containerView.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(defaultContentHeight)
        }
    }
    lazy var containerView: NoUserInterationView = {
        let view = NoUserInterationView()
        view.backgroundColor = defaultContentBackgroundColor
        return view
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.containerView.addCorner(conrners: [.topLeft,.topRight], radius: 20.F())
    }

}
