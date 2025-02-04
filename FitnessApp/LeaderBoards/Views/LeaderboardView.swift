//
//  LeaderboardView.swift
//  FitnessApp
//
//  Created by Ricardo Garza on 2/4/25.
//

import SwiftUI

struct LeaderboardUser: Codable, Identifiable {
    let id: Int
    let createdAt: String
    let username: String
    let count: Int
}

class LeaderboardViewModel: ObservableObject {
    
    var mockData = [
        LeaderboardUser(id: 0, createdAt: "", username: "ricardo", count: 1234),
        LeaderboardUser(id: 1, createdAt: "", username: "sindi", count: 2345),
        LeaderboardUser(id: 2, createdAt: "", username: "asia", count: 3456),
        LeaderboardUser(id: 3, createdAt: "", username: "kathy", count: 4567),
        LeaderboardUser(id: 4, createdAt: "", username: "josue", count: 5678),
        LeaderboardUser(id: 5, createdAt: "", username: "becca", count: 6789)
    ]
    
}

struct LeaderboardView: View {
    @StateObject var viewModel = LeaderboardViewModel()
    
    @Binding var showTerms: Bool
    
    var body: some View {
        VStack {
            Text("Leaderboard")
                .font(.largeTitle)
                .bold()
            
            HStack {
                Text("Name")
                    .bold()
                
                Spacer()
                
                Text("Steps")
                    .bold()
            }
            .padding()
            
            LazyVStack(spacing: 24) {
                ForEach(viewModel.mockData) { person in
                    HStack {
                        Text("\(person.id)")
                        
                        Text(person.username)
                        
                        Spacer()
                        
                        Text("\(person.count)")
                    }
                    .padding(.horizontal)
                }
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .fullScreenCover(isPresented: $showTerms) {
            TermsView()
        }
    }
}

#Preview {
    LeaderboardView(showTerms: .constant(false))
}
