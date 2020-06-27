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
        taskDetailModel?.retrieveTask()
    }
    
    func onUpdateTask(_ task: TaskEntity) {
        taskDetailModel?.updateTask(task)
    }
    
    func onDeleteTask(_ task: TaskEntity) {
        taskDetailModel?.deleteTask(task)
    }
    
}


// MARK: - Model Output
extension TaskDetailViewController: TaskDetailModelOutput {
    
    func onTaskRetrieval(task: TaskEntity?) {
        guard let task = task else {
            navigationController?.popViewController(animated: true)
            return
        }
        taskDetailView?.onTaskRetrieval(task: task)
    }
    
    func onTaskUpdated(task: TaskEntity?) {
        guard let task = task else {
            navigationController?.popViewController(animated: true)
            return
        }
        tasksUpdaterDelegate?.refreshTasksList()
        taskDetailView?.onTaskRetrieval(task: task)
    }
    
    func onTaskDeleted(success didSuccess: Bool) {
        if didSuccess {
            navigationController?.popViewController(animated: true)
        }
    }

}


