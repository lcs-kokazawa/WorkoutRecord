//
//  WorkoutItem.swift
//  WorkoutRecord
//
//  Created by Kiho Okazawa on 2023-04-22.
//

import Blackbird
import Foundation

struct WorkoutItem: BlackbirdModel {
    @BlackbirdColumn var id: Int
    @BlackbirdColumn var description: String
    @BlackbirdColumn var completed: Bool
}

