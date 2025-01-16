//
//  FitnessAppApp.swift
//  FitnessApp
//
//  Created by Ricardo Garza on 1/7/25.
//

import SwiftUI

@main
struct FitnessAppApp: App {
    var body: some Scene {
        WindowGroup {
            FitnessTabView()
            //HomeView(viewModel: HomeViewModel())
        }
    }
}
