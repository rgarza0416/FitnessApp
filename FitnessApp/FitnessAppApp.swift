//
//  FitnessAppApp.swift
//  FitnessApp
//
//  Created by Ricardo Garza on 1/7/25.
//

import SwiftUI
import RevenueCat

@main
struct FitnessAppApp: App {
    
    init() {
            Purchases.logLevel = .debug
            Purchases.configure(withAPIKey: "appl_PWtJxVqsMgGpVEwBMyftIDunzcy")
    }
    
    var body: some Scene {
        WindowGroup {
            FitnessTabView()
            //    .onAppear {
             //       Purchases.shared.getOfferings { (offerings, error) in
           //                     if let packages = offerings?.current?.availablePackages {
            //                        print(packages.first?.offeringIdentifier)
            //                    }
            //                }
            //    }
        
        
            //HomeView(viewModel: HomeViewModel())
        }
    }
}
