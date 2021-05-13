//
//  AddUpdateTodoListVC.swift
//  ToDoMotilalAssigment
//
//  Created by Rupali Patil on 12/05/21.
//  Copyright © 2021 63moons. All rights reserved.
//

import UIKit
import CoreData

class AddUpdateTodoListVC: UIViewController {

    @IBOutlet weak var m_cTaskDescription: UITextView!
    @IBOutlet weak var m_cTaskName       : UITextField!
    @IBOutlet weak var m_cSavebtn        : UIButton!
    @IBOutlet weak var m_cCancelbtn      : UIButton!
    
    var m_bIsOnClick: Int!
    var m_cTodaysTask: Today!
    var m_cTomarrowTask: Tomarrow!
    var m_cUpComingTask: UpComing!
    var m_bIsSaveDialoag: Bool!
    
    
    weak var delegate: ProtocolDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
   //     self.m_cUpdateDeleteStackView.isHidden = true
        self.m_cTaskDescription.layer.cornerRadius = 0.5
        self.m_cTaskDescription.layer.borderWidth = 1
        self.m_cTaskDescription.layer.borderColor = UIColor.lightGray.cgColor
        self.m_cTaskDescription.clipsToBounds = true

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if self.m_bIsSaveDialoag
        {
            self.m_cTaskName.text = ""
            self.m_cTaskDescription.text = ""
            self.m_cSavebtn.setTitle("SAVE", for: .normal)
            self.m_cCancelbtn.setTitle("CANCEL", for: .normal)
        }else{
            if m_bIsOnClick == 1
            {
                self.m_cTaskName.text = self.m_cTodaysTask.taskName
                self.m_cTaskDescription.text = self.m_cTodaysTask.taskDescription
            }else if m_bIsOnClick == 2{
               self.m_cTaskName.text = self.m_cTomarrowTask.taskName
                self.m_cTaskDescription.text = self.m_cTomarrowTask.taskDescription
            }else if m_bIsOnClick == 3
            {
               self.m_cTaskName.text = self.m_cUpComingTask.taskName
                self.m_cTaskDescription.text = self.m_cUpComingTask.taskDescription
            }
            
            self.m_cSavebtn.setTitle("UPDATE", for: .normal)
            self.m_cCancelbtn.setTitle("DELETE", for: .normal)
        }
    }
    
    
    
    @IBAction func onUpdate_click(_ sender: Any)
    {
        if self.m_cSavebtn.titleLabel?.text == "SAVE"
        {
            //As we know that container is set up in the AppDelegates so we need to refer that container.
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            
            //We need to create a context from this container
            let managedContext = appDelegate.persistentContainer.viewContext
            
            if m_bIsOnClick == 1
            {
            //Now let’s create an entity and new user records.
            
            let userEntity = NSEntityDescription.entity(forEntityName: "Today", in: managedContext)!
            
             let userTaskToDo = NSManagedObject(entity: userEntity, insertInto: managedContext) as! Today
          
                userTaskToDo.taskName = self.m_cTaskName.text
                userTaskToDo.taskDescription = self.m_cTaskDescription.text
                
            }else if m_bIsOnClick == 2
            {
                //Now let’s create an entity and new user records.
                
                let userEntity = NSEntityDescription.entity(forEntityName: "Tomarrow", in: managedContext)!
                
                 let userTaskToDo = NSManagedObject(entity: userEntity, insertInto: managedContext) as! Tomarrow
                
                userTaskToDo.taskName = self.m_cTaskName.text
                userTaskToDo.taskDescription = self.m_cTaskDescription.text
                
            }else if m_bIsOnClick == 3
            {
                //Now let’s create an entity and new user records.
                
                let userEntity = NSEntityDescription.entity(forEntityName: "UpComing", in: managedContext)!
                
                 let userTaskToDo = NSManagedObject(entity: userEntity, insertInto: managedContext) as! UpComing
                
                userTaskToDo.taskName = self.m_cTaskName.text
                userTaskToDo.taskDescription = self.m_cTaskDescription.text
            }
            //Now we have set all the values. The next step is to save them inside the Core Data
            
            do {
                try managedContext.save()
               
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            
            
        }else{
            //As we know that container is set up in the AppDelegates so we need to refer that container.
                   guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
                   
                   //We need to create a context from this container
                   let managedContext = appDelegate.persistentContainer.viewContext
                 if m_bIsOnClick == 1
                 {
                    let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Today")
                    
                    fetchRequest.predicate = NSPredicate(format: "taskName = %@", self.m_cTodaysTask.taskName!)
                    
                    do
                    {
                        
                        let lcToday = try managedContext.fetch(fetchRequest) as! [Today]
                        
                        let objectUpdate = lcToday[0] as Today
                        objectUpdate.taskName = m_cTaskName.text
                        objectUpdate.taskDescription = m_cTaskDescription.text
                        
                        do{
                            try managedContext.save()
                        }
                        catch
                        {
                            print(error)
                        }
                    }
                    catch
                    {
                        print(error)
                    }
                    
                 }else if m_bIsOnClick == 2
                 {
                    let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Tomarrow")
                    
                    fetchRequest.predicate = NSPredicate(format: "taskName = %@", self.m_cTomarrowTask.taskName!)
                    
                    do
                    {
                        
                        let lcToday = try managedContext.fetch(fetchRequest) as! [Tomarrow]
                        
                        let objectUpdate = lcToday[0] as Tomarrow
                        objectUpdate.taskName = m_cTaskName.text
                        objectUpdate.taskDescription = m_cTaskDescription.text
                        
                        do{
                            try managedContext.save()
                        }
                        catch
                        {
                            print(error)
                        }
                    }
                    catch
                    {
                        print(error)
                    }
                    
                 }else if m_bIsOnClick == 3
                 {
                    let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "UpComing")
                    
                    fetchRequest.predicate = NSPredicate(format: "taskName = %@", self.m_cUpComingTask.taskName!)
                    
                    do
                    {
                        
                        let lcToday = try managedContext.fetch(fetchRequest) as! [UpComing]
                        
                        let objectUpdate = lcToday[0] as UpComing
                        objectUpdate.taskName = m_cTaskName.text
                        objectUpdate.taskDescription = m_cTaskDescription.text
                        
                        do{
                            try managedContext.save()
                        }
                        catch
                        {
                            print(error)
                        }
                    }
                    catch
                    {
                        print(error)
                    }
            }
                 
              
        }
        
        delegate?.retriveData()
        self.view.removeFromSuperview()
        
    }
    
    @IBAction func onDelete_Click(_ sender: Any) {
        
        if self.m_cCancelbtn.titleLabel?.text == "CANCEL"
        {
            self.view.removeFromSuperview()
        }else{
            //As we know that container is set up in the AppDelegates so we need to refer that container.
                   guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
                   
                   //We need to create a context from this container
                   let managedContext = appDelegate.persistentContainer.viewContext
                   
            if m_bIsOnClick == 1
            {
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Today")
                fetchRequest.predicate = NSPredicate(format: "taskName = %@", self.m_cTodaysTask.taskName!)
                
                do
                {
                    let test = try managedContext.fetch(fetchRequest)
                    
                    let objectToDelete = test[0] as! Today
                    managedContext.delete(objectToDelete)
                    
                    do{
                        try managedContext.save()
                    }
                    catch
                    {
                        print(error)
                    }
                    
                }
                catch
                {
                    print(error)
                }
            }else if m_bIsOnClick == 2
            {
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Tomarrow")
                fetchRequest.predicate = NSPredicate(format: "taskName = %@", self.m_cTomarrowTask.taskName!)
                
                do
                {
                    let test = try managedContext.fetch(fetchRequest)
                    
                    let objectToDelete = test[0] as! Tomarrow
                    managedContext.delete(objectToDelete)
                    
                    do{
                        try managedContext.save()
                    }
                    catch
                    {
                        print(error)
                    }
                    
                }
                catch
                {
                    print(error)
                }
            }else if m_bIsOnClick == 3
            {
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UpComing")
                fetchRequest.predicate = NSPredicate(format: "taskName = %@", self.m_cUpComingTask.taskName!)
                
                do
                {
                    let test = try managedContext.fetch(fetchRequest)
                    
                    let objectToDelete = test[0] as! UpComing
                    managedContext.delete(objectToDelete)
                    
                    do{
                        try managedContext.save()
                    }
                    catch
                    {
                        print(error)
                    }
                    
                }
                catch
                {
                    print(error)
                }
            }
            
                delegate?.retriveData()
                self.view.removeFromSuperview()
        }
    }
    
}
