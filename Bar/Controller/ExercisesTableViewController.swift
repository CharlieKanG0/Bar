//
//  ExercisesTableViewController.swift
//  Bar
//
//  Created by Charlie Kang on 4/2/19.
//  Copyright © 2019 Charlie Kang. All rights reserved.
//

import UIKit

class ExercisesTableViewController: UITableViewController {
    
    // MARK: Properties
    var exerciseGroup = defaultExerciseGroupList.generateExercisesData()
    
    // workout data
    var workout:WorkoutData? 

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return exerciseGroup.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ExerciseCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ExerciseTableViewCell

        // Configure the cell...
        let exercises = self.exerciseGroup[indexPath.row]
        cell.exercises = exercises

        return cell
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let destination = segue.destination as? IndividualExerciseTableViewController,
            let indexPath = tableView.indexPathForSelectedRow {
            destination.selectedExerciseGroupName = exerciseGroup[indexPath.row].exerciseGroupName
            //destination.selectedExerciseGroup = exerciseGroup[indexPath.row] 
        }
        
        if let destination = segue.destination as? AddExerciseToWorkoutTableViewController {
            destination.workout = workout 
        }

    }
    
    
    
    // experiment
//    override func didMove(toParent parent: UIViewController?) {
//        if (parent?.isEqual(IndividualWorkoutEditViewController.self))! {
//            print("back pressed")
//        } else {
//            print("back not pressed")
//        }
//    }
}
