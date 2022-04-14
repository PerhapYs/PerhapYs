//
//  String+Tool.swift
//  YuanJuBian
//
//  Created by PerhapYs on 2021/12/29.
//

import Foundation
import UIKit

import CommonCrypto

func IPAddress() -> String? {
    
    var addresses = [String]()
    var ifaddr : UnsafeMutablePointer<ifaddrs>? = nil
    if getifaddrs(&ifaddr) == 0 {
        var ptr = ifaddr
        while (ptr != nil) {
            let flags = Int32(ptr!.pointee.ifa_flags)
            var addr = ptr!.pointee.ifa_addr.pointee
            if (flags & (IFF_UP|IFF_RUNNING|IFF_LOOPBACK)) == (IFF_UP|IFF_RUNNING) {
                if addr.sa_family == UInt8(AF_INET) || addr.sa_family == UInt8(AF_INET6) {
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    if (getnameinfo(&addr, socklen_t(addr.sa_len), &hostname, socklen_t(hostname.count),nil, socklen_t(0), NI_NUMERICHOST) == 0) {
                        if let address = String(validatingUTF8:hostname) {
                            addresses.append(address)
                        }
                    }
                }
            }
            ptr = ptr!.pointee.ifa_next
        }
        freeifaddrs(ifaddr)
    }
    return addresses.first
}

extension String{
    
    /// 读取工程图片
    /// - Returns: ~
    func toImage() -> UIImage?{
        
        return UIImage.init(named: self)
    }
    
    /// 保留多少位小数
    /// - Parameter num: 小数位数
    /// - Returns: 修改后
    func toKeepPointNum(num:Int = 0) -> String{
        
        guard let float = Float(self) else{
            return ""
        }
        return String(format: "%.\(num)f", float)
    }
    
    /// Html编码成AttributedString
    /// - Returns: ~
    func htmlAttributedString() -> NSAttributedString?{
        do {
            if let data = self.data(using: String.Encoding.unicode, allowLossyConversion: true) {
                let attStr = try NSAttributedString.init(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType : NSAttributedString.DocumentType.html,], documentAttributes: nil)
                return attStr
            }
        } catch {
            
        }
        return nil
    }
    
    /// 获取NSRange
    /// - Parameter of: ~
    /// - Returns: ~
    func nsRange(of: String) -> NSRange{
        
        guard let range = self.range(of: of) else {
            
            return NSRange()
        }
        
        return NSRange(range,in: self)
    }
    
    /// 富文本添加样式
    /// - Parameters:
    ///   - font: 字体
    ///   - color: 颜色
    ///   - lineSpacing: 行距
    ///   - aliment: 排列方式
    /// - Returns: ～
    func attributeText(font:UIFont? = nil,
                       color:UIColor? = nil,
                       lineSpacing:CGFloat? = nil,
                       aliment:NSTextAlignment = .left) -> NSMutableAttributedString{
        
        let attributeText = NSMutableAttributedString.init(string: self)
        var attrs = [NSAttributedString.Key : Any]()
        if let font = font {
            attrs[NSAttributedString.Key.font] = font
        }
        if let color = color {
            attrs[NSAttributedString.Key.foregroundColor] = color
        }
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineSpacing = lineSpacing ?? 0
        paragraph.alignment = aliment
        attrs[NSAttributedString.Key.paragraphStyle] = paragraph
        attributeText.addAttributes(attrs, range: NSRange.init(location: 0, length: attributeText.length))
        return attributeText
    }
    /*
     *去掉首尾空格
     */
    var removeHeadAndTailSpace:String {
        let whitespace = NSCharacterSet.whitespaces
        return self.trimmingCharacters(in: whitespace)
    }
    /*
     *去掉首尾空格 包括后面的换行 \n
     */
    var removeHeadAndTailSpacePro:String {
        let whitespace = NSCharacterSet.whitespacesAndNewlines
        return self.trimmingCharacters(in: whitespace)
    }
    /*
     *去掉所有空格
     */
    var removeAllSapce: String {
        return self.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
    }
    /*
     *去掉首尾空格 后 指定开头空格数
     */
    func beginSpaceNum(num: Int) -> String {
        var beginSpace = ""
        for _ in 0..<num {
            beginSpace += " "
        }
        return beginSpace + self.removeHeadAndTailSpacePro
    }
    
    /// 计算宽度
    /// - Parameters:
    ///   - font: 字体大小
    ///   - height: 高度
    /// - Returns: 宽度
    func width(_ font:UIFont = UIFont.systemFont(ofSize: 16, weight: .regular) , _ height:CGFloat = 20) -> CGFloat{
        
        let size = CGSize.init(width: CGFloat.greatestFiniteMagnitude, height: height)
        let att = [NSAttributedString.Key.font : font]
        let culSize :CGSize = self.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: att, context: nil).size
        return culSize.width
    }
}

#if canImport(CryptoSwift)
import CryptoSwift

let AES_KEY = "JUHJ3artG68BxdJM"

let AES_IV = "at20217211222abc"

extension String{
    
    func AES_ECB_encode() -> String{
        
        let data = self.data(using: String.Encoding.utf8)
        var encrypted : [UInt8] = []
        do{
            encrypted = try AES(key: AES_KEY, iv: AES_IV, padding: .pkcs7).encrypt(data!.bytes)
        }
        catch{
            
        }
        let encoded = Data(encrypted)
        return encoded.base64EncodedString()
    }
    func AES_ECB_decode() -> String{
        
        let data = NSData.init(base64Encoded: self, options: NSData.Base64DecodingOptions.init(rawValue: 0))
        // byte数组
        var enrypted : [UInt8] = []
        let count = data?.length
        //把data转byte数组
        for i in 0..<count!{
            var temp : UInt8 = 0
            data?.getBytes(&temp, range: NSRange.init(location: i, length: 1))
            enrypted.append(temp)
        }
        //decode AES
        var decrypted : [UInt8] = []
        do{
            decrypted = try AES.init(key: AES_KEY, iv: AES_IV, padding: .pkcs7).decrypt(decrypted)
        }
        catch{
            
        }
        // byte 转化成NSData
        let encoded = Data(decrypted)
        var str = ""
        str = String.init(bytes: encoded.bytes, encoding:.utf8)!
        return str
    }
}
#endif
extension String{
    
    var md5String: String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)

        let hash = NSMutableString()

        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
        }

        result.deallocate()
        return hash as String
    }
}
