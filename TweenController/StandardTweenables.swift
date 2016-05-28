//
//  StandardTweenables.swift
//  TweenController
//
//  Created by Dalton Claybrook on 5/9/16.
//
//  Copyright (c) 2016 Dalton Claybrook
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import UIKit

extension Double: Tweenable {
    public static func valueBetween(val1: Double, _ val2: Double, percent: Double) -> Double {
        return (val2 - val1) * percent + val1
    }
}

extension Float: Tweenable {
    public static func valueBetween(val1: Float, _ val2: Float, percent: Double) -> Float {
        return (val2 - val1) * Float(percent) + val1
    }
}

extension Int: Tweenable {
    public static func valueBetween(val1: Int, _ val2: Int, percent: Double) -> Int {
        return Int(round((Double(val2) - Double(val1)) * Double(percent) + Double(val1)))
    }
}

extension CGFloat: Tweenable {
    public static func valueBetween(val1: CGFloat, _ val2: CGFloat, percent: Double) -> CGFloat {
        return (val2 - val1) * CGFloat(percent) + val1
    }
}

extension CGPoint: Tweenable {
    public static func valueBetween(val1: CGPoint, _ val2: CGPoint, percent: Double) -> CGPoint {
        let x = CGFloat.valueBetween(val1.x, val2.x, percent: percent)
        let y = CGFloat.valueBetween(val1.y, val2.y, percent: percent)
        return CGPoint(x: x, y: y)
    }
}

extension CGSize: Tweenable {
    public static func valueBetween(val1: CGSize, _ val2: CGSize, percent: Double) -> CGSize {
        let w = CGFloat.valueBetween(val1.width, val2.width, percent: percent)
        let h = CGFloat.valueBetween(val1.height, val2.height, percent: percent)
        return CGSize(width: w, height: h)
    }
}

extension CGRect: Tweenable {
    public static func valueBetween(val1: CGRect, _ val2: CGRect, percent: Double) -> CGRect {
        let origin = CGPoint.valueBetween(val1.origin, val2.origin, percent: percent)
        let size = CGSize.valueBetween(val1.size, val2.size, percent: percent)
        return CGRect(origin: origin, size: size)
    }
}

extension UIColor: Tweenable {
    public static func valueBetween(val1: UIColor, _ val2: UIColor, percent: Double) -> Self {
        var r1: CGFloat = 0.0
        var g1: CGFloat = 0.0
        var b1: CGFloat = 0.0
        var a1: CGFloat = 0.0
        
        var r2: CGFloat = 0.0
        var g2: CGFloat = 0.0
        var b2: CGFloat = 0.0
        var a2: CGFloat = 0.0
        
        val1.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        val2.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
        
        let r3 = CGFloat.valueBetween(r1, r2, percent: percent)
        let g3 = CGFloat.valueBetween(g1, g2, percent: percent)
        let b3 = CGFloat.valueBetween(b1, b2, percent: percent)
        let a3 = CGFloat.valueBetween(a1, a2, percent: percent)
        
        return self.init(red: r3, green: g3, blue: b3, alpha: a3)
    }
}

extension CGAffineTransform: Tweenable {
    public static func valueBetween(val1: CGAffineTransform, _ val2: CGAffineTransform, percent: Double) -> CGAffineTransform {
        let a = CGFloat.valueBetween(val1.a, val2.a, percent: percent)
        let b = CGFloat.valueBetween(val1.b, val2.b, percent: percent)
        let c = CGFloat.valueBetween(val1.c, val2.c, percent: percent)
        let d = CGFloat.valueBetween(val1.d, val2.d, percent: percent)
        let tx = CGFloat.valueBetween(val1.tx, val2.tx, percent: percent)
        let ty = CGFloat.valueBetween(val1.ty, val2.ty, percent: percent)
        return CGAffineTransform(a: a, b: b, c: c, d: d, tx: tx, ty: ty)
    }
}

extension CATransform3D: Tweenable {
    public static func valueBetween(val1: CATransform3D, _ val2: CATransform3D, percent: Double) -> CATransform3D {
        let m11 = CGFloat.valueBetween(val1.m11, val2.m11, percent: percent)
        let m12 = CGFloat.valueBetween(val1.m12, val2.m12, percent: percent)
        let m13 = CGFloat.valueBetween(val1.m13, val2.m13, percent: percent)
        let m14 = CGFloat.valueBetween(val1.m14, val2.m14, percent: percent)
        let m21 = CGFloat.valueBetween(val1.m21, val2.m21, percent: percent)
        let m22 = CGFloat.valueBetween(val1.m22, val2.m22, percent: percent)
        let m23 = CGFloat.valueBetween(val1.m23, val2.m23, percent: percent)
        let m24 = CGFloat.valueBetween(val1.m24, val2.m24, percent: percent)
        let m31 = CGFloat.valueBetween(val1.m31, val2.m31, percent: percent)
        let m32 = CGFloat.valueBetween(val1.m32, val2.m32, percent: percent)
        let m33 = CGFloat.valueBetween(val1.m33, val2.m33, percent: percent)
        let m34 = CGFloat.valueBetween(val1.m34, val2.m34, percent: percent)
        let m41 = CGFloat.valueBetween(val1.m41, val2.m41, percent: percent)
        let m42 = CGFloat.valueBetween(val1.m42, val2.m42, percent: percent)
        let m43 = CGFloat.valueBetween(val1.m43, val2.m43, percent: percent)
        let m44 = CGFloat.valueBetween(val1.m44, val2.m44, percent: percent)
        return CATransform3D(m11: m11, m12: m12, m13: m13, m14: m14, m21: m21, m22: m22, m23: m23, m24: m24, m31: m31, m32: m32, m33: m33, m34: m34, m41: m41, m42: m42, m43: m43, m44: m44)
    }
}
