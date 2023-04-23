//
//  WorkoutItem.swift
//  WorkoutRecord
//
//  Created by Kiho Okazawa on 2023-04-22.
//

import Foundation

struct WorkoutItem: Identifiable {
    var id: Int
    var description: String
    var completed: Bool
}

var excistingWorkoutItem = [
    WorkoutItem(id: 1, description: "Deadlift", completed: false)
    ,
    
    WorkoutItem(id: 2, description: "squat", completed: true)
    ,
]
