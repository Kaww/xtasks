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
    func onTaskChecked(index: Int, done: Bool)
    func onCellSelection(index: Int)
    
}


/// *Controller* tells the *Model* what to do based on the input
///
/// **Model** conforms to this protocol
protocol TasksControllerInput: class {
    var tasksController: TasksModelOutput? { get set }
    
    func retrieveTasks()
    func retrieveTaskUUID(for index: Int)
    func checkTask(for index: Int, done: Bool)
    
}


/// *Model* returns the result to the *Controller*
///
/// **Controller** conforms to this protocol
protocol TasksModelOutput: class {
    func onTasksRetrieval(tasks: [Task])
    func onUUIDRetrieval(uuid: String)
    func onTasksUpdated(tasks: [Task])
    
}


/// *Controller* returns a UI-representable result to the *View*
///
/// **View** conforms to this protocol
protocol TasksControllerOutput: class {
    var tasksController: TasksViewInput? { get set }
    
    func onTasksRetrieval(tasks: [Task])
    func onTasksUpdated(tasks: [Task])
    
}
