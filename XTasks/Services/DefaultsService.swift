//
//  DefaultsService.swift
//  XTasks
//
//  Created by kaww on 07/05/2020.
//  Copyright © 2020 kaww. All rights reserved.
//

import Foundation


struct Defaults {
    
    static let tasksKey = "tasks_key"
    private static let userDefault = UserDefaults.standard
    
    static func save(_ tasks: [Task]) {
        if let encoded = try? JSONEncoder().encode(tasks) {
            userDefault.set(encoded, forKey: tasksKey)
        }
    }
    
}


// MARK: - CREATE Methods
extension Defaults {
    
    static func create(_ task: Task) -> Task? {
        if let data = userDefault.data(forKey: tasksKey) {
            if var decoded = try? JSONDecoder().decode([Task].self, from: data) {
                decoded.insert(task, at: 0)
                self.save(decoded)
                
                return decoded[0]
            }
        }
        self.save([task])
        return task
    }
    
}


// MARK: - READ Methods
extension Defaults {
    
    static func getTasks() -> [Task] {
        if let data = userDefault.data(forKey: tasksKey) {
            if let decoded = try? JSONDecoder().decode([Task].self, from: data) {
                return decoded
            }
        }
        let mockedTasks = [
            Task(title: "Having fun codding the test !", description: "Yeahh !"),
            Task(title: "Finish the technical test", description: "Finish the technical test given by iOS team"),
            Task(title: "Add nice features to the technical test", description: "Add some elegant or funny features. Maybe I'll try to do some soft ui"),
            Task(title: "Upload the test", description: "The test must be sent zipped by email to Heloïse. Persent my work in the email"),
            Task("Wait for the response..."),
            Task("New task"),
            Task("New task"),
            Task("New task")
        ]
        save(mockedTasks)
        return mockedTasks
    }
    
    static func getTask(uuid: String) -> Task? {
        if let data = userDefault.data(forKey: tasksKey) {
            if let decoded = try? JSONDecoder().decode([Task].self, from: data) {
                return decoded.first(where: { $0.identifier == uuid })
            }
        }
        return nil
    }
    
}


// MARK: - UPDATE Methods
extension Defaults {
    
    static func update(_ task: Task) -> Task? {
        if let data = userDefault.data(forKey: tasksKey) {
            if var decoded = try? JSONDecoder().decode([Task].self, from: data) {
                if let index = decoded.firstIndex(where: { $0.identifier == task.identifier }) {
                    decoded[index] = task
                    self.save(decoded)
                    
                    return decoded[index]
                }
            }
        }
        return nil
    }
    
}


// MARK: - DELETE Methods
extension Defaults {
    
    static func delete(_ uuid: String) -> Bool {
        if let data = userDefault.data(forKey: tasksKey) {
            if var decoded = try? JSONDecoder().decode([Task].self, from: data) {
                if let index = decoded.firstIndex(where: { $0.identifier == uuid }) {
                    decoded.remove(at: index)
                    self.save(decoded)

                    return true
                }
            }
        }
        return false
    }
    
}
