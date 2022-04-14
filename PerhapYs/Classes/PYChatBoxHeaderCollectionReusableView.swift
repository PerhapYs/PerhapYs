//
//  PYChatBoxHeaderCollectionReusableView.swift
//  MetaU
//
//  Created by PerhapYs on 2022/4/13.
//

import UIKit

class PYChatBoxHeaderCollectionReusableView: UICollectionReusableView {
    
    var model : AnyObject? {
        didSet{
            
            self.timeLabel.text = "2分钟以前"
        }
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initializeSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func initializeSubViews(){
        
        self.addSubview(self.timeLabel)
        self.timeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = COLOR_7B829D
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()
}
