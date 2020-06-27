//
//  TasksService.swift
//  XTasks
//
//  Created by kaww on 26/06/2020.
//  Copyright © 2020 kaww. All rights reserved.
//

import UIKit
import CoreData


class TasksService {
    
    static let shared = TasksService()
    
    private init() {}
    
    private let context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var tasks: [TaskEntity] {
        get {
            return self.getAll()
        }
    }
    
}


// MARK: - CREATE Tasks
extension TasksService {
    
    func create(_ task: Task) -> Bool {
        print("create task - \(task.title)")
        let newTaskEntity = TaskEntity(context: context)
        newTaskEntity.taskTitle = task.title
        newTaskEntity.taskDescription = task.description
        newTaskEntity.taskDone = task.done
        newTaskEntity.taskIdentifier = task.identifier
        
        do {
            try self.context.save()
            return true
        } catch {
            print("Could not save new created task -> \(error.localizedDescription)")
            return false
        }
    }
    
}


// MARK: - READ Tasks
extension TasksService {
    
    func getAll() -> [TaskEntity] {
        print("get all tasks")
        let taskRequest: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        
        do {
            return try context.fetch(taskRequest)
        } catch {
            print("Could no get tasks -> \(error.localizedDescription)")
            return []
        }
    }
    
    func get(uuid: String) -> TaskEntity? {
        print("get task by uuid - \(uuid)")
        let taskRequest: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        taskRequest.predicate = NSPredicate(format: "taskIdentifier == %@", uuid)
        taskRequest.fetchLimit = 1
        
        do {
            return try context.fetch(taskRequest).first
        } catch {
            print("Could no get tasks -> \(error.localizedDescription)")
            return nil
        }
    }
    
}


// MARK: - UPDATE Tasks
extension TasksService {
    
    func update(_ task: TaskEntity) -> Bool {
        print("update task - \(task.taskTitle!)")
        
        do {
            try self.context.save()
            return true
        } catch {
            print("Could not update task -> \(error.localizedDescription)")
            return false
        }
    }
    
}


// MARK: - DELETE Tasks
extension TasksService {
    
    func delete(task: TaskEntity) -> Bool {
        print("delete task - \(task.taskTitle!)")
        context.delete(task)
        
        do {
            try context.save()
            return true
        } catch {
            print("Count not delete task -> \(error.localizedDescription)")
            return false
        }
    }
    
}
