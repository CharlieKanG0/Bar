//
//  addExerciseToWorkoutTableViewController.swift
//  Bar
//
//  Created by Charlie Kang on 18/2/19.
//  Copyright © 2019 Charlie Kang. All rights reserved.
//

import UIKit

class AddExerciseToWorkoutTableViewController: IndividualExerciseTableViewController {
    
    
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var setsTextField: UITextField!
    @IBOutlet weak var repsTextField: UITextField!
    
    @IBOutlet var popOverView: UIView!
    @IBOutlet weak var exerciseNameLabel: UILabel!
    
    var indexRow: Int!
    
    // AppDelegate to access persistentContainer and saveContext method
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var workout: WorkoutData?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weightTextField.delegate = self
        setsTextField.delegate = self
        repsTextField.delegate = self
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        UIView.transition(with: self.view, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.view.addSubview(self.popOverView)
        }, completion: nil)
        
        let rectOfCell = tableView.rectForRow(at: indexPath)
        let position = CGPoint(x: rectOfCell.midX, y: rectOfCell.midY)

        popOverView.center = position  //self.view.center
        exerciseNameLabel.text = super.filteredExercises[indexPath.row].exerciseName
        
        indexRow = indexPath.row
        
    }

    @IBAction func cancelButton(_ sender: UIButton) {
        self.popOverView.removeFromSuperview()
    }
    
    @IBAction func addExercise(_ sender: UIButton) {
        self.popOverView.removeFromSuperview()
        
        var exercise: ExerciseData = super.filteredExercises[indexRow]
        exercise.lastRecordWeight = Int16(weightTextField.text!)!
        exercise.lastRecordSets = Int16(setsTextField.text!)!
        exercise.lastRecordReps = Int16(repsTextField.text!)!
//        super.filteredExercises[indexRow].lastRecordWeight = Int16(weightTextField.text!)!
//        super.filteredExercises[indexRow].lastRecordSets = Int16(setsTextField.text!)!
//        super.filteredExercises[indexRow].lastRecordReps = Int16(repsTextField.text!)!
        
        
        workout?.addToExercises(exercise)
//        for ex in (workout?.exercises?.allObjects)! {
//            //print(ex.)
//            //print(ex)
//            if let newEx = ex as? ExerciseData {
//                print(newEx)
//            }
//            
//        }
        //workout?.exercises.
        
        //print(workout?.exercises?.allObjects.count) 
        
        
        appDelegate.saveContext()
    }
    
//    // fetch data - refresh the exercises data array to load all the saved exercises
//    func refresh() {
//        let fetchRequest = WorkoutData.fetchRequest() as NSFetchRequest<WorkoutData>
//
//        do {
//            workouts = try managedObjContext.fetch(fetchRequest)
//        } catch let error as NSError {
//            print("Could not fetch. \(error), \(error.userInfo)")
//        }
//    }
    
}

extension AddExerciseToWorkoutTableViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        let currentTag = textField.tag
        
        if let nextResponder = view.viewWithTag(currentTag+1) {
            nextResponder.becomeFirstResponder()
        }
        
    }
}
