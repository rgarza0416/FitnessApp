//
//  FitnessTabView.swift
//  FitnessApp
//
//  Created by Ricardo Garza on 1/7/25.
//

import SwiftUI
import RevenueCat

struct FitnessTabView: View {
    @State var selectedTab = "Home"
    @State var isPremium = false
    
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
            HomeView(isPremium: $isPremium)
                .tag("Home")
                .tabItem{
                    Image(systemName: "house")
                    Text("Home")
                }
            
            ChartsView()
                .tag("Historic")
                .tabItem{
                    Image(systemName: "chart.line.uptrend.xyaxis")
                    Text("Charts")
                }
        }
        .onAppear {
            Purchases.shared.getCustomerInfo { customerInfo, error in
                isPremium = customerInfo?.entitlements["premium"]?.isActive == true
            }
        }
    }
}

#Preview {
    FitnessTabView()
}
