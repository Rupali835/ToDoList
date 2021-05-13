//
//  ViewController.swift
//  ToDoMotilalAssigment
//
//  Created by Rupali Patil on 12/05/21.
//  Copyright © 2021 63moons. All rights reserved.
//

import UIKit
import CoreData

protocol ProtocolDelegate: class {
    func retriveData()
}

class ViewController: UIViewController, ProtocolDelegate {

//MARK: Outlet
    @IBOutlet weak var m_cTomarrowbtn: UIButton!
    @IBOutlet weak var m_cToDoListTbl: UITableView!
    @IBOutlet weak var m_cUpComingbtn: UIButton!
    @IBOutlet weak var m_cTodaybtn: UIButton!
   
    
//MARK: Variable
    var dialogVc : AddUpdateTodoListVC!
    var m_cToDoSectionArr = ["Today","Tomarrow", "upcomping"]
    var m_bIsOnClick: Int!
    var m_bIsShowSaveDialoa: Bool!
    var m_cTodayTask = [Today]()
    var m_cUpComing = [UpComing]()
    var m_cTomarrow = [Tomarrow]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.m_cToDoListTbl.dataSource = self
        self.m_cToDoListTbl.delegate = self
        self.m_bIsOnClick = 1
        self.retrieveCoreData()
    }
    
    func retrieveCoreData() {
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        if m_bIsOnClick == 1
        {
            //Prepare the request of type NSFetchRequest  for the entity
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Today")
            
            
            do {
                self.m_cTodayTask = try managedContext.fetch(fetchRequest) as! [Today]
                self.m_cToDoListTbl.reloadData()
                
            } catch {
                
                print("Failed")
            }
        }else if m_bIsOnClick == 2 {
            //Prepare the request of type NSFetchRequest  for the entity
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Tomarrow")
            
            
            do {
                self.m_cTomarrow = try managedContext.fetch(fetchRequest) as! [Tomarrow]
                self.m_cToDoListTbl.reloadData()
                
            } catch {
                
                print("Failed")
            }
        }else if m_bIsOnClick == 3
        {
            //Prepare the request of type NSFetchRequest  for the entity
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UpComing")
            
            
            do {
                self.m_cUpComing = try managedContext.fetch(fetchRequest) as! [UpComing]
                self.m_cToDoListTbl.reloadData()
                
            } catch {
                
                print("Failed")
            }
        }
    }
        
   
    override func awakeFromNib() {
        
          self.dialogVc = (self.storyboard?.instantiateViewController(withIdentifier: "AddUpdateTodoListVC") as! AddUpdateTodoListVC)
          
      }
    
    @IBAction func onAddbtn_Click(_ sender: Any) {
        
        self.dialogVc.view.frame = self.view.frame
        self.dialogVc.m_bIsOnClick = self.m_bIsOnClick
        self.dialogVc.m_bIsSaveDialoag = true
        self.view.addSubview(self.dialogVc.view)
        self.dialogVc.delegate = self
        
        self.dialogVc.view.clipsToBounds = true
        
    }
    
    @IBAction func onToday_Click(_ sender: Any) {
        self.m_bIsOnClick = 1
        self.m_cTodaybtn.backgroundColor = UIColor.systemBlue
        self.m_cTomarrowbtn.backgroundColor = UIColor.systemPink
        self.m_cUpComingbtn.backgroundColor = UIColor.systemPink
        retrieveCoreData()
    }
    @IBAction func onTomarrow_Click(_ sender: Any) {
        self.m_bIsOnClick = 2
        self.m_cTodaybtn.backgroundColor = UIColor.systemPink
        self.m_cTomarrowbtn.backgroundColor = UIColor.systemBlue
        self.m_cUpComingbtn.backgroundColor = UIColor.systemPink
        retrieveCoreData()
    }
    
    @IBAction func onUpComing_Click(_ sender: Any) {
        self.m_bIsOnClick = 3
        self.m_cTodaybtn.backgroundColor = UIColor.systemPink
        self.m_cTomarrowbtn.backgroundColor = UIColor.systemPink
        self.m_cUpComingbtn.backgroundColor = UIColor.systemBlue
        retrieveCoreData()
        
    }
    
    func retriveData() {
        retrieveCoreData()
    }
    
}
extension ViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           if m_bIsOnClick == 1
           {
             return self.m_cTodayTask.count
           }else if m_bIsOnClick == 2
           {
               return self.m_cTomarrow.count
           }else if m_bIsOnClick == 3
           {
               return self.m_cUpComing.count
           }
          
           return 0
       }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let lcToDoCell = m_cToDoListTbl.dequeueReusableCell(withIdentifier: "ToDoListCell", for: indexPath) as! ToDoListCell
           if m_bIsOnClick == 1
           {
               lcToDoCell.m_cTaskName.text = self.m_cTodayTask[indexPath.row].taskName
               lcToDoCell.m_cTaskDescription.text =  self.m_cTodayTask[indexPath.row].taskDescription
           }else if m_bIsOnClick == 2
           {
               
              lcToDoCell.m_cTaskName.text = self.m_cTomarrow[indexPath.row].taskName
               lcToDoCell.m_cTaskDescription.text =  self.m_cTomarrow[indexPath.row].taskDescription
           }else if m_bIsOnClick == 3
           {
               
              lcToDoCell.m_cTaskName.text = self.m_cUpComing[indexPath.row].taskName
               lcToDoCell.m_cTaskDescription.text =  self.m_cUpComing[indexPath.row].taskDescription
           }
          
           return lcToDoCell
       }
       
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           
           self.dialogVc.view.frame = self.view.frame
           
           if m_bIsOnClick == 1
           {
               self.dialogVc.m_cTodaysTask = self.m_cTodayTask[indexPath.row]
           }else if m_bIsOnClick == 2{
               self.dialogVc.m_cTomarrowTask = self.m_cTomarrow[indexPath.row]
           }else if m_bIsOnClick == 3
           {
               self.dialogVc.m_cUpComingTask = self.m_cUpComing[indexPath.row]
           }
           
           self.dialogVc.m_bIsSaveDialoag = false
           self.dialogVc.delegate = self
           self.dialogVc.m_bIsOnClick = self.m_bIsOnClick
           
           self.view.addSubview(self.dialogVc.view)
           self.dialogVc.view.clipsToBounds = true
       }
}

