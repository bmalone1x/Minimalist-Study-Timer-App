//
//  ToDoTaskCell.swift
//  Minimalist Study Timer
//
//  Created by Bradley Malone on 4/17/22.
//

import UIKit
import FirebaseFirestore

class ToDoTaskCell: UITableViewCell {
    
    private let db = Firestore.firestore()

    @IBOutlet weak var taskLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    @IBAction func taskCompletePress(_ sender: UIButton) {
        
        print("Task Complete Button Press")
        
        if let task = taskLabel.text
        {
            db.collection("tasks").document(task).delete()
            
            ToDoViewController.databaseBrain.deleteTask(taskDescription: task)
            print("deleted task")
            
        }
    }
    
    }
