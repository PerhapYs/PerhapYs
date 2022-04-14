//
//  PYChatMenuView.swift
//  MetaU
//
//  Created by PerhapYs on 2022/4/11.
//

import UIKit

class PYChatMenuView: UIView {
    
    weak var ChatBoxView : UIView?
    
    convenience init(with chatBox:UIView) {
        self.init()
        
        self.ChatBoxView = chatBox
    }

    init(){
        super.init(frame: .zero)
        
        self.addSubview(self.inputMsgView)
        self.inputMsgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(8.F())
            make.size.equalTo(CGSize.init(width: 335.F(), height: 40.F()))
        }
        
        self.addSubview(self.stackView)
        self.stackView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(44.F())
            make.right.equalToSuperview().offset(-44.F())
            make.top.equalTo(self.inputMsgView.snp.bottom).offset(16.F())
        }
        
        for type in ChatWindowFuncType.allCases {
            
            let image = UIImage.init(named: type.rawValue)
            let funcBtn = UIButton.init(type: .custom)
            funcBtn.setImage(image, for: .normal)
            funcBtn.addTarget(self, action: #selector(menuEvent(_:)), for: .touchUpInside)
            self.stackView.addArrangedSubview(funcBtn)
            funcBtn.snp.makeConstraints { make in
                make.size.equalTo(CGSize.init(width: 24.F(), height: 24.F()))
                make.top.equalToSuperview()
            }
        }
    }
    @objc func menuEvent(_ btn:UIButton){
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    lazy var inputMsgView: UITextField = {
        
        let view = UITextField()
        view.backgroundColor = COLOR_252A3E
        view.addCorner(radius: 15.F())
        
        let mPlaceholder = LocalizationString.chat.menuPlaceholder.attributeText(font: UIFont.systemFont(ofSize: 14, weight: .regular),
                                                        color: COLOR_4E5679,
                                                        lineSpacing: 0, aliment: .left)
        view.attributedPlaceholder = mPlaceholder
        view.textColor = COLOR_White
        view.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return view
    }()
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.spacing = 0
        view.alignment = .top
        view.distribution = .equalCentering
        view.axis = .horizontal
        return view
    }()
}
