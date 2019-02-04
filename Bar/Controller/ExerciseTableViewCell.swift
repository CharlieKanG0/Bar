//
//  ExerciseTableViewCell.swift
//  Bar
//
//  Created by Charlie Kang on 4/2/19.
//  Copyright © 2019 Charlie Kang. All rights reserved.
//

import UIKit

class ExerciseTableViewCell: UITableViewCell {
    
    // MARK: IBOutlets
    @IBOutlet weak var exerciseImageView: UIImageView!
    @IBOutlet weak var exerciseLabel: UILabel!
    
    // MARK: Properties
    var exercises: Exercises? {
        didSet{
            guard let exercises = exercises else {return}
            
            exerciseLabel.text = exercises.name
            exerciseImageView.image = UIImage(named: exercises.exerciseImage!)
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
