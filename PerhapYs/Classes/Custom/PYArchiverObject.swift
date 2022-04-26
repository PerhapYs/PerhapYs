//
//  PYArchiverObject.swift
//  YuanJuBian
//
//  Created by mac on 2022/1/20.
//

import UIKit


@objcMembers
/// 归档对象
class PYArchiverObject : NSObject,NSCoding{
    
    required override init() {}
    
    func encode(with coder: NSCoder) {

        let mirror = Mirror.init(reflecting: self)
        for child in mirror.children {
            if let propertyKey = child.label{
                coder.encode(child.value, forKey: propertyKey)
            }
        }
    }

    required init?(coder: NSCoder) {

        super.init()

        let mirror = Mirror.init(reflecting: self)
        var propertyDic :[String : Any?] = [:]
        for child in mirror.children {
            if let propertyKey : String = child.label , let propertyValue = coder.decodeObject(forKey: propertyKey){

                propertyDic[propertyKey] = propertyValue
                self.setValue(propertyValue, forKey: propertyKey)
            }
        }
    }
}

extension PYArchiverObject{
    
    /// 归档路径
    /// - Returns: ~
    static func filePath () -> String?{
        
        if let basePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first{
            let className = String(describing: Self.self)
            return basePath.appending("/\(className)")
        }
        return nil
    }
    
    /// 归档
    func archived(requiringSecureCoding:Bool = false){
        
        let selfClass = type(of: self)
        guard let filePath = selfClass.filePath() else {
            return
        }
        if #available(iOS 11.0, *) {
            do{
                let fileUrl = URL(fileURLWithPath: filePath)
                let data :Data = try NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: requiringSecureCoding)
                try data.write(to: fileUrl, options: .atomic)
            }
            catch let error{
                debugPrint("归档失败\(error)")
            }
        } else {
            if !NSKeyedArchiver.archiveRootObject(self, toFile: filePath){
                debugPrint("归档失败.")
            }
        }
    }
    /// 解档
    /// - Returns: ~
    static func unarchived() -> Self?{
        
        guard let filePath = self.filePath() else {
            return nil
        }
        
        if #available(iOS 11.0, *) {
            do{
                let fileUrl = URL(fileURLWithPath: filePath)
                let data = try Data.init(contentsOf: fileUrl)
                let unarchiverModel = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? Self
                return unarchiverModel
            }
            catch let error{
                debugPrint("解档失败:\(error)")
            }
        } else {
            if let unarchiverModel = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? Self{
                return unarchiverModel
            }
            else{
                debugPrint("解档失败.")
            }
        }
        return nil
    }
}
