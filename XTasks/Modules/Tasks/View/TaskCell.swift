//
//  TaskCell.swift
//  XTasks
//
//  Created by kaww on 07/05/2020.
//  Copyright © 2020 kaww. All rights reserved.
//

import UIKit


class TaskCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
    // MARK: - Properties
    var delegate: TaskActionsDelegate!
    
    var task: TaskEntity! {
        didSet {
            self.addGradientWithCornerRadius(startColor: Colors.appTintColor2, endColor: Colors.appTintColor1, radius: 10)
            checkButton.backgroundColor = self.task.taskDone ? Colors.appPositiveColor : Colors.appNegativeColor
            checkButton.setTitle(self.task.taskDone ? "✔️" : "", for: .normal)
            self.titleLabel.text = task.taskTitle
        }
    }
    
    let checkButton = UIButton()
    let titleLabel = UILabel()
    
    // MARK: - Actions
    @objc private func checkButtonTapped() {
        self.task.taskDone.toggle()
        self.delegate.onTaskActionChecked(task: self.task)
    }
    
}


// MARK: - UI Setup
extension TaskCell {
    
    private func setupUI() {
        self.layer.cornerRadius = 10
        self.addShadow()
        setupCheckButton()
        setupTitle()
    }
    
    private func setupCheckButton() {
        checkButton.layer.cornerRadius = 20
        checkButton.titleLabel?.font = .systemFont(ofSize: 30)
        checkButton.backgroundColor = Colors.appTextColor
        checkButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        checkButton.addShadow()
        self.addSubview(checkButton)
        
        NSLayoutConstraint.activate([
            checkButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            checkButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            checkButton.widthAnchor.constraint(equalToConstant: 40),
            checkButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupTitle() {
        self.titleLabel.font = .systemFont(ofSize: 20, weight: .medium)
        self.titleLabel.textColor = Colors.appTextColor
        self.titleLabel.text = ""
        self.titleLabel.numberOfLines = 3
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            self.titleLabel.leftAnchor.constraint(equalTo: checkButton.rightAnchor, constant: 20),
            self.titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            self.titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
}

