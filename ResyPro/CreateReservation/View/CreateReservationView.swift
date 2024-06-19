//
//  CreateReservationView.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation
import SwiftUI

struct CreateReservationView: View {
    @StateObject private var viewModel = CreateReservationViewModel()
    @Environment(\.resyConfig) var resyConfig: ResyConfig
    @State private var showModal = false
    @State private var modalMessage = ""

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("User Credentials")) {
                        TextField("Payment ID", text: $viewModel.paymentID)
                        TextField("Auth Token", text: $viewModel.authToken)

//                        Button(action: viewModel.saveCredentials) {
//                            Text("Save Credentials")
//                        }
                    }
                    Section(header: Text("Reservation Details")) {
                        TextField("Venue ID", text: $viewModel.venueID)
                        TextField("Date", text: $viewModel.date)
                        TextField("Time", text: $viewModel.time)
                        TextField("Party Size", text: $viewModel.partySize)
                        Button(action: {
//                            viewModel.makeReservation { success in
//                                modalMessage = success ? "Reservation Successful!" : "Reservation Failed!"
//                                showModal = true
//                            }
                        }) {
                            Text("Make Reservation")
                        }
                    }
                }
            }
            .navigationTitle("EZ-Resy")
            .sheet(isPresented: $showModal) {
                Text(modalMessage)
                    .font(.largeTitle)
                    .padding()
            }
            .onAppear { viewModel.viewDidAppear(resyConfig: resyConfig) }
        }
    }
}
