//
//  TasksModel.swift
//  XTasks
//
//  Created by kaww on 07/05/2020.
//  Copyright © 2020 kaww. All rights reserved.
//

import Foundation


class TasksModel {
    var tasksController: TasksModelOutput?
    
    private var service = TasksService.shared
    
}


// MARK: - Controller Input
extension TasksModel: TasksControllerInput {
    
    func retrieveTasks() {
        let tasks = service.getAll()
        tasksController?.onTasksRetrieval(tasks: tasks)
    }
    
    func retrieveTask(_ uuid: String) {
        if let task = service.get(uuid: uuid) {
            tasksController?.onTaskRetrieval(task: task)
        }
    }
    
    func updateTask(_ task: TaskEntity) {
        if service.update(task) {
            let tasks = service.getAll()
            tasksController?.onTasksUpdated(tasks: tasks)
        }
    }
    
}
