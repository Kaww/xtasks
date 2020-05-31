//
//  UIView+shadows.swift
//  XTasks
//
//  Created by kaww on 09/05/2020.
//  Copyright © 2020 kaww. All rights reserved.
//

import UIKit


extension UIView {
    
    func addShadow() {
        self.layer.shadowColor = Colors.appShadowsColor.cgColor
        self.layer.shadowOffset = CGSize(width: 5, height: 5)
        self.layer.shadowOpacity = 0.4
        self.layer.shadowRadius = 8
    }
    
    func addGradientWithCornerRadius(startColor: UIColor, endColor: UIColor, radius: CGFloat){
        for layer in (self.layer.sublayers ?? []){
            if let layer1 = layer as? CAGradientLayer{
                layer1.removeFromSuperlayer()
            }
        }
        
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [startColor.cgColor, endColor.cgColor]
        gradient.startPoint = CGPoint.init(x: 0, y: 0)
        gradient.endPoint = CGPoint.init(x: 1, y: 1)
        gradient.cornerRadius = radius
        
        self.layer.insertSublayer(gradient, at: 0)
    }
}
