//
//  ExtentionsUIView.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 28.01.2023.
//

import UIKit

extension UIView {
    var width: CGFloat {
        return frame.size.width
    }
    var height: CGFloat {
        return frame.size.height
    }
    var left: CGFloat {
        return frame.origin.x
    }
    var right: CGFloat {
        return left + width
    }
    var top: CGFloat {
        return frame.origin.y
    }
    var bottom: CGFloat {
        return top + height
    }
}


extension UIView {
    func dropShadow(cornerRadius : CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
        self.layer.shadowRadius = 15
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 10.0)
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = true
        self.layer.cornerRadius = cornerRadius
    }
}


extension UIView {
    func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors =  [UIColor.systemOrange.cgColor, UIColor.systemPink.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.7, y: 0.7)
        self.layer.addSublayer(gradientLayer)
    }
}
