//
//  NewTaskContract.swift
//  XTasks
//
//  Created by kaww on 08/05/2020.
//  Copyright © 2020 kaww. All rights reserved.
//

import Foundation


/// *View* sends user actions to the *Controller*.
///
/// **Controller** conforms to this protocol
protocol NewTaskViewInput: class {
    var newTaskView: NewTaskControllerOutput? { get set }
    var newTaskModel: NewTaskControllerInput? { get set }
    
    func onViewLayout()
    func onCreateTask(task: Task)
    func onCancel()
}


/// *Controller* tells the *Model* what to do based on the input
///
/// **Model** conforms to this protocol
protocol NewTaskControllerInput: class {
    var newTaskController: NewTaskModelOutput? { get set }
    
    func createTask(task: Task)
    
}


/// *Model* returns the result to the *Controller*
///
/// **Controller** conforms to this protocol
protocol NewTaskModelOutput: class {
    func onTaskCreated(success didSuccess: Bool)
    
}


/// *Controller* returns a UI-representable result to the *View*
///
/// **View** conforms to this protocol
protocol NewTaskControllerOutput: class {
    var newTaskController: NewTaskViewInput? { get set }
    
}
