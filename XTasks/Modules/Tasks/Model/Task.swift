//
//  Task.swift
//  XTasks
//
//  Created by kaww on 07/05/2020.
//  Copyright © 2020 kaww. All rights reserved.
//

import Foundation


struct Task: Codable {
    
    var title: String
    var done = false
    var description = ""
    var identifier: String = UUID().uuidString

    init(_ title: String) {
        self.title = title
    }
    
    init(title: String, description: String) {
        self.title = title
        self.description = description
    }
    
}
