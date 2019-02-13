//
//  ExerciseData+CoreDataProperties.swift
//  Bar
//
//  Created by Charlie Kang on 13/2/19.
//  Copyright © 2019 Charlie Kang. All rights reserved.
//
//

import Foundation
import CoreData


extension ExerciseData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExerciseData> {
        return NSFetchRequest<ExerciseData>(entityName: "ExerciseData")
    }

    @NSManaged public var exerciseName: String?
    @NSManaged public var goalRecordReps: Int16
    @NSManaged public var goalRecordSets: Int16
    @NSManaged public var goalRecordWeight: Int16
    @NSManaged public var groupName: String?
    @NSManaged public var lastRecordReps: Int16
    @NSManaged public var lastRecordSets: Int16
    @NSManaged public var lastRecordWeight: Int16
    @NSManaged public var exerciseImage: NSData?

}
