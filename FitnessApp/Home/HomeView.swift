//
//  HomeView.swift
//  FitnessApp
//
//  Created by Ricardo Garza on 1/7/25.
//

import SwiftUI

struct HomeView: View {
    @State var calories: Int = 200
    @State var active: Int = 55
    @State var stand: Int = 8
    
    var mockActivities = [Activity(id: 0, title: "Todays Steps", subtitle: "Goal 12,000", image: "figure.walk", tintColor: .green, amount: "9812"),
                          Activity(id: 1, title: "Todays Steps", subtitle: "Goal 12,000", image: "figure.walk", tintColor: .red, amount: "7881"),
                          Activity(id: 2, title: "Todays Steps", subtitle: "Goal 12,000", image: "figure.walk", tintColor: .blue, amount: "4005"),
                          Activity(id: 3, title: "Todays Steps", subtitle: "Goal 12,000", image: "figure.walk", tintColor: .purple, amount: "10,031")
    ]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                Text("Welcome")
                    .font(.largeTitle)
                    .padding()
                
                HStack {
                    Spacer()
                    
                    VStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Calories")
                                .font(.callout)
                                .bold()
                                .foregroundColor(.red)
                            
                            Text("123 Kcal")
                                .bold()
                        }
                        .padding(.bottom)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Active")
                                .font(.callout)
                                .bold()
                                .foregroundColor(.green)
                            
                            Text("52 mins")
                                .bold()
                        }
                        .padding(.bottom)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Stand")
                                .font(.callout)
                                .bold()
                                .foregroundColor(.blue)
                            
                            Text("8 Hours")
                                .bold()
                        }
                        
                    }
                    
                    Spacer()
                    
                    ZStack {
                        ProgressCircleView(progress: $calories, goal: 600, color: .red)
                        ProgressCircleView(progress: $active, goal: 60, color: .green)
                            .padding(20)
                        ProgressCircleView(progress: $stand, goal: 12, color: .blue)
                            .padding(40)
                    }
                    .padding(.horizontal)
                    Spacer()
                }
                .padding()
                
                
                HStack {
                    Text("Fitness Activity")
                        .font(.title2)
                    
                    Spacer()
                    
                    Button {
                        print("Show more")
                    } label: {
                        Text("Show more") 
                            .padding(10)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(20)
                    }
                }
                .padding(.horizontal)
                
                LazyVGrid(columns: Array(repeating: GridItem(spacing: 20), count: 2)) {
                    ForEach(mockActivities, id: \.id) { activity in
                        ActivityCard(activity: activity)
                    }
                    }
                .padding(.horizontal)
                }
            }
        }
    }


#Preview {
    HomeView()
}
