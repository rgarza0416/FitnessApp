//
//  TermsView.swift
//  FitnessApp
//
//  Created by Ricardo Garza on 2/4/25.
//

import SwiftUI

struct TermsView: View {
    @Environment(\.dismiss) var dismiss
    @AppStorage("username") var username: String?
    @State var name = ""
    @State var acceptedTerms = false
    
    var body: some View {
        VStack {
            Text("Leaderbord")
                .font(.largeTitle)
                .bold()
            
            Spacer()
            
            TextField("Username", text: $name)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke()
                        
                )
            
            HStack(alignment: .top) {
                Button {
                    withAnimation {
                        acceptedTerms.toggle()
                    }
                } label: {
                    if acceptedTerms {
                        Image(systemName: "square.inset.filled")
                    } else {
                        Image(systemName: "square")
                    }
                }

                
                Text("By checking you agree to the terms and enter the leaderboard competition.")
            }
            
            Spacer()
            
            Button {
                if acceptedTerms && name.count > 2 {
                    username = name
                    dismiss()
                }
            } label: {
                Text("Continue")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                    )
            }

        }
        .padding(.horizontal)
    }
}

#Preview {
    TermsView()
}
