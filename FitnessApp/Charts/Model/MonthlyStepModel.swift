//
//  MonthlyStepModel.swift
//  FitnessApp
//
//  Created by Ricardo Garza on 1/16/25.
//

import Foundation

struct MonthlyStepModel: Identifiable {
    let id = UUID()
    let date: Date
    let count: Int
}
