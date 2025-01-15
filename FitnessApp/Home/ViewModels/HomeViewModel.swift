//
//  HomeViewModel.swift
//  FitnessApp
//
//  Created by Ricardo Garza on 1/8/25.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    let healthManager = HealthManager.shared
    
     @Published var calories: Int = 0
     @Published var exercise: Int = 0
     @Published var stand: Int = 0
    
    @Published var activities = [Activity]()
    @Published var workouts = [Workout(id: 0, title: "Running", image: "figure.run", tintColor: .cyan, duration: "45 minutes", date: "Jan 2", calories: "450 kcal"),
                               Workout(id: 1, title: "Biking", image: "figure.run", tintColor: .red, duration: "55 minutes", date: "Jan 3", calories: "600 kcal"),
                               Workout(id: 2, title: "Strength Training", image: "figure.run", tintColor: .yellow, duration: "45 minutes", date: "Jan 4", calories: "450 kcal"),
                               Workout(id: 3, title: "Tennis", image: "figure.run", tintColor: .orange, duration: "30 minutes", date: "Jan 5", calories: "300 kcal")]
    
    
    var mockActivities = [Activity(title: "Todays Steps", subtitle: "Goal 12,000", image: "figure.walk", tintColor: .green, amount: "9812"),
                          Activity(title: "Todays Steps", subtitle: "Goal 12,000", image: "figure.walk", tintColor: .red, amount: "7881"),
                          Activity(title: "Todays Steps", subtitle: "Goal 12,000", image: "figure.walk", tintColor: .blue, amount: "4005"),
                          Activity(title: "Todays Steps", subtitle: "Goal 12,000", image: "figure.walk", tintColor: .purple, amount: "10,031")
    ]
    
    var mockWorkouts = [Workout(id: 0, title: "Running", image: "figure.run", tintColor: .cyan, duration: "45 minutes", date: "Jan 2", calories: "450 kcal"),
                        Workout(id: 1, title: "Biking", image: "figure.run", tintColor: .red, duration: "55 minutes", date: "Jan 3", calories: "600 kcal"),
                        Workout(id: 2, title: "Strength Training", image: "figure.run", tintColor: .yellow, duration: "45 minutes", date: "Jan 4", calories: "450 kcal"),
                        Workout(id: 3, title: "Tennis", image: "figure.run", tintColor: .orange, duration: "30 minutes", date: "Jan 5", calories: "300 kcal")]
    
    
    init() {
        Task {
            do {
                try await healthManager.requestHealthKitAccess()
                fetchTodayCalories()
                fetchTodayExerciseTime()
                fetchTodayStandHours()
                fetchTodaysSteps()
                fetchCurrentWeekActivities()
                fetchRecentWorkouts()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchTodayCalories() {
        healthManager.fetchTodayCaloriesBurned { result in
            switch result {
                case .success(let calories):
                DispatchQueue.main.async {
                    self.calories = Int(calories)
                    let activity = Activity(title: "Calories Burned", subtitle: "Today", image: "flame", tintColor: .red, amount: calories.formattedNumberString())
                    self.activities.append(activity)
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func fetchTodayExerciseTime() {
        healthManager.fetchTodayExerciseTime { result in
            switch result {
            case .success(let exercise):
                DispatchQueue.main.async {
                    self.exercise = Int(exercise)
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func fetchTodayStandHours() {
        healthManager.fetchTodayStandHours { result in
            switch result {
            case .success(let hours):
                DispatchQueue.main.async {
                    self.stand = hours
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    // MARK: Fitness Activity
    func fetchTodaysSteps() {
        healthManager.fetchTodayStep { result in
            switch result {
            case .success(let activity):
                DispatchQueue.main.async {
                    self.activities.append(activity)
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func fetchCurrentWeekActivities() {
        healthManager.fetchCurrentWeekWorkoutStats { result in
            switch result {
            case .success(let activities):
                DispatchQueue.main.async {
                    self.activities.append(contentsOf: activities)
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    // MARK: Recent Workouts
    func fetchRecentWorkouts() {
        healthManager.fetchWorkoutsForMonth(month: Date()) { result in
            switch result {
            case .success(let workouts):
                DispatchQueue.main.async {
                    self.workouts = Array(workouts.prefix(4))
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
        
        
    }
}
