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
    
    var taskUUID: String?
    
    private var task: Task?
}


// MARK: - Controller Input
extension TaskDetailModel: TaskDetailControllerInput {

    func retrieveTaskDetail() {
        self.task = Defaults.getTask(uuid: taskUUID!)
        taskDetailController?.onTaskRetrieval(task: self.task)
    }
    
    func checkTask(done: Bool) {
        self.task!.done = !self.task!.done
        self.task = Defaults.update(self.task!)
        taskDetailController?.onTaskUpdated(task: self.task!)
    }
    
    func deleteTask() {
        if let task = self.task {
            let success = Defaults.delete(task.identifier)
            taskDetailController?.onTaskDeleted(success)
        }
    }
    
}
