//
//  UIView+HTExtension.swift
//  Hanten-iOSExtensions
//
//  Created by huangzhiqiang on 2019/9/7.
//

import UIKit

extension UIView {
    
    /// 删除当前view的所有子视图
    func removeAllSubViews() {
        for view in subviews {
            view.removeFromSuperview()
        }
    }
    
    /// 隐藏或显示当前view的所有子视图
    func hiddenOrShowAllSubViews(_ isHidden: Bool) {
        for view in subviews {
            view.isHidden = isHidden
        }
    }
    
    /// view的Origin
    var viewOrigin: CGPoint {
        get { return frame.origin}
        
        set(newVal) {
            var tmpFrame    = frame
            tmpFrame.origin = newVal
            frame           = tmpFrame
        }
    }
    
    /// view的Size
    var viewSize : CGSize {
        get{ return frame.size}
        
        set(newVal) {
            var tmpFrame  = frame
            tmpFrame.size = newVal
            frame         = tmpFrame
        }
    }
    
    /// centerX
    var centerX : CGFloat {
        get { return center.x}
        set(newVal) { center = CGPoint(x: newVal, y: center.y)}
    }
    
    /// centerY
    var centerY : CGFloat {
        get { return center.y}
        set(newVal) { center = CGPoint(x: center.x, y: newVal)}
    }
    
    /// middleX
    var middleX : CGFloat {
        get { return bounds.width / 2}
    }
    
    /// middleY
    var middleY : CGFloat {
        get { return bounds.height / 2}
    }
    
    /// middlePoint
    var middlePoint : CGPoint {
        get { return CGPoint(x: bounds.width / 2, y: bounds.height / 2)}
    }
    
    /// 当前view的右边距离父视图原点x的距离
    var viewRight: CGFloat {
        get { return frame.origin.x + frame.size.width }
    }
    
    /// 当前view的底部距离父视图原点y的距离
    var viewBottom: CGFloat {
        get { return frame.origin.y + frame.size.height }
    }
    
}


extension UIView {
    
    /// 可选择位置设置圆角
    ///
    /// - Parameters:
    ///   - byRoundingCorners: 要设置圆角的位置
    ///   - cornerRadii: 圆角大小
    func setCornerRadius(_ byRoundingCorners: UIRectCorner, _ cornerRadii: CGSize) {
        
        let bezierPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: byRoundingCorners, cornerRadii: cornerRadii)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = bezierPath.cgPath
        shapeLayer.frame = self.bounds
        
        self.layer.addSublayer(shapeLayer)
        self.layer.mask = shapeLayer
    }
    
    /// UIView的无损截图
    ///
    /// - Returns: 截图
    func screenShot() -> UIImage? {
        guard frame.height > 0 && frame.width > 0 else {
            return nil
        }
        
        UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    
}

