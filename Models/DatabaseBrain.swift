//
//  DatabaseBrain.swift
//  Minimalist Study Timer
//
//  Created by Bradley Malone on 4/19/22.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import UIKit

protocol DatabaseBrainDelegate
{
     func updateDataDisplay()
     func userNotLoggedIn()
}

class DatabaseBrain
{

    let db = Firestore.firestore()
    var tasks: [ToDoTask]
    var delegate: DatabaseBrainDelegate?
    var currentTaskToLoad: Int?
    
    init()
    {
        self.tasks = []
        delegate = nil
        currentTaskToLoad = 0
    }
    
    func setDelegate(_ viewController: DatabaseBrainDelegate)
    {
        self.delegate = viewController
    }
    
    static func isUserLoggedIn() -> Bool
    {
        let user = Auth.auth().currentUser
        
        if(user == nil)
        {
            return false
        }
        else
        {
            return true
        }
    }
    
    static func getUserEmail() -> String?
    {
        let email = Auth.auth().currentUser?.email
        return email
    }
    
    func clearTaskData()
    {
        self.tasks = []
    }
    
    func loadTaskData()
    {
        self.clearTaskData()
        self.currentTaskToLoad = 0
     
        if let email = DatabaseBrain.getUserEmail()
             {
     
                 db.collection("tasks").document(email)
                 .addSnapshotListener { (documentSnapshot, error) in
     
                     self.clearTaskData()
                     self.currentTaskToLoad = 0
     
                     guard let document = documentSnapshot else
                     {
                         print("Error fetching document: \(error!)")
                         return
                     }
                     guard let data = document.data()
                     else
                     {
                         print("Document data was empty.")
                         return
                     }
     
                     for task in data
                     {
                         let newTask = ToDoTask(taskDescription: task.key, timeCreated: task.value as! Double)
                         

                         self.tasks.append(newTask)
                         
                         self.sortTasks()
                     }
                     
                     self.delegate?.updateDataDisplay()
                 }
             }
    }
    
    func sortTasks()
    {
        self.tasks = tasks.sorted() {$0.timeCreated! < $1.timeCreated!}
    }
    
    func addNewTask(taskDescription : String)
    {
        if let email = DatabaseBrain.getUserEmail()
        {
            let newTask = ToDoTask(taskDescription)
            
            db.collection("tasks").document(email).setData([ newTask.getTaskDescription(): newTask.getTimeStamp() as Any ], merge: true)
            
            self.loadTaskData()
            self.delegate?.updateDataDisplay()
        }
    }
    
    func numberOfTasks() -> Int
    {
        return tasks.count
    }
    
    func getTaskDescription() -> String
    {
        let task = tasks[currentTaskToLoad!]

        if(currentTaskToLoad != tasks.count - 1)
        {
            currentTaskToLoad! += 1
        }
        
        return task.getTaskDescription()
        
    }
    
     func deleteTask(taskDescription: String)
    {
        if(DatabaseBrain.isUserLoggedIn())
        {
            if let email = DatabaseBrain.getUserEmail()
            {
                self.currentTaskToLoad! = 0
                
                Firestore.firestore().collection("tasks").document(email).updateData([taskDescription : FieldValue.delete()])
                
                
            }
        }
    }
    
}



