//
//  Json+Tool.swift
//  YuanJuBian
//
//  Created by apple on 2022/2/18.
//

import Foundation

extension Encodable{
    
    /// 可编码对象转字典
    /// - Returns: 字典
    func toDictionary() -> Dictionary<String,Any>?{
        
        let jsonEncoder = JSONEncoder()
        do{
            let jsonData = try jsonEncoder.encode(self)
            if let jsonDic = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? Dictionary<String,Any>{
                return jsonDic
            }
        }
        catch{
            debugPrint("JsonEncoder Error:\(error)")
        }
        return nil
    }
    
    /// 可编码对象转JsonString
    /// - Returns: JsonString
    func toString() -> String?{
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(self)
            return String.init(data: data, encoding: .utf8)
        } catch  {
            debugPrint(error)
        }
        return nil
    }
}
extension Array where Element : Encodable{
    
    /// 可编码对象数组转字典数组
    /// - Returns: 字典数组
    func toArray() -> Array<Dictionary<String,Any>>?{
        
        let jsonEncoder = JSONEncoder()
        do{
            let jsonData = try jsonEncoder.encode(self)
            if let jsonDic = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? Array<Dictionary<String,Any>>{
                return jsonDic
            }
        }
        catch{
            debugPrint("JsonEncoder Error:\(error)")
        }
        return nil
    }
}
extension Array{
    
    /// 数组转Json字符串
    /// - Returns: Json字符串
    func toJson() -> String?{
        
        guard JSONSerialization.isValidJSONObject(self) else {
            return nil
        }
        do{
            let data : Data = try JSONSerialization.data(withJSONObject: self, options: [])
            let str = String.init(data: data, encoding: .utf8)
            return str
        }
        catch{
            print("JsonSerialization Array Encode Error:\(error)")
        }
        return nil
    }
}
extension Dictionary{
    
    /// 字典转Json字符串
    /// - Returns: Json字符串
    func toJson() -> String?{

        guard JSONSerialization.isValidJSONObject(self) else {
            return nil
        }
        do{
            let data : Data = try JSONSerialization.data(withJSONObject: self, options: [])
            let str = String.init(data: data, encoding: .utf8)
            return str
        }
        catch{
            print("JsonSerialization Dictionary Encode Error:\(error)")
        }
        return nil
    }
}
extension String{
    
    /// Json字符串转字典
    /// - Returns: 字典
    func toDictionary() -> Dictionary<String,Any>?{
        do{
            if let data = self.data(using: .utf8){
                
                let json : Any = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                
                if let json = json as? Dictionary<String,Any>{
                    return json
                }
            }
        }
        catch{
            print("JsonSerialization String Decode To Dictionary Error:\(error)")
        }
        return nil
    }
    
    /// Json字符串转数组
    /// - Returns: 数组
    func toArray() -> Array<Any>?{
        do{
            if let data = self.data(using: .utf8){
                
                let json : Any = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                
                if let arr = json as? Array<Any>{
                    return arr
                }
            }
        }
        catch{
            print("JsonSerialization String Decode To Array Error:\(error)")
        }
        return nil
    }
}
