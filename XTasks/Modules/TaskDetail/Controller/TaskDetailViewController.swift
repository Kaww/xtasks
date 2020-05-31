//
//  TaskDetailViewController.swift
//  XTasks
//
//  Created by kaww on 08/05/2020.
//  Copyright © 2020 kaww. All rights reserved.
//

import UIKit


class TaskDetailViewController: UIViewController {

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Task"
        self.view = taskDetailView as? UIView
    }
    
    // MARK: - Properties
    var taskDetailView: TaskDetailControllerOutput?
    var taskDetailModel: TaskDetailControllerInput?
    
    var tasksUpdaterDelegate: TasksUpdaterDelegate?
}


// MARK: - View Input
extension TaskDetailViewController: TaskDetailViewInput {
    
    func onViewLayout() {
        taskDetailModel?.retrieveTaskDetail()
    }
    
    func onTaskChecked(done: Bool) {
        taskDetailModel?.checkTask(done: done)
    }
    
    func onDeleteTask() {
        taskDetailModel?.deleteTask()
    }
    
}


// MARK: - Model Output
extension TaskDetailViewController: TaskDetailModelOutput {
    
    func onTaskRetrieval(task: Task?) {
        guard let task = task else {
            navigationController?.popViewController(animated: true)
            return
        }
        taskDetailView?.onTaskRetrieval(task: task)
    }
    
    func onTaskUpdated(task: Task?) {
        guard let task = task else {
            navigationController?.popViewController(animated: true)
            return
        }
        tasksUpdaterDelegate?.refreshTasksList()
        taskDetailView?.onTaskRetrieval(task: task)
    }
    
    func onTaskDeleted(_ didSuccess: Bool) {
        if didSuccess {
            navigationController?.popViewController(animated: true)
        }
    }

}


