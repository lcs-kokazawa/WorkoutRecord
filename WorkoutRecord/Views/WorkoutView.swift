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
    
    //Access the conncetion to the database (needed to add a new recoed
    @Environment(\.blackbirdDatabase) var db:
    Blackbird.Database?
    
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
                        
                        Task {
                            //Write to database
                            try await db!.transaction {core in
                                try core.query("INSERT INTO TodoItem (Description VALUE (?)", newworkDescription)
                            }
                            
                            newworkDescription = ""
                        }
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
                
                List {
                    ForEach(workoutItems.results) { currentItem in
                        Label(title:  {
                            Text(currentItem.description)
                        }, icon: {
                            if currentItem.completed == true {
                                Image(systemName: "checkmark.circle")
                            } else {
                                Image(systemName: "circle")
                            }
                        })
                        .onTapGesture {
                            Task {
                                try await db!.transaction { core in
                                    try core.query("UPDATE TodoItem SET completed = (?) WHERE id = (?)",
                                                   !currentItem.completed,
                                                   currentItem.id)
                                }
                            }
                        }
                    }
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

