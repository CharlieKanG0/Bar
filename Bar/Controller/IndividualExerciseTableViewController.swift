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
    
    // AppDelegate to access persistentContainer and saveContext method
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    // manged object context to insert managed objects
    // default managed object context as a property of NSPersistentContainer in the application delegate
    private let managedObjContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // value passed from ExerciseTableViewController 
    var selectedExerciseGroupName: String?
    var exercises = [ExerciseData]()
    var filteredExercises = [ExerciseData]()
    var selected:IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set the title of the current individual exercise view
        title = selectedExerciseGroupName
        
        // fetch the exercise lists from core data
        refresh()
        
        // filter out the exercises that belongs to the current exercise group
        filter(group: selectedExerciseGroupName!)

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filteredExercises.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "IndividualExerciseCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)

        // Configure the cell...
        let individualExercises = filteredExercises[indexPath.row]
        
        cell.textLabel?.text = individualExercises.value(forKey: "exerciseName") as? String

        return cell
        
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    // passing the group of the new exercise that will be added
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.

        if segue.identifier == "showNewExercise" {
            // present exercise from saved data
            print("segue identifier matched: showNewExercise")
            
//            guard let selectedExerciseCell = sender as? UITableViewCell else {
//                return
//            }
//
//            guard let indexPath = tableView.indexPath(for: selectedExerciseCell) else {
//                return
//            }
            
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            
            if let destination = segue.destination as? NewExerciseViewController {
                print("segue destination matched")
                destination.savedExercise = filteredExercises[indexPath.row]
            }
        }
        
    }

}

extension IndividualExerciseTableViewController {
    @IBAction func cancelToIndividualExerciseViewController(_ segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func saveNewExercise(_ segue: UIStoryboardSegue) {
        guard let newExerciseViewController = segue.source as? NewExerciseViewController,
            var newExercise = newExerciseViewController.newExercise
            else {
                // exercise data is edited - reload the table
                tableView.reloadData()
                return
        }
        
        // set the group name of the exercise
        newExercise.groupName = selectedExerciseGroupName
        addExercise(exercise: newExercise)
        
       // update the current group exercise list
        filter(group: selectedExerciseGroupName!)
        
        // update the table view
        let indexPath = IndexPath(row: filteredExercises.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)

    }
    
    // save data
    func addExercise(exercise: IndividualExercise) {
        // create a new managed object and insert it into the managed object context
        let exerciseData = ExerciseData(entity: ExerciseData.entity(), insertInto: managedObjContext)
        
        exerciseData.groupName = exercise.groupName
        exerciseData.exerciseName = exercise.exerciseName
        exerciseData.goalRecordReps = Int16(exercise.goalRecordReps!)
        exerciseData.goalRecordSets = Int16(exercise.goalRecordSet!)
        exerciseData.goalRecordWeight = Int16(exercise.goalRecordWeight!)
        
        // save attributes
        appDelegate.saveContext()
        
        // add new exercise to the array
        exercises.append(exerciseData)
        
    }
    
    // fetch data - refresh the individual exercise table view
    func refresh() {
        let fetchRequest = ExerciseData.fetchRequest() as NSFetchRequest<ExerciseData>
        
        do {
            exercises = try managedObjContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    // filter exercises
    func filter(group: String) {
        filteredExercises = exercises.filter { (ex) -> Bool in
            return (ex.groupName?.contains(group))!
        }
    }
    
    // update check - check if this exercise already exists
    func updateExercise() {
        
    }
    
    // delete
    func deleteExercise (exercise: ExerciseData) {
        managedObjContext.delete(exercise)
    }
}
