//
//  ToDoViewController.swift
//  Minimalist Study Timer
//
//  Created by Bradley Malone on 4/17/22.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class ToDoViewController: UIViewController {
    
    @IBOutlet weak var newTaskField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    static var databaseBrain = DatabaseBrain()
    private let db = Firestore.firestore()

    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        
        tableView.backgroundColor = UIColor.clear
        
        newTaskField.delegate = self
        ToDoViewController.databaseBrain.setDelegate(self)
        
        
        if (!DatabaseBrain.isUserLoggedIn())
        {
            userNotLoggedIn()
        }
        else
        {
            
            tableView.dataSource = self
            tableView.register(UINib(nibName: "ToDoTaskCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")

            ToDoViewController.databaseBrain.loadTaskData()
            tableView.reloadData()
        }
        
    }

    @IBAction func addTaskPress(_ sender: Any) {
        
        if let task = newTaskField.text
        {
            if(task != "")
            {
                if(DatabaseBrain.isUserLoggedIn())
                {
                    ToDoViewController.databaseBrain.addNewTask(taskDescription: task)
                    newTaskField.placeholder = ""
                    newTaskField.endEditing(true)
                    newTaskField.text = ""
                }
                
                else
                {
                    userNotLoggedIn()
                }
                
            }
            
            else
            {
                newTaskField.placeholder = "Can't be empty"
            }
            
        }
    }
    
}
    
extension ToDoViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ToDoViewController.databaseBrain.numberOfTasks();
    }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! ToDoTaskCell
            
            cell.taskLabel.text = ToDoViewController.databaseBrain.getTaskDescription()
                
            
            return cell
        }
    

    }

extension ToDoViewController: DatabaseBrainDelegate
{
    func userNotLoggedIn() {
        
        ToDoViewController.databaseBrain.clearTaskData()
        tabBarController?.selectedIndex = 0
        self.performSegue(withIdentifier: "GoToAccountView", sender: self)
        tableView.reloadData()
    }
    
    func updateDataDisplay() {
        tableView.reloadData()
    }
}

extension ToDoViewController : UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      
        if(textField.text != "")
        {
            textField.endEditing(true)
            self.addTaskPress(self)
            return true
        }
        
        textField.endEditing(false)
        textField.placeholder = "Can't be empty"
        return false
    }
        
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
       
        if textField.text == ""
        {
            textField.placeholder = "Can't be empty"
            return false
        }
        
        return true
        
    }
}
    
