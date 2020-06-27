//
//  TaskDetailContract.swift
//  XTasks
//
//  Created by kaww on 08/05/2020.
//  Copyright © 2020 kaww. All rights reserved.
//

import Foundation


/// *View* sends user actions to the *Controller*.
///
/// **Controller** conforms to this protocol
protocol TaskDetailViewInput: class {
    var taskDetailView: TaskDetailControllerOutput? { get set }
    var taskDetailModel: TaskDetailControllerInput? { get set }
    
    func onViewLayout() //
    func onUpdateTask(_ task: TaskEntity) //
    func onDeleteTask(_ task: TaskEntity) //
}


/// *Controller* tells the *Model* what to do based on the input
///
/// **Model** conforms to this protocol
protocol TaskDetailControllerInput: class {
    var taskDetailController: TaskDetailModelOutput? { get set }
    
    func retrieveTask() //
    func updateTask(_ task: TaskEntity) //
    func deleteTask(_ task: TaskEntity) //
}


/// *Model* returns the result to the *Controller*
///
/// **Controller** conforms to this protocol
protocol TaskDetailModelOutput: class {
    func onTaskRetrieval(task: TaskEntity?) //
    func onTaskUpdated(task: TaskEntity?) //
    func onTaskDeleted(success didSuccess: Bool)
}


/// *Controller* returns a UI-representable result to the *View*
///
/// **View** conforms to this protocol
protocol TaskDetailControllerOutput: class {
    var taskDetailController: TaskDetailViewInput? { get set }
    
    func onTaskRetrieval(task: TaskEntity) //
    
}
