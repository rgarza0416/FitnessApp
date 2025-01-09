//
//  HealthManager.swift
//  FitnessApp
//
//  Created by Ricardo Garza on 1/9/25.
//

import Foundation
import HealthKit

extension Date {
    
    static var startOfToday: Date {
        let calendar = Calendar.current
        return calendar.startOfDay(for: Date())
    }
}

//Singleton, only initialized once in your project

class HealthManager {
    
    static let shared = HealthManager()
    
    let healthStore = HKHealthStore()
    
    private init(){
        Task {
            do {
                try await requestHealthKitAccess()
            } catch {
                print(error.localizedDescription)
            }
            
        }
    }
    
    func requestHealthKitAccess() async throws {
        let calories = HKQuantityType(.activeEnergyBurned)
        let exercise = HKQuantityType(.appleExerciseTime)
        let stand = HKCategoryType(.appleStandHour)
        
        let healthTypes: Set = [calories, exercise, stand]
        try await healthStore.requestAuthorization(toShare: [], read: healthTypes)
    }
    
    
    func fetchTodayCaloriesBurned(completion: @escaping (Result<Double, Error>) -> Void){
        let calories = HKQuantityType(.activeEnergyBurned)
        let predicate = HKQuery.predicateForSamples(withStart: .startOfToday, end: Date())
        let query = HKStatisticsQuery(quantityType: calories, quantitySamplePredicate: predicate) { _, result, error in
            guard let quantity = result?.sumQuantity(), error == nil else {
                completion(.failure(NSError()))
                return
            }
            
            
            let caloriesCount = quantity.doubleValue(for: .kilocalorie())
            completion(.success(caloriesCount))
        }
        healthStore.execute(query)
    }
    
    func fetchTodayExerciseTime(completion: @escaping (Result<Double, Error>) -> Void){
        let exercise = HKQuantityType(.appleExerciseTime)
        let predicate = HKQuery.predicateForSamples(withStart: .startOfToday, end: Date())
        let query = HKStatisticsQuery(quantityType: exercise, quantitySamplePredicate: predicate) { _, result, error in
            guard let quantity = result?.sumQuantity(), error == nil else {
                completion(.failure(NSError()))
                return
            }
            
            
            let exerciseTime = quantity.doubleValue(for: .minute())
            completion(.success(exerciseTime))
        }
        healthStore.execute(query)
    }
    
    func fetchTodayStandHours(completion: @escaping (Result<Int, Error>) -> Void){
        let stand = HKCategoryType(.appleStandHour)
        let predicate = HKQuery.predicateForSamples(withStart: .startOfToday, end: Date())
        let query = HKSampleQuery(sampleType: stand, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { _, result, error in
            guard let samples = result as? [HKCategorySample], error == nil else {
                completion(.failure(NSError()))
                return
            }
            let standCount = samples.filter({$0.value == 0}).count
            completion(.success(standCount))
        }
        healthStore.execute(query)
    }
}
