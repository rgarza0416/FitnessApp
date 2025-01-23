//
//  PaywallView.swift
//  FitnessApp
//
//  Created by Ricardo Garza on 1/21/25.
//

import SwiftUI
import RevenueCat

struct PaywallView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewmodel = PaywallViewModel()
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Premium Membership")
                .font(.largeTitle)
                .bold()
            
            Text("Get fit, get active, today!")
            
            Spacer()
            
            //Features
            VStack(spacing: 20) {
                HStack {
                    Image(systemName: "figure.run")
                    
                    Text("Exercise boosts energy levels and promotes vitality.")
                        .lineLimit(1)
                        .font(.system(size: 14))
                        
                }
                
                HStack {
                    Image(systemName: "figure.run")
                    
                    Text("Exercise boosts energy levels and promotes vitality.")
                        .lineLimit(1)
                        .font(.system(size: 14))
                        
                }
                
                HStack {
                    Image(systemName: "figure.run")
                    
                    Text("Exercise boosts energy levels and promotes vitality.")
                        .lineLimit(1)
                        .font(.system(size: 14))
                        
                }
            }
            
            Spacer()
            
            HStack {
                if let offering = viewmodel.currentOffering {
                    ForEach(offering.availablePackages) { package in
                        Button {
                            Purchases.shared.purchase(package: package) { transaction, customerInfo, error, userCancelled in
                                if customerInfo?.entitlements["premium"]?.isActive == true {
                                    dismiss()
                                }
                            }
                        } label: {
                            VStack(spacing: 8) {
                                Text(package.storeProduct.subscriptionPeriod?.durationTitle ?? "Subscription")
                                Text(package.storeProduct.localizedPriceString)
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .padding()
                        .frame(height: 100)
                        .background(RoundedRectangle(cornerRadius: 15)
                            .stroke(lineWidth: 2)
                                    .foregroundColor(.green))

                    }
                }
            }
            .padding(.horizontal, 40)
            
            Button {
                Purchases.shared.restorePurchases { customerInfo, error in
                    if customerInfo?.entitlements["premium"]?.isActive == true {
                        dismiss()
                    }
                }
            } label: {
                Text("Restore purchases")
                    .foregroundColor(.green)
                    .underline()
            }

            
            Spacer()
            
            HStack(spacing: 16) {
                Link("Terms of Use (ELUA)", destination: URL(string: "https://github.com/rgarza0416")!)
                
                Link("Privacy Policy", destination: URL(string: "https://github.com/rgarza0416")!)
            }
            
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    PaywallView()
}
