//
//  WorkoutTableViewController.swift
//  Bar
//
//  Created by Charlie Kang on 4/2/19.
//  Copyright © 2019 Charlie Kang. All rights reserved.
//

import UIKit
import CoreData

class WorkoutTableViewController: UITableViewController {
    
    // AppDelegate to access persistentContainer and saveContext method
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    // manged object context to insert managed objects
    // default managed object context as a property of NSPersistentContainer in the application delegate
    private let managedObjContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // array to store all the exercises
    var workouts = [WorkoutData]()
    var edit:Bool!

    override func viewDidLoad() {
        super.viewDidLoad()

        refresh()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return workouts.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "IndividualWorkoutCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)

        // Configure the cell...
        
        let individualWorkout = workouts[indexPath.row]
        cell.textLabel?.text = individualWorkout.workoutName

        return cell
    }
    
    // Tableview swipe delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCell.EditingStyle.delete {
            // get the object to delete
            let workoutToDelete = workouts[indexPath.row]
            // delete from the managed context
            managedObjContext.delete(workoutToDelete)
            // save
            appDelegate.saveContext()
            
            // delete exercise from the array
            workouts.remove(at: indexPath.row)
            // delete table row
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
    }
    
    // fetch data - refresh the workout data array to load all the saved workouts
    func refresh() {
        let fetchRequest = WorkoutData.fetchRequest() as NSFetchRequest<WorkoutData>
        
        do {
            workouts = try managedObjContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if let destination = segue.destination as? UINavigationController {
            if let target = destination.topViewController as? IndividualWorkoutEditViewController{
                if segue.identifier == "showWorkout" {
                    guard let indexPath = tableView.indexPathForSelectedRow else {return}
                    target.workout = workouts[indexPath.row]
                    target.editMode = true
                    edit = true
                    
                } else if segue.identifier == "addWorkout" {
                    target.editMode = false
                    edit = false
                    //print("add workout")
                }
            }
        }
        
        
        
    }

}

extension WorkoutTableViewController {
    
    @IBAction func saveWorkout(_ segue: UIStoryboardSegue) {
        
        if edit {
            tableView.reloadData()
        } else {
            refresh()
            
            // update the table view
            let indexPath = IndexPath(row: workouts.count - 1, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
}
