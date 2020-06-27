//
//  TasksContract.swift
//  XTasks
//
//  Created by kaww on 07/05/2020.
//  Copyright © 2020 kaww. All rights reserved.
//

import UIKit


/// *View* sends user actions to the *Controller*.
///
/// **Controller** conforms to this protocol
protocol TasksViewInput: class {
    var tasksView: TasksControllerOutput? { get set }
    var tasksModel: TasksControllerInput? { get set }
    
    func onViewLayout()
    func onNewTaskTapped()
    func onUpdateTask(_ task: TaskEntity)
    func onTaskSelection(uuid: String)
    
}


/// *Controller* tells the *Model* what to do based on the input
///
/// **Model** conforms to this protocol
protocol TasksControllerInput: class {
    var tasksController: TasksModelOutput? { get set }
    
    func retrieveTasks()
    func retrieveTask(_ uuid: String)
    func updateTask(_ task: TaskEntity)
    
}


/// *Model* returns the result to the *Controller*
///
/// **Controller** conforms to this protocol
protocol TasksModelOutput: class {
    func onTasksRetrieval(tasks: [TaskEntity])
    func onTaskRetrieval(task: TaskEntity)
    func onTasksUpdated(tasks: [TaskEntity])
    
}


/// *Controller* returns a UI-representable result to the *View*
///
/// **View** conforms to this protocol
protocol TasksControllerOutput: class {
    var tasksController: TasksViewInput? { get set }
    
    func onTasksRetrieval(tasks: [TaskEntity])
    func onTasksUpdated(tasks: [TaskEntity])
    
}
