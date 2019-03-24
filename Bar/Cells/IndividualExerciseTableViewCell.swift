//
//  IndividualExerciseTableViewCell.swift
//  Bar
//
//  Created by Charlie Kang on 15/2/19.
//  Copyright © 2019 Charlie Kang. All rights reserved.
//

import UIKit

class IndividualExerciseTableViewCell: UITableViewCell {
    
    @IBOutlet weak var exerciseNameLabel: UILabel!
    @IBOutlet weak var exerciseImageView: UIImageView!
    @IBOutlet weak var lastRecordLabel: UILabel!
    @IBOutlet weak var goalRecordLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    
    func setIndividualExerciseCell(exerciseData: ExerciseData) {
        exerciseNameLabel.text = exerciseData.exerciseName
        if let image = exerciseData.exerciseImage {
            exerciseImageView.image = UIImage(data: image as Data)
        }
        goalRecordLabel.text = String(exerciseData.goalRecordWeight) + "kg | " + String(exerciseData.goalRecordSets) + " X " + String(exerciseData.goalRecordReps)
        
        lastRecordLabel.text = String(exerciseData.lastRecordWeight) + "kg | " + String(exerciseData.lastRecordSets) + " X " + String(exerciseData.lastRecordReps)
        //noteLabel.text = exerciseData.exerciseNote

    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
//    }
}
