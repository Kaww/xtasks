//
//  TaskCellActionsDelegate.swift
//  XTasks
//
//  Created by kaww on 07/05/2020.
//  Copyright © 2020 kaww. All rights reserved.
//

import Foundation


/// Delegate information that a task has been checked
protocol TaskActionsDelegate {
    func onTaskActionChecked(task: TaskEntity)
    
}
