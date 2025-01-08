//
//  FitnessTabView.swift
//  FitnessApp
//
//  Created by Ricardo Garza on 1/7/25.
//

import SwiftUI

struct FitnessTabView: View {
    @State var selectedTab = "Home"
    
    //We are able to change the tab colors, simply by adding this init
    //
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.stackedLayoutAppearance.selected.iconColor = .purple
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
        UITabBar.appearance().standardAppearance = appearance
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView(viewModel: HomeViewModel())
                .tag("Home")
                .tabItem{
                    Image(systemName: "house")
                    Text("Home")
                }
            
            HistoricDataView()
                .tag("Historic")
                .tabItem{
                    Image(systemName: "chart.line.uptrend.xyaxis")
                    Text("Charts")
                }
            
        }
    }
}

#Preview {
    FitnessTabView()
}
