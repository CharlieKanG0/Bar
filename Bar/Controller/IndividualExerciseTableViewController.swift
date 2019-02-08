//
//  IndividualExerciseTableViewController.swift
//  Bar
//
//  Created by Charlie Kang on 5/2/19.
//  Copyright © 2019 Charlie Kang. All rights reserved.
//

import UIKit
import CoreData

class IndividualExerciseTableViewController: UITableViewController {
    
    // MARK: Properties
    var selectedExerciseGroup: ExerciseGroup!
//    var individualExercises = sampleLegExercises.generateLegExercisesData()
//    var exercises: [IndividualExercise] = []
    var exercises: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = selectedExerciseGroup.exerciseGroupName
        
        fetchData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return exercises.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "IndividualExerciseCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)

        // Configure the cell...
        let individualExercises = exercises[indexPath.row]
        
        if individualExercises.value(forKey: "groupName") as? String == selectedExerciseGroup.exerciseGroupName {
            cell.textLabel?.text = individualExercises.value(forKey: "exerciseName") as? String
        }
//        cell.textLabel?.text = individualExercise.exerciseName
        // grab the attribute from the NSObject
//        cell.textLabel?.text = individualExercises.value(forKey: "exerciseName") as? String
        return cell
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // passing the group of the new exercise that will be added
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let destination = segue.destination as? NewExerciseViewController {
            destination.newExercise?.groupName = selectedExerciseGroup.exerciseGroupName
        }
        
    }

}

extension IndividualExerciseTableViewController {
    @IBAction func cancelToIndividualExerciseViewController(_ segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func saveNewExercise(_ segue: UIStoryboardSegue) {
        guard let newExerciseViewController = segue.source as? NewExerciseViewController,
            var newExercise = newExerciseViewController.newExercise else { return }
        
        // add the new exercise to the array
//        exercises.append(newExercise)
        newExercise.groupName = selectedExerciseGroup.exerciseGroupName
        saveData(individualExercise: newExercise)
        
        // update the table view
        let indexPath = IndexPath(row: exercises.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    // add data
    func saveData(individualExercise: IndividualExercise) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        // insert a new managed object into a manged object context
        // - default managed object context as a property of NSPersistentContainer in the application delegate 
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // create a new managed object and insert it into the managed object context.
        let entity = NSEntityDescription.entity(forEntityName: "ExerciseData", in: managedContext)!
        
        //
        let newExercise = NSManagedObject(entity: entity, insertInto: managedContext)
        
        // set the attribute using the key-value coding
        newExercise.setValue(individualExercise.groupName, forKey: "groupName")
        newExercise.setValue(individualExercise.exerciseName, forKey: "exerciseName")
        
        // Commit changes to newExercise and save to disk by calling save on the managed object context.
        do {
            try managedContext.save()
            exercises.append(newExercise)
        } catch let error as NSError {
            print("Could not save! NSError: \(error)")
        }
    }
    
    // fetch data
    func fetchData() {
        //1
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // responsible for fetcing from core data
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "ExerciseData")
        
        // hand the fetch request over to the managed object
        do {
            exercises = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
}
