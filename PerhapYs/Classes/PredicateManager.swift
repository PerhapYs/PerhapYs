//
//  PredicateManager.swift
//  MetaU
//
//  Created by PerhapYs on 2022/4/12.
//

import Foundation

extension String{
    
    /// 正则验证邮箱格式
    /// - Returns: ~
    func isEmail() -> Bool{
        
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailPre = NSPredicate.init(format: "SELF MATHCES %s", emailRegex)
        return emailPre.evaluate(with: self)
    }
    
    /// 正则验证手机号码格式
    /// - Returns: ～
    func isPhoneNumber() -> Bool{
        
        let phoneRegex = "^1([358][0-9]|4[579]|66|7[0135678]|9[89])[0-9]{8}$"
        let phonePre = NSPredicate.init(format: "SELF MATHCES %s", phoneRegex)
        return phonePre.evaluate(with: self)
    }
}
