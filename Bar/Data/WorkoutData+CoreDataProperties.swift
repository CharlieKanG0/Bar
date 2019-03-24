//
//  WorkoutData+CoreDataProperties.swift
//  Bar
//
//  Created by Charlie Kang on 18/2/19.
//  Copyright © 2019 Charlie Kang. All rights reserved.
//
//

import Foundation
import CoreData


extension WorkoutData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WorkoutData> {
        return NSFetchRequest<WorkoutData>(entityName: "WorkoutData")
    }

    @NSManaged public var workoutName: String?
    @NSManaged public var exercises: NSSet?

}

// MARK: Generated accessors for exercises
extension WorkoutData {

    @objc(addExercisesObject:)
    @NSManaged public func addToExercises(_ value: ExerciseData)

    @objc(removeExercisesObject:)
    @NSManaged public func removeFromExercises(_ value: ExerciseData)

    @objc(addExercises:)
    @NSManaged public func addToExercises(_ values: NSSet)

    @objc(removeExercises:)
    @NSManaged public func removeFromExercises(_ values: NSSet)

}
