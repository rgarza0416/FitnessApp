//
//  RevenueCat+Ext.swift
//  FitnessApp
//
//  Created by Ricardo Garza on 1/23/25.
//

import RevenueCat

extension SubscriptionPeriod {
    var durationTitle: String {
        switch self.unit {
        case .day: return "Daily"
        case .week: return "Weekly"
        case .month: return "Monthly"
        case .year: return "Annual"
        @unknown default: return "Unknown"
        }
    }
}
