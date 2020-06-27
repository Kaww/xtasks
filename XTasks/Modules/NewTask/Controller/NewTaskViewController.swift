//
//  NewTaskViewController.swift
//  XTasks
//
//  Created by kaww on 08/05/2020.
//  Copyright © 2020 kaww. All rights reserved.
//

import UIKit


class NewTaskViewController: UIViewController {

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "New task"
        self.view = newTaskView as? UIView
    }
    
    // MARK: - Properties
    var newTaskView: NewTaskControllerOutput?
    var newTaskModel: NewTaskControllerInput?
    
    var tasksUpdaterDelegate: TasksUpdaterDelegate?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }
}


// MARK: - View Input
extension NewTaskViewController: NewTaskViewInput {
    
    func onViewLayout() {}
    
    func onCreateTask(task: Task) {
        newTaskModel?.createTask(task: task)
    }
    
    func onCancel() {
        self.tasksUpdaterDelegate?.refreshTasksList()
        dismiss(animated: true, completion: nil)
    }
    
}


// MARK: - Model Output
extension NewTaskViewController: NewTaskModelOutput {
    
    func onTaskCreated(success didSuccess: Bool) {
        if didSuccess {
            self.tasksUpdaterDelegate?.refreshTasksList()
            dismiss(animated: true, completion: nil)
        }
    }
    
}
