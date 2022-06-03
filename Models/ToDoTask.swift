//
//  ToDoItem.swift
//  Minimalist Study Timer
//
//  Created by Bradley Malone on 4/17/22.
//

import Foundation

class ToDoTask {
    
    var taskDescription: String?
    let timeCreated: Double?
    
    init(taskDescription: String, timeCreated: Double) // Used when fetching from database
    {
        self.timeCreated = timeCreated
        self.taskDescription = taskDescription
    }
    
    init(_ taskDescription : String)
    {
        self.taskDescription = taskDescription
        self.timeCreated = Date.now.timeIntervalSince1970
    }
    
    func getTaskDescription() -> String
    {
        return taskDescription!
    }
    
    func getTimeStamp() -> Double
    {
        return timeCreated!
    }
    
    
}
