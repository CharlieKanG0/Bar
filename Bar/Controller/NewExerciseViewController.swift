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
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var exerciseNameTextField: UITextField!
    @IBOutlet weak var goalWeightTextField: UITextField!
    @IBOutlet weak var goalSetTextField: UITextField!
    @IBOutlet weak var goalRepsTextField: UITextField!
    @IBOutlet weak var noteTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exerciseNameTextField.delegate = self
        goalWeightTextField.delegate = self
        goalSetTextField.delegate = self
        goalRepsTextField.delegate = self
        noteTextField.delegate = self
        
        // load the view with the saved exercise data
        if let savedExercise = savedExercise {
            navigationItem.title = savedExercise.exerciseName
            exerciseNameTextField.text = savedExercise.exerciseName
            goalWeightTextField.text = String(savedExercise.goalRecordWeight)
            goalSetTextField.text = String(savedExercise.goalRecordSets)
            goalRepsTextField.text = String(savedExercise.goalRecordReps)
            if let imageData = savedExercise.exerciseImage {
                photoImageView.image = UIImage(data: imageData as Data)
            }
            noteTextField.text = savedExercise.exerciseNote
        }
        
        //
        updateSaveButtonState()
    }
    
    // removes keyboard when the area outside the textField is touched
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        updateSaveButtonState()
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
                if let imageData = photoImageView.image?.pngData() as NSData? {
                    savedExercise.exerciseImage = imageData
                }
                savedExercise.exerciseNote = noteTextField.text

                // save attributes
                appDelegate.saveContext()
            } else {
                // add new exercise
                newExercise = IndividualExercise(groupName: nil ,exerciseName: exerciseNameTextField.text, goalRecordWeight: Int((goalWeightTextField.text)!), goalRecordSet: Int((goalSetTextField.text)!), goalRecordReps: Int(goalRepsTextField.text!), exerciseImage: photoImageView.image, exerciseNote: noteTextField.text)
            }

        } 
        
    }
    
    // MARK: Private methods
    private func updateSaveButtonState() {
        // if any text fields are empty, disable save button
        if (exerciseNameTextField.text?.isEmpty)! || (goalWeightTextField.text?.isEmpty)! || (goalSetTextField.text?.isEmpty)! || (goalRepsTextField.text?.isEmpty)! {
            saveButton.isEnabled = false
        } else {
            saveButton.isEnabled = true
        }
    }

}

extension NewExerciseViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        navigationItem.title = exerciseNameTextField.text
        return true 
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("did end editing")
        print(textField.tag)
        
        let currentTag = textField.tag
        
        if let nextResponder = view.viewWithTag(currentTag+1) {
            nextResponder.becomeFirstResponder()
        }
        
        updateSaveButtonState()
    }

}

extension NewExerciseViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // get original image from the info dictionary
        guard let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("unable to load image from the dictionary")
        }
        
        // display the image
        photoImageView.image = pickedImage
        
        // save the image 
        
        // dismiss the picker
        dismiss(animated: true, completion: nil) 
    }
    
    // MARK: Actions
    @IBAction func selectImage(_ sender: UITapGestureRecognizer) {
        print("tap")
        // view controller allows user to pick media from their photo library
        let imagePickerController = UIImagePickerController()
        
        // only allow photos
        imagePickerController.sourceType = .photoLibrary
        
        // present image picker view controller
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
        
    }
    
}
