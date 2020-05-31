//
//  NewTaskView.swift
//  XTasks
//
//  Created by kaww on 08/05/2020.
//  Copyright © 2020 kaww. All rights reserved.
//

import UIKit


class NewTaskView: UIView {
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        let vc = newTaskController as! NewTaskViewController
        vc.navigationController?.navigationBar.tintColor = Colors.appNegativeColor
        
        newTaskController?.onViewLayout()
    }
    
    // MARK: - Properties
    var newTaskController: NewTaskViewInput?
    
    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(Colors.appNegativeColor, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.textColor = Colors.appTextColor
        label.font = .boldSystemFont(ofSize: 25)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var titleTextField: UITextFieldPadding = {
        let tf = UITextFieldPadding()
        tf.backgroundColor = Colors.appTintLightColor
        tf.textColor = Colors.appTextColor
        tf.layer.cornerRadius = 10
        tf.autocorrectionType = .no
        tf.font = .systemFont(ofSize: 20)
        tf.keyboardAppearance = .dark
        
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        return tf
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.textColor = Colors.appTextColor
        label.font = .boldSystemFont(ofSize: 25)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var descriptionTextView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = Colors.appTintLightColor
        tv.textColor = Colors.appTextColor
        tv.layer.cornerRadius = 10
        tv.autocorrectionType = .no
        tv.keyboardAppearance = .dark
        
        tv.translatesAutoresizingMaskIntoConstraints = false
        
        tv.font = .systemFont(ofSize: 20)
        
        return tv
    }()
    
    lazy var createTaskButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add task", for: .normal)
        button.setTitleColor(Colors.appTextColor, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.backgroundColor = Colors.appNegativeColor
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(createTaskButtonTapped), for: .touchUpInside)
        button.addShadow()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    // MARK: - Actions
    @objc private func cancelButtonTapped() {
        self.newTaskController?.onCancel()
    }
    
    @objc private func createTaskButtonTapped() {
        let title = (titleTextField.text != nil && !titleTextField.text!.isEmptyOrWhitespace()) ? titleTextField.text! : "New task"
        let newTask = Task(title: title, description: descriptionTextView.text ?? "")
        newTaskController?.onCreateTask(task: newTask)
    }
    
}


// MARK: - Controller Output
extension NewTaskView: NewTaskControllerOutput {}


// MARK: - Keyboard managment
extension NewTaskView {
    
    private func setupDismissKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        self.endEditing(true)
    }
    
}


// MARK: - UI Setup
extension NewTaskView {
    
    private func setupUI() {
        self.backgroundColor = Colors.appTintColor
        
        setupDismissKeyboard()
        
        // Setup ScrollView
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(scrollView)
        
        scrollView.addSubview(cancelButton)
        
        // Setup StackView to embed in ScrollView
        let stackView = UIStackView(arrangedSubviews: [titleLabel, titleTextField, descriptionLabel, descriptionTextView, createTaskButton])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.setCustomSpacing(20, after: titleTextField)
        stackView.setCustomSpacing(50, after: descriptionTextView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: self.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: self.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            cancelButton.topAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.topAnchor, constant: 10),
            cancelButton.rightAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.rightAnchor, constant: -20),
            
            titleLabel.widthAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.widthAnchor, constant: -40),
            
            titleTextField.heightAnchor.constraint(equalToConstant: 40),
            titleTextField.widthAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.widthAnchor, constant: -40),
            
            descriptionLabel.widthAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.widthAnchor, constant: -40),
            
            descriptionTextView.heightAnchor.constraint(equalToConstant: 120),
            descriptionTextView.widthAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.widthAnchor, constant: -40),
            
            createTaskButton.heightAnchor.constraint(equalToConstant: 35),
            createTaskButton.widthAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.widthAnchor, constant: -100),
            
            stackView.topAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: 10),
            stackView.leftAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leftAnchor, constant: 10),
            stackView.rightAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.rightAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20)
        ])
    }
    
}
