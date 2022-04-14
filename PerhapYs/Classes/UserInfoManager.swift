//
//  UserInfoManager.swift
//  MetaU
//
//  Created by PerhapYs on 2022/4/8.
//

import Foundation
import HandyJSON

class LocalUserToken : PYArchiverObject , HandyJSON{
    
    var token : String = ""
}

let MYTOKEN = UserInfoManager.shared.myToken

struct UserInfoManager{
    
    static var shared = UserInfoManager()
    
    var myToken : LocalUserToken =  LocalUserToken.unarchived() ?? LocalUserToken()
        
    /// 是否已经登陆
    static func isLogin() -> Bool{
        return !self.shared.myToken.token.isEmpty
    }
    
    /// 更新用户本地Token
    /// - Parameters:
    ///   - token: token
    ///   - userId: userId
    static func update(token:String?){
        
        let localToken = LocalUserToken()
        localToken.token = token ?? ""
        localToken.archived()
        
        if let myToken = LocalUserToken.unarchived(){
            self.shared.myToken = myToken
        }
    }
    
    /// 用户登陆失效
    static func expaired(_ errorMsg:String){
        
        Toast(errorMsg)
        CtnManager.pushStartLogin()
    }
}
