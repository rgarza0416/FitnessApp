//
//  PaywallViewModel.swift
//  FitnessApp
//
//  Created by Ricardo Garza on 1/23/25.
//

import Foundation
import RevenueCat

class PaywallViewModel: ObservableObject {
    
    @Published var currentOffering: Offering?
    
    init() {
        Purchases.shared.getOfferings { (offerings, error) in
            if let offering = offerings?.current {
                
                DispatchQueue.main.async {
                    self.currentOffering = offering
                }
            }
        }
    }
}
