//
//  VenueSelectionView.swift
//  Venues
//
//  Created by Ben Fortier on 5/11/25.
//

import SwiftUI
import DesignSystem

/// A view for selecting venues with optional filters for cuisine and price.
public struct VenueSelectionView: View {
    let allVenues: [Venue]
    @Binding var selectedVenueIDs: Set<Int>
    @State private var selectedCuisines: Set<String>
    @State private var maxPrice: Int = 4
    @State private var showingFilters = false

    private let onSubmit: () -> Void

    public init(
        allVenues: [Venue],
        selectedVenueIDs: Binding<Set<Int>>,
        onSubmit: @escaping () -> Void
    ) {
        self.allVenues = allVenues
        self._selectedVenueIDs = selectedVenueIDs
        self._selectedCuisines = State(wrappedValue: Set(allVenues.map(\.cuisineType)))
        self.onSubmit = onSubmit
    }

    public var body: some View {
        VStack(spacing: 12) {
            ScrollView {
                HStack {
                    Text("Select Venues")
                        .font(.title2)
                        .bold()
                    Spacer()
                    Button("Filters") {
                        showingFilters = true
                    }
                }
                .padding(.horizontal)

                VerticalVenueCardGridView(venues: filteredVenues) { viewState in
                    Button {
                        toggleSelection(viewState.id)
                    } label: {
                        SelectableVenueCard(
                            venueCardViewState: viewState,
                            isSelected: selectedVenueIDs.contains(viewState.id)
                        )
                    }
                }
                .padding(16)
            }

            Button("Create Notifications") {
                onSubmit()
            }
            .buttonStyle(PrimaryButtonStyle())
        }
        .sheet(isPresented: $showingFilters) {
            VenueFilterSheet(
                allCuisines: allCuisines,
                selectedCuisines: $selectedCuisines,
                maxPrice: $maxPrice
            )
            .presentationDetents([.medium])
        }
    }

    private var filteredVenues: [Venue] {
        allVenues.filter {
            $0.priceRange <= maxPrice &&
            (selectedCuisines.isEmpty || selectedCuisines.contains($0.cuisineType))
        }
    }

    private var allCuisines: Set<String> {
        Set(allVenues.map(\.cuisineType))
    }

    private func toggleSelection(_ id: Int) {
        if selectedVenueIDs.contains(id) {
            selectedVenueIDs.remove(id)
        } else {
            selectedVenueIDs.insert(id)
        }
    }
}
