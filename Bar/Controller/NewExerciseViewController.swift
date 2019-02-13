//
//  NewExerciseViewController.swift
//  Bar
//
//  Created by Charlie Kang on 6/2/19.
//  Copyright © 2019 Charlie Kang. All rights reserved.
//

import UIKit

class NewExerciseViewController: UIViewController {
    
    // MARK: Properties
    var newExercise: IndividualExercise?
    var savedExercise: ExerciseData?

    // AppDelegate to access persistentContainer and saveContext method
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    

    // MARK: IBActions
    @IBOutlet weak var exerciseNameTextField: UITextField!
    @IBOutlet weak var goalWeightTextField: UITextField!
    @IBOutlet weak var goalSetTextField: UITextField!
    @IBOutlet weak var goalRepsTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exerciseNameTextField.delegate = self
        
        // load the view with the saved exercise data
        if let savedExercise = savedExercise {
            navigationItem.title = savedExercise.exerciseName
            exerciseNameTextField.text = savedExercise.exerciseName
            goalWeightTextField.text = String(savedExercise.goalRecordWeight)
            goalSetTextField.text = String(savedExercise.goalRecordSets)
            goalRepsTextField.text = String(savedExercise.goalRecordReps)
        }
    }
    
    // removes keyboard when the area outside the textField is touched
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "saveNewExercise" {
            // save the properties input from the user
            if let savedExercise = savedExercise {
                // update the exercise
                savedExercise.exerciseName = exerciseNameTextField.text
                savedExercise.goalRecordReps = Int16(goalRepsTextField.text!)!
                savedExercise.goalRecordSets = Int16((goalSetTextField.text)!)!
                savedExercise.goalRecordWeight = Int16(goalWeightTextField.text!)!
                // save attributes
                appDelegate.saveContext()
            } else {
                // add new exercise
                newExercise = IndividualExercise(groupName: nil ,exerciseName: exerciseNameTextField.text, goalRecordWeight: Int((goalWeightTextField.text)!), goalRecordSet: Int((goalSetTextField.text)!), goalRecordReps: Int(goalRepsTextField.text!))
            }

        } 
        
    }

}

extension NewExerciseViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}

//var groupName: String?
//var exerciseName: String?
////    var exerciseImage: String?
//
////    var lastRecordWeight: Int
////    var lastRecordSet: Int
////    var lastRecordReps: Int
//var goalRecordWeight: Int?
//var goalRecordSet: Int?
//var goalRecordReps: Int?
