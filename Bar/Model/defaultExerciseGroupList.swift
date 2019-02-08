//
//  ExerciseList.swift
//  Bar
//
//  Created by Charlie Kang on 4/2/19.
//  Copyright © 2019 Charlie Kang. All rights reserved.
//

import Foundation

final class defaultExerciseGroupList {
    
    static func generateExercisesData() -> [ExerciseGroup] {
        return [
            ExerciseGroup(exerciseGroupName: "Abdominals", exerciseImage: "Abs"),
            ExerciseGroup(exerciseGroupName: "Arms", exerciseImage: "Arm"),
            ExerciseGroup(exerciseGroupName: "Back", exerciseImage: "Back"),
            ExerciseGroup(exerciseGroupName: "Chest", exerciseImage: "Chest"),
            ExerciseGroup(exerciseGroupName: "Legs", exerciseImage: "Leg"),
            ExerciseGroup(exerciseGroupName: "Shoulders", exerciseImage: "Shoulder")
        ]
    }
}
