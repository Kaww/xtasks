//
//  UILabel+whiteSpaces.swift
//  XTasks
//
//  Created by kaww on 09/05/2020.
//  Copyright © 2020 kaww. All rights reserved.
//

import Foundation


extension String {
    
    func isEmptyOrWhitespace() -> Bool {
        if self.isEmpty || self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
            return true
        }
        
        return false
    }
    
}
