//
//  MonthlyStepModel.swift
//  FitnessApp
//
//  Created by Ricardo Garza on 1/16/25.
//

import Foundation

struct MonthlyStepModel: Identifiable {
    let id = UUID()
    let month: String
    let count: Int
}
