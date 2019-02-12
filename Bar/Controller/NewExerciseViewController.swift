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
    

    // MARK: IBActions
    @IBOutlet weak var exerciseNameTextField: UITextField!
    @IBOutlet weak var goalWeightTextField: UITextField!
    @IBOutlet weak var goalSetTextField: UITextField!
    @IBOutlet weak var goalRepsTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exerciseNameTextField.delegate = self
//        goalWeightTextField.delegate = self
//        goalSetTextField.delegate = self
//        goalRepsTextField.delegate = self

        // Do any additional setup after loading the view.
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
            newExercise = IndividualExercise(groupName: nil ,exerciseName: exerciseNameTextField.text, goalRecordWeight: Int((goalWeightTextField.text)!), goalRecordSet: Int((goalSetTextField.text)!), goalRecordReps: Int(goalRepsTextField.text!))
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
