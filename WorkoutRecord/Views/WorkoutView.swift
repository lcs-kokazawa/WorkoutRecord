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
                            try await db!.transaction { core in
                                try core.query("INSERT INTO WorkoutItem (description) VALUES (?)", newworkDescription)
                                
                            
                            }
                            
                            newworkDescription = ""
                        }
                        //                        let lastId = workoutItems.last!.id
                        //
                        //                        let newId = lastId + 1
                        //
                        //                        let newWorkoutItem = WorkoutItem(id: newId, description: newworkDescription, completed: false)
                    }, label: {
                        Text("ADD")
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
                                    try core.query("UPDATE WorkoutItem SET completed = (?) WHERE id = (?)",
                                                   !currentItem.completed,
                                                   currentItem.id)
                                }
                            }
                        }
                    }
                    .onDelete(perform: removeRows)
                }
                
            }
            .navigationTitle("Workout List")
        }
    }
    
    //MARK: Functions
    func removeRows(at offsets: IndexSet) {
        
        //What item(s) were swiped?
        for offset in offsets {
            print(offset)
        }
    }
}

struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView()
            .environment(\.blackbirdDatabase, AppDatabase.instance)
    }
}

