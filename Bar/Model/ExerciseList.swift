//
//  ExerciseList.swift
//  Bar
//
//  Created by Charlie Kang on 4/2/19.
//  Copyright © 2019 Charlie Kang. All rights reserved.
//

import Foundation

final class ExerciseList {
    
    static func generateExercisesData() -> [Exercises] {
        return [
            Exercises(name: "Abdominals", exerciseImage: "Abs"),
            Exercises(name: "Arms", exerciseImage: "Arm"),
            Exercises(name: "Back", exerciseImage: "Back"),
            Exercises(name: "Chest", exerciseImage: "Chest"),
            Exercises(name: "Legs", exerciseImage: "Leg"),
            Exercises(name: "Shoulders", exerciseImage: "Shoulder")
        ]
    }
}
