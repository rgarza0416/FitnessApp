//
//  HomeViewModel.swift
//  FitnessApp
//
//  Created by Ricardo Garza on 1/8/25.
//

import Foundation

class HomeViewModel: ObservableObject {
     var calories: Int = 200
     var active: Int = 55
     var stand: Int = 8
    
    
    var mockActivities = [Activity(id: 0, title: "Todays Steps", subtitle: "Goal 12,000", image: "figure.walk", tintColor: .green, amount: "9812"),
                          Activity(id: 1, title: "Todays Steps", subtitle: "Goal 12,000", image: "figure.walk", tintColor: .red, amount: "7881"),
                          Activity(id: 2, title: "Todays Steps", subtitle: "Goal 12,000", image: "figure.walk", tintColor: .blue, amount: "4005"),
                          Activity(id: 3, title: "Todays Steps", subtitle: "Goal 12,000", image: "figure.walk", tintColor: .purple, amount: "10,031")
    ]
    
    var mockWorkouts = [Workout(id: 0, title: "Running", image: "figure.run", tintColor: .cyan, duration: "45 minutes", date: "Jan 2", calories: "450 kcal"),
                        Workout(id: 1, title: "Biking", image: "figure.run", tintColor: .red, duration: "55 minutes", date: "Jan 3", calories: "600 kcal"),
                        Workout(id: 2, title: "Strength Training", image: "figure.run", tintColor: .yellow, duration: "45 minutes", date: "Jan 4", calories: "450 kcal"),
                        Workout(id: 3, title: "Tennis", image: "figure.run", tintColor: .orange, duration: "30 minutes", date: "Jan 5", calories: "300 kcal")]
}
