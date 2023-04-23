//
//  WorkoutRecordApp.swift
//  WorkoutRecord
//
//  Created by Kiho Okazawa on 2023-04-22.
//
import Blackbird
import SwiftUI

@main
struct WorkoutRecordApp: App {
    var body: some Scene {
        WindowGroup {
            WorkoutView()
                // Make the database available to all other views through the environment
                .environment(\.blackbirdDatabase, AppDatabase.instance)
            
        }
    }
}
