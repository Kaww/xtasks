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
    
    private let service = TasksService.shared
    
}


// MARK: - Controller Input
extension NewTaskModel: NewTaskControllerInput {
    
    func createTask(task: Task) {
        newTaskController?.onTaskCreated(success: service.create(task))
    }
    
}
