//
//  PYChatBoxCollectionViewCell.swift
//  MetaU
//
//  Created by PerhapYs on 2022/4/13.
//

import UIKit
#if canImport(BSText)
import BSText

class PYChatBoxLeftCollectionViewCell : PYChatBoxCollectionViewCell{
    
    override func initializeLayout() {
        
        self.contentLabel.textAlignment = .left
        self.contentBackgroundView.backgroundColor = "#252A3E".HexColor()
        
        self.iconImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize.init(width: 48.F(), height: 48.F()))
            make.left.equalToSuperview().offset(20.F())
            make.top.equalToSuperview()
        }
        
        self.contentLabel.snp.makeConstraints { make in
            make.left.equalTo(self.iconImageView.snp.right).offset(25.F())
            make.top.equalTo(self.iconImageView).offset(20.F())
            make.right.lessThanOrEqualToSuperview().offset(-20.F())
            make.bottom.equalToSuperview().offset(-10.F())
        }

        self.contentBackgroundView.snp.makeConstraints { make in
            make.edges.equalTo(self.contentLabel).inset(UIEdgeInsets.init(top: -10.F(), left: -17.F(), bottom: -10.F(), right: -17.F()))
        }
    }
}

class PYChatBoxRightCollectionViewCell : PYChatBoxCollectionViewCell{
    
    override func initializeLayout() {
        
        self.contentLabel.textAlignment = .right
        self.contentBackgroundView.backgroundColor = "#1DC194".HexColor()
        
        self.iconImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize.init(width: 48.F(), height: 48.F()))
            make.right.equalToSuperview().offset(-20.F())
            make.top.equalToSuperview()
        }
        
        self.contentLabel.snp.makeConstraints { make in
            make.right.equalTo(self.iconImageView.snp.left).offset(-25.F())
            make.top.equalTo(self.iconImageView).offset(20.F())
            make.left.greaterThanOrEqualToSuperview().offset(50)
            make.bottom.equalToSuperview().offset(-10.F())
        }

        self.contentBackgroundView.snp.makeConstraints { make in
            make.edges.equalTo(self.contentLabel).inset(UIEdgeInsets.init(top: -10.F(), left: -17.F(), bottom: -10.F(), right: -17.F()))
        }
    }
}

class PYChatBoxCollectionViewCell: UICollectionViewCell {
    
    var model : AnyObject? {
        didSet{
            let icon = testImageUrl
            self.iconImageView.setImage_PY(icon)
            
            let content = "你周末去哪里玩啊?"
            self.contentLabel.text = content
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initializeSubViews()
        self.initializeLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func initializeSubViews(){
        
        self.contentView.addSubview(self.iconImageView)
        
        self.contentView.addSubview(self.contentLabel)
        
        self.contentView.insertSubview(self.contentBackgroundView, belowSubview: self.contentLabel)
    }
    func initializeLayout(){
        
    }
    //MARK: LAZY
    lazy var iconImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.addCorner(radius: 24.F())
        return view
    }()
    
    lazy var contentBackgroundView: UIImageView = {
        
        return UIImageView()
    }()
    
    lazy var contentLabel: UILabel = {
        
        let label = UILabel()
        label.textColor = UIColor.white
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return label
    }()
}
#endif
