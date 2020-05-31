//
//  UITextFieldPadding.swift
//  XTasks
//
//  Created by kaww on 09/05/2020.
//  Copyright © 2020 kaww. All rights reserved.
//

import UIKit


class UITextFieldPadding: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
  
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
}
