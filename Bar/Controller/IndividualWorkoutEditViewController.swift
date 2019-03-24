//
//  IndividualWorkoutEditViewController.swift
//  Bar
//
//  Created by Charlie Kang on 18/2/19.
//  Copyright © 2019 Charlie Kang. All rights reserved.
//

import UIKit
import CoreData

class IndividualWorkoutEditViewController: UIViewController {
    
    // MARK: Properties
    var workout: WorkoutData?
    //var newWorkout: WorkoutData?
    var editMode:Bool! 
    
    // AppDelegate to access persistentContainer and saveContext method
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    // manged object context to insert managed objects
    // default managed object context as a property of NSPersistentContainer in the application delegate
    private let managedObjContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    // MARK: IBOutlets
    @IBOutlet weak var workoutNameTextField: UITextField!
    @IBOutlet weak var addExerciseButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: Actions
    @IBAction func cancelToWorkoutView(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        workoutNameTextField.delegate = self
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        if let workout = workout {
            workoutNameTextField.text = workout.workoutName
            navigationItem.title = workoutNameTextField.text
        } else {
            addExerciseButton.isEnabled = false 
        }
        
        if editMode {
            navigationItem.rightBarButtonItem?.title = "Edit"
            navigationItem.leftBarButtonItem?.title = "Back"
            addExerciseButton.setTitle("Start Workout", for: .normal)
        } else {
            navigationItem.rightBarButtonItem?.title = "Save"
            navigationItem.leftBarButtonItem?.title = "Discard"
            addExerciseButton.setTitle("Add Exercises", for: .normal) 
        }
        
        
        
//        if let workout = newWorkout {
//            for ex in (workout.exercises?.allObjects)! {
//                //print(ex.)
//                //print(ex)
//                if let newEx = ex as? ExerciseData {
//                    print(newEx)
//                }
//
//            }
//        }

        // Do any additional setup after loading the view.
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showExercises" {
            if let destination = segue.destination as? ExercisesTableViewController {
                destination.workout = workout
            }
        }
    }
    
    
    // save data
    func addWorkout(name: String) {
        // create a new managed object and insert it into the managed object context
        let newWorkout = WorkoutData(entity: WorkoutData.entity(), insertInto: managedObjContext)
        newWorkout.workoutName = name
        
        workout = newWorkout
        
        // save attributes
        appDelegate.saveContext()
    }
    
//    // fetch
//    // fetch data - refresh the exercises data array to load all the saved exercises
//    func refresh() {
//        let fetchRequest = WorkoutData.fetchRequest() as NSFetchRequest<WorkoutData>
//
//        do {
//            newWorkout = try managedObjContext.fetch(fetchRequest)
//        } catch let error as NSError {
//            print("Could not fetch. \(error), \(error.userInfo)")
//        }
//    }
    

}

extension IndividualWorkoutEditViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (workout?.exercises?.count) ?? 0
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "workoutEditCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)

        // Configure the cell...

        if let individualWorkout = workout?.exercises?.allObjects[indexPath.row] as? ExerciseData {
            cell.textLabel?.text = individualWorkout.exerciseName
            let exerciseTarget = String(individualWorkout.lastRecordWeight) + "kg | " + String(individualWorkout.lastRecordSets) + " x " + String(individualWorkout.lastRecordReps)
            cell.detailTextLabel?.text = exerciseTarget
        }

        return cell
    }
}

extension IndividualWorkoutEditViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if let workout = workout {
            workout.workoutName = workoutNameTextField.text
        } else {
            // create new workout
            addWorkout(name: workoutNameTextField.text!)
            navigationItem.title = workoutNameTextField.text
        }
        
        // enable add exercise button once the workout name is set
        addExerciseButton.isEnabled = true
        return true
    }
}
