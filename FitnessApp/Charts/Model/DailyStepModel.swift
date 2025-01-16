//
//  DailyStepModel.swift
//  FitnessApp
//
//  Created by Ricardo Garza on 1/16/25.
//

import Foundation

struct DailyStepModel: Identifiable {
    let id = UUID()
    let date: Date
    let count: Int
}
