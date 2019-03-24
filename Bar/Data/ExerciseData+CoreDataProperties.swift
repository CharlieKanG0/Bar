//
//  ExerciseData+CoreDataProperties.swift
//  Bar
//
//  Created by Charlie Kang on 18/2/19.
//  Copyright © 2019 Charlie Kang. All rights reserved.
//
//

import Foundation
import CoreData


extension ExerciseData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExerciseData> {
        return NSFetchRequest<ExerciseData>(entityName: "ExerciseData")
    }

    @NSManaged public var exerciseImage: NSData?
    @NSManaged public var exerciseName: String?
    @NSManaged public var exerciseNote: String?
    @NSManaged public var goalRecordReps: Int16
    @NSManaged public var goalRecordSets: Int16
    @NSManaged public var goalRecordWeight: Int16
    @NSManaged public var groupName: String?
    @NSManaged public var lastRecordReps: Int16
    @NSManaged public var lastRecordSets: Int16
    @NSManaged public var lastRecordWeight: Int16
    @NSManaged public var workouts: NSSet?

}

// MARK: Generated accessors for workouts
extension ExerciseData {

    @objc(addWorkoutsObject:)
    @NSManaged public func addToWorkouts(_ value: WorkoutData)

    @objc(removeWorkoutsObject:)
    @NSManaged public func removeFromWorkouts(_ value: WorkoutData)

    @objc(addWorkouts:)
    @NSManaged public func addToWorkouts(_ values: NSSet)

    @objc(removeWorkouts:)
    @NSManaged public func removeFromWorkouts(_ values: NSSet)

}
