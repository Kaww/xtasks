//
//  TasksUpdaterDelegate.swift
//  XTasks
//
//  Created by kaww on 08/05/2020.
//  Copyright © 2020 kaww. All rights reserved.
//

import Foundation


/// Delegate updates to the tasks list
///
/// **TasksViewController** conforms to this protocol
protocol TasksUpdaterDelegate {
    func refreshTasksList()
    
}
