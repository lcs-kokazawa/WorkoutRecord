//
//  WorkoutView.swift
//  WorkoutRecord
//
//  Created by Kiho Okazawa on 2023-04-22.
//
import Blackbird
import SwiftUI

struct WorkoutView: View {
    //MARK: Stored properties
    
    //The list of items to be completed
    @BlackbirdLiveModels({ db in
        try await WorkoutItem.read(from: db)
    }) var workoutItems
        
    
    //The workout currently being added
    @State var newworkDescription: String = ""
    //MARK: Compited properties
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Enter a workout", text: $newworkDescription)
                    Button(action: {
//                        let lastId = workoutItems.last!.id
//
//                        let newId = lastId + 1
//
//                        let newWorkoutItem = WorkoutItem(id: newId, description: newworkDescription, completed: false)
                    }, label: {
                        Text("Add")
                            .font(.caption)
                    })
                }
                .padding(20)
                
                List(workoutItems.results) { currentItem in
                    Label(title:  {
                        Text(currentItem.description)
                    }, icon: {
                        if currentItem.completed == true {
                            Image(systemName: "checkmark.circle")
                        } else {
                            Image(systemName: "circle")
                        }
                    })
                }
                
            }
            .navigationTitle("Workout List")
        }
    }
}

struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView()
    }
}

