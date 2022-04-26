//
//  Color+Hex.swift
//  YuanJuBian
//
//  Created by PerhapYs on 2021/12/14.
//

import UIKit
enum GradientColorDirection {
    case horizontal          //水平
    case vertical       //竖直
    case leftTop2RightBollow //向左上->右下
    case leftBollw2RightTop  //左下->右上
}
extension UIColor{
    
    class func gradientColor(with size:CGSize,direction:GradientColorDirection,colors:[String],locations:[NSNumber]) -> UIColor?{
        
        let colorLayer = CAGradientLayer.init()
        colorLayer.frame = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
        var startPoint : CGPoint = .zero
        var endPoint : CGPoint = .zero
        
        switch direction {
        case .horizontal:
            endPoint = CGPoint.init(x: 0, y: 0)
        case .vertical:
            endPoint = CGPoint.init(x: 0, y: 1)
        case .leftTop2RightBollow:
            endPoint = CGPoint.init(x: 1, y: 1)
        case .leftBollw2RightTop:
            startPoint = CGPoint.init(x: 0, y: 1)
            endPoint = CGPoint.init(x: 1, y: 0)
        }
        
        colorLayer.startPoint = startPoint
        colorLayer.endPoint = endPoint
        colorLayer.locations = locations
        var layerColors : [Any] = []
        for colorString in colors {
            
            let color = colorString.HexColor()
            layerColors.append(color.cgColor)
        }
        colorLayer.colors = layerColors
        
        UIGraphicsBeginImageContext(size);
        if let cxt = UIGraphicsGetCurrentContext(){
            colorLayer.render(in:cxt)
            if let image = UIGraphicsGetImageFromCurrentImageContext(){
                UIGraphicsEndImageContext();
                return UIColor.init(patternImage: image)
            }
        }
        return nil
    }
    
    /// 便利构造Hex颜色
    /// - Parameters:
    ///   - string: hex值
    ///   - alpha: alpha值，默认1.0
    convenience init(hex string: String, alpha: CGFloat = 1.0) {
        
        var hex = string.hasPrefix("#") ? String(string.dropFirst()) : string
        guard hex.count == 3 || hex.count == 6  else {
            self.init(white: 1.0, alpha: 0.0)
            return
        }
        
        if hex.count == 3 {
            for (indec, char) in hex.enumerated() {
                hex.insert(char, at: hex.index(hex.startIndex, offsetBy: indec * 2))
            }
        }
        self.init(
            red: CGFloat((Int(hex, radix: 16)! >> 16) & 0xFF) / 255.0,
            green: CGFloat((Int(hex, radix: 16)! >> 8) & 0xFF) / 255.0,
            blue: CGFloat((Int(hex, radix: 16)!) & 0xFF) / 255.0,
            alpha: alpha
        )
    }
}

extension String {
    /// 十六进制字符串颜色转为UIColor
    /// - Parameter alpha: 透明度
    func HexColor(alpha: CGFloat = 1.0) -> UIColor {
        // 存储转换后的数值
        var red: UInt64 = 0, green: UInt64 = 0, blue: UInt64 = 0
        var hex = self
        // 如果传入的十六进制颜色有前缀，去掉前缀
        if hex.hasPrefix("0x") || hex.hasPrefix("0X") {
            hex = String(hex[hex.index(hex.startIndex, offsetBy: 2)...])
        } else if hex.hasPrefix("#") {
            hex = String(hex[hex.index(hex.startIndex, offsetBy: 1)...])
        }
        // 如果传入的字符数量不足6位按照后边都为0处理，当然你也可以进行其它操作
        if hex.count < 6 {
            for _ in 0..<6-hex.count {
                hex += "0"
            }
        }

        // 分别进行转换
        // 红
        Scanner(string: String(hex[..<hex.index(hex.startIndex, offsetBy: 2)])).scanHexInt64(&red)
        // 绿
        Scanner(string: String(hex[hex.index(hex.startIndex, offsetBy: 2)..<hex.index(hex.startIndex, offsetBy: 4)])).scanHexInt64(&green)
        // 蓝
        Scanner(string: String(hex[hex.index(startIndex, offsetBy: 4)...])).scanHexInt64(&blue)

        return UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: alpha)
    }
}
