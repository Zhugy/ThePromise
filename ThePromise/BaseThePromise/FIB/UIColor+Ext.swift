//
//  UIColor+Ext.swift
//  ThePromise
//
//  Created by zhugy on 2017/8/31.
//  Copyright © 2017年 zhugy. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(r: Int, g: Int, b: Int) {
        self.init(r: r, g: g, b: b, a: 1)
    }
    
    convenience init(r: Int, g: Int, b: Int, a: Double) {
        self.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: CGFloat(a))
    }
    
    convenience init(hex: String) {
        var hex = hex
        if hex.hasPrefix("#") {
            hex = String(hex.characters.dropFirst())
        }
        
        let scanner = Scanner(string: hex)
        var hexValue: UInt32 = 0
        if scanner.scanHexInt32(&hexValue) {
            let red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
            let green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
            let blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
            self.init(red: red, green: green, blue: blue, alpha: 1)
        } else {
            self.init(white: 0, alpha: 0)
        }
    }
    
    var hexString: String {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        return String(format: "#%02X%02X%02X", Int(r*255.0), Int(g*255.0), Int(b*255.0))
    }
}
