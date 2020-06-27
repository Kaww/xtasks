//
//  TaskDetailModel.swift
//  XTasks
//
//  Created by kaww on 08/05/2020.
//  Copyright © 2020 kaww. All rights reserved.
//

import Foundation


class TaskDetailModel {
    var taskDetailController: TaskDetailModelOutput?
    var uuid: String!
    
    private let service = TasksService.shared
    
}


// MARK: - Controller Input
extension TaskDetailModel: TaskDetailControllerInput {

    func retrieveTask() {
        taskDetailController?.onTaskRetrieval(task: service.get(uuid: uuid))
    }
    
    func updateTask(_ task: TaskEntity) {
        if service.update(task) {
            taskDetailController?.onTaskUpdated(task: service.get(uuid: task.taskIdentifier!))
        }
    }
    
    func deleteTask(_ task: TaskEntity) {
        taskDetailController?.onTaskDeleted(success: service.delete(task: task))
    }
    
}
