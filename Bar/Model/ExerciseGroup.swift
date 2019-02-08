//
//  Exercises.swift
//  Bar
//
//  Created by Charlie Kang on 4/2/19.
//  Copyright © 2019 Charlie Kang. All rights reserved.
//

import Foundation

struct ExerciseGroup {
    // MARK: - Properties
    var exerciseGroupName: String?
    var exerciseImage: String?
//    var exercises: [IndividualExercise]?
    
    // with no nil for exercises - does not work
//    init(exerciseGroupName: String, exerciseImage: String ,exercises: [IndividualExercise]) {
//        self.exerciseGroupName = exerciseGroupName
//        self.exerciseImage = exerciseImage
//        self.exercises = exercises
//    }
    
    // with only declaring exercises - does not work
//    init(exercises: [IndividualExercise]? = nil) {
//        self.exercises = exercises
//    }
//
    
//    init(exerciseGroupName: String, exerciseImage: String ,exercises: [IndividualExercise]? = nil) {
//        self.exerciseGroupName = exerciseGroupName
//        self.exerciseImage = exerciseImage
//        self.exercises = exercises
//    }
    
//    init(exerciseGroupName: String, exerciseImage: String) {
//        self.exerciseGroupName = exerciseGroupName
//        self.exerciseImage = exerciseImage
//        self.exercises = []
//    }
}
