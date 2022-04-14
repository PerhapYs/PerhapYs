//
//  Json+Tool.swift
//  YuanJuBian
//
//  Created by apple on 2022/2/18.
//

import Foundation

func toDictionary<T:Encodable>(with model:T) -> Dictionary<String,Any>?{
    
    let jsonEncoder = JSONEncoder()
    do{
        let jsonData = try jsonEncoder.encode(model)
        if let jsonDic = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? Dictionary<String,Any>{
            return jsonDic
        }
    }
    catch{
        
    }
    return nil
}
func toArray<T:Encodable>(with models:[T]) -> Array<Dictionary<String,Any>>?{
    
    let jsonEncoder = JSONEncoder()
    do{
        let jsonData = try jsonEncoder.encode(models)
        if let jsonDic = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? Array<Dictionary<String,Any>>{
            return jsonDic
        }
    }
    catch{
        
    }
    return nil
}
extension Array{
    
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
            
        }
        return nil
    }
}
extension Dictionary{
    
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
            
        }
        return nil
    }
}
extension String{
    
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
            
        }
        return nil
    }
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
            
        }
        return nil
    }
}
