//
//  TasksViewController.swift
//  XTasks
//
//  Created by kaww on 07/05/2020.
//  Copyright © 2020 kaww. All rights reserved.
//

import UIKit


class TasksViewController: UIViewController {

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Xtasks"
        self.view = tasksView as? UIView
        navigationController?.navigationBar.barStyle = .black
    }
    
    // MARK: - Properties
    var tasksView: TasksControllerOutput?
    var tasksModel: TasksControllerInput?

}


// MARK: - View Input
extension TasksViewController: TasksViewInput {
    
    func onViewLayout() {
        tasksModel?.retrieveTasks()
    }
    
    func onNewTaskTapped() {
        let controller = NewTaskViewController()
        let view = NewTaskView()
        let model = NewTaskModel()
        
        controller.tasksUpdaterDelegate = self
        controller.newTaskView = view
        controller.newTaskView?.newTaskController = controller
        controller.newTaskModel = model
        controller.newTaskModel?.newTaskController = controller
        
        present(controller, animated: true, completion: nil)
    }
    
    func onTaskChecked(index: Int, done: Bool) {
        tasksModel?.checkTask(for: index, done: done)
    }
    
    func onCellSelection(index: Int) {
        tasksModel?.retrieveTaskUUID(for: index)
    }
    
}


// MARK: - Model Output
extension TasksViewController: TasksModelOutput {
    
    func onTasksRetrieval(tasks: [Task]) {
        tasksView?.onTasksRetrieval(tasks: tasks)
    }
    
    func onUUIDRetrieval(uuid: String) {
        let controller = TaskDetailViewController()
        let view = TaskDetailView()
        let model = TaskDetailModel()
        
        controller.tasksUpdaterDelegate = self
        controller.taskDetailView = view
        controller.taskDetailView?.taskDetailController = controller
        controller.taskDetailModel = model
        controller.taskDetailModel?.taskDetailController = controller
        
        model.taskUUID = uuid
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func onTasksUpdated(tasks: [Task]) {
        tasksView?.onTasksUpdated(tasks: tasks)
    }

}


// MARK: - Tasks Updater Delegate
extension TasksViewController: TasksUpdaterDelegate {
    
    func refreshTasksList() {
        tasksModel?.retrieveTasks()
    }
    
}
