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
    
    private var tasks = [Task]()
    
}


// MARK: - Controller Input
extension TasksModel: TasksControllerInput {
    
    func retrieveTasks() {
        self.tasks = Defaults.getTasks()
        tasksController?.onTasksRetrieval(tasks: self.tasks)
    }
    
    func retrieveTaskUUID(for index: Int) {
        if self.tasks.count >= index + 1 {
            let uuid = self.tasks[index].identifier
            tasksController?.onUUIDRetrieval(uuid: uuid)
        }
    }
    
    func checkTask(for index: Int, done: Bool) {
        if self.tasks.count >= index + 1 {
            self.tasks[index].done = done
            Defaults.save(self.tasks)
            
            tasksController?.onTasksUpdated(tasks: self.tasks)
        }
    }
    
}
