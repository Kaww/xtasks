//
//  NewTaskModel.swift
//  XTasks
//
//  Created by kaww on 08/05/2020.
//  Copyright © 2020 kaww. All rights reserved.
//

import Foundation


class NewTaskModel {
    var newTaskController: NewTaskModelOutput?
    
    private var task: Task?
    
}


// MARK: - Controller Input
extension NewTaskModel: NewTaskControllerInput {
    
    func createTask(task: Task) {
        self.task = Defaults.create(task)
        newTaskController?.onTaskCreated(task: self.task)
    }
    
}
