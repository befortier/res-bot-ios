//
//  VenueFilterSheet.swift
//  Notifications
//
//  Created by Ben Fortier on 5/11/25.
//

import SwiftUI
import Foundation
import DesignSystem

public struct VenueFilterSheet: View {
    let prices = [1, 2, 3, 4]
    let allCuisines: Set<String>
    @Binding var selectedCuisines: Set<String>
    @Binding var maxPrice: Int

    public var body: some View {
        NavigationView {
            Form {
                priceFilter
                cuisineFilters
            }
            .navigationTitle("Filters")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private var cuisineFilters: some View {
        Section(header: Text("Cuisine")) {
            FlowLayout(spacing: 8) {
                ForEach(allCuisines.sorted(), id: \.self) { cuisine in
                    FilterChip(
                        title: cuisine,
                        isSelected: selectedCuisines.contains(cuisine)
                    ) {
                        if selectedCuisines.contains(cuisine) {
                            selectedCuisines.remove(cuisine)
                        } else {
                            selectedCuisines.insert(cuisine)
                        }
                    }
                }
            }
            .padding(.vertical, 4)
        }
    }

    private var priceFilter: some View {
        Section(header: Text("Max Price")) {
            HStack(spacing: 8) {
                ForEach(prices, id: \.self) { price in
                    priceFilterView(price)
                        .onTapGesture {
                            maxPrice = price

                        }
                }
            }
        }
    }

    private func priceFilterView(_ price: Int) -> some View {
        Text(price: price)
            .padding(.vertical, 6)
            .padding(.horizontal, 10)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(maxPrice == price ? Color.accentColor : Color.gray.opacity(0.2))
            )
            .foregroundColor(maxPrice == price ? .white : .primary)
    }
}

// MARK: Previews

#Preview {
    VenueFilterSheetPreview()
}

fileprivate struct VenueFilterSheetPreview: View {
    @State var maxPrice = 1

    var body: some View {
        VenueFilterSheet(allCuisines: [], selectedCuisines: .constant([]), maxPrice: $maxPrice)
    }
}
