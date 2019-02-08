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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
         if segue.identifier == "saveNewExercise", let exerciseName = exerciseNameTextField.text {
            // save the properties input from the user
            //newExercise?.exerciseName = exerciseName
            newExercise = IndividualExercise(groupName: nil ,exerciseName: exerciseName)
        }
        
    }




}
