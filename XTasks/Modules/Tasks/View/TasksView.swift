//
//  TasksView.swift
//  XTasks
//
//  Created by kaww on 07/05/2020.
//  Copyright © 2020 kaww. All rights reserved.
//

import UIKit


class TasksView: UIView {
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        let vc = tasksController as! TasksViewController
        let attributes = [NSAttributedString.Key.foregroundColor: Colors.appTextColor]
        
        vc.navigationItem.rightBarButtonItem = newTaskButton
        vc.navigationController?.navigationBar.titleTextAttributes = attributes
        
        tasksController?.onViewLayout()
    }
    
    // MARK: - Properties
    var tasksController: TasksViewInput?
    private var tasks = [Task]()
    
    lazy var newTaskButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newTaskButtonTapped))
        button.tintColor = Colors.appNegativeColor
        
        return button
    }()
    
    private let cellID = "itemID"
    private let headerID = "headerID"
    
    var headerView: TasksHeader?
    
    lazy var collectionView: UICollectionView = {
        let layout = StretchyHeaderLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = Colors.appTintColor
        cv.showsVerticalScrollIndicator = false
        
        cv.register(TaskCell.self, forCellWithReuseIdentifier: cellID)
        cv.register(TasksHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID)
        
        cv.translatesAutoresizingMaskIntoConstraints = false
        
        return cv
    }()
    
    lazy var placeholder: UIStackView = {
        let label = UILabel()
        label.text = "You don't have any task..."
        label.numberOfLines = 2
        label.textColor = Colors.appTextColor
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let button = UIButton()
        button.backgroundColor = Colors.appTextColor
        button.setTitle("Create one !", for: .normal)
        button.setTitleColor(Colors.appTintColor, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(newTaskButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let sv = UIStackView(arrangedSubviews: [label, button])
        sv.axis = .vertical
        sv.alignment = .center
        sv.spacing = 10
        sv.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 180)
        ])
        
        return sv
    }()
    
    
    // MARK: - Actions
    @objc private func newTaskButtonTapped() {
        tasksController?.onNewTaskTapped()
    }
    
    private func reloadHeader() {
        var doneCount = 0
        for task in self.tasks {
            if task.done {
                doneCount += 1
            }
        }
        self.headerView?.reloadData(done: doneCount, total: self.tasks.count)
    }
    
}


// MARK: - Controller Output
extension TasksView: TasksControllerOutput {
    
    func onTasksRetrieval(tasks: [Task]) {
        self.tasks = tasks
        placeholder.isHidden = self.tasks.count > 0
        self.collectionView.reloadData()
        reloadHeader()
    }
    
    func onTasksUpdated(tasks: [Task]) {
        self.tasks = tasks
        placeholder.isHidden = self.tasks.count > 0
        self.collectionView.reloadData()
        reloadHeader()
    }
    
}


// MARK: - UICollectionView Delegates & DataSource
extension TasksView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tasks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! TaskCell
        cell.delegate = self
        cell.task = tasks[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: self.collectionView.frame.width - 40, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        tasksController?.onCellSelection(index: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID, for: indexPath)
        if let headerView = header as? TasksHeader {
            self.headerView = headerView
            self.reloadHeader()
        }
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: self.collectionView.frame.width - 40, height: 80)
    }
    
}


// MARK: - Tasks Actions Delegate
extension TasksView: TaskActionsDelegate {
    
    func onTaskActionChecked(uuid: String, done: Bool) {
        if let index = tasks.firstIndex(where: { $0.identifier == uuid }) {
            tasksController?.onTaskChecked(index: index, done: done)
        }
    }
    
}


// MARK: - UI Setup
extension TasksView {
    
    private func setupUI() {
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        self.backgroundColor = Colors.appTintColor
        
        self.addSubview(collectionView)
        self.addSubview(placeholder)
        
        NSLayoutConstraint.activate([
            placeholder.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -50),
            placeholder.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            placeholder.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
}
