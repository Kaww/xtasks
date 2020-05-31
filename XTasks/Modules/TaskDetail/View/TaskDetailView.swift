//
//  TaskDetailView.swift
//  XTasks
//
//  Created by kaww on 08/05/2020.
//  Copyright © 2020 kaww. All rights reserved.
//

import UIKit


class TaskDetailView: UIView {
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        updateView()
        
        taskDetailController?.onViewLayout()
    }
    
    // MARK: - Properties
    var taskDetailController: TaskDetailViewInput?
    var task: Task? {
        didSet {
            updateView()
        }
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 10
        label.textColor = Colors.appTextColor
        label.font = .boldSystemFont(ofSize: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 20
        label.textColor = Colors.appTextColor
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var checkButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Colors.appNegativeColor
        button.setTitleColor(Colors.appTextColor, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        
        button.addShadow()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Colors.appDescructiveColor
        button.setTitle("Delete task", for: .normal)
        button.setTitleColor(Colors.appTextColor, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        
        button.addShadow()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    // MARK: - Actions
    @objc private func checkButtonTapped() {
        if let check = task?.done {
            taskDetailController?.onTaskChecked(done: check)
        }
    }
    
    @objc private func deleteButtonTapped() {
        taskDetailController?.onDeleteTask()
    }
    
    private func updateView() {
        guard let task = self.task else { return }
        
        let color: UIColor = task.done ? Colors.appPositiveColor : Colors.appNegativeColor
        
        let vc = taskDetailController as! TaskDetailViewController
        vc.title = task.done ? "Task ✓" : "Task ✗"
        vc.navigationController?.navigationBar.tintColor = color
        self.backgroundColor = Colors.appTintColor
        
        titleLabel.text = task.title
        descriptionLabel.text = task.description
        checkButton.backgroundColor = color
        checkButton.setTitle(task.done ? "Mark as not done" : "Mark as done", for: .normal)
    }
}


// MARK: - Controller Output
extension TaskDetailView: TaskDetailControllerOutput {
    
    func onTaskRetrieval(task: Task) {
        self.task = task
    }
    
}


// MARK: - UI Setup
extension TaskDetailView {
    
    private func setupUI() {
        self.backgroundColor = Colors.appTintColor
        
        // Setup ScrollView
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(scrollView)
        
        // Setup StackView to embed in ScrollView
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel, checkButton, deleteButton])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 20
        stackView.setCustomSpacing(50, after: descriptionLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: self.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: self.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            checkButton.heightAnchor.constraint(equalToConstant: 40),
            checkButton.widthAnchor.constraint(equalToConstant: 200),
            
            deleteButton.heightAnchor.constraint(equalToConstant: 35),
            deleteButton.widthAnchor.constraint(equalToConstant: 150),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            stackView.leftAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leftAnchor, constant: 10),
            stackView.rightAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.rightAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20)
        ])
    }
    
}
