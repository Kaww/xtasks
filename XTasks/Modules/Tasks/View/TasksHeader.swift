//
//  TasksHeader.swift
//  XTasks
//
//  Created by kaww on 09/05/2020.
//  Copyright © 2020 kaww. All rights reserved.
//

import UIKit

class TasksHeader: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {}
    
    // MARK: - Properties
    lazy private var counterLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = Colors.appTextColor
        label.font = .systemFont(ofSize: 25, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy private var completedLabel: UILabel = {
        let label = UILabel()
        label.text = "completed"
        label.textColor = Colors.appTextColor
        label.font = .systemFont(ofSize: 25, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy private var tasksLabel: UILabel = {
        let label = UILabel()
        label.text = "tasks"
        label.textColor = Colors.appTextColor
        label.font = .systemFont(ofSize: 25, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy private var stackView: UIStackView = {
        let stackview = UIStackView(arrangedSubviews: [self.counterLabel, self.completedLabel, self.tasksLabel])
        stackview.axis = .horizontal
        stackview.spacing = 8
        stackview.translatesAutoresizingMaskIntoConstraints = false
        
        return stackview
    }()
    
    lazy private var line: UIView = {
        let line = UIView()
        line.backgroundColor = Colors.appTintLightColor
        line.translatesAutoresizingMaskIntoConstraints = false
        
        return line
    }()
    
    // MARK: - Actions
    func reloadData(done: Int, total: Int) {
        stackView.isHidden = total == 0
        line.isHidden = total == 0
        counterLabel.text = "\(done)/\(total)"
    }
    
}


// MARK: - UI Setup
extension TasksHeader {
    
    private func setupUI() {
        self.clipsToBounds = true
        
        self.addSubview(line)
        self.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            line.heightAnchor.constraint(equalToConstant: 1),
            line.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -40),
            line.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            line.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: self.frame.height * 0.2)
        ])
    }
    
}
