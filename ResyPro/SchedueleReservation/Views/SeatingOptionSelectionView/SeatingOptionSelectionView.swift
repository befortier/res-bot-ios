//
//  SeatingOptionSelectionView.swift
//  Venues
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation
import SwiftUI

/// A struct defined in the Venues module.
public struct SeatingOptionSelectionView: View {
    @State private var selectedOption: SeatingOptionViewType
    @Binding private var selectedOptions: [String]
    private let knownOptions: [String]

    public init(
        selectedOption: SeatingOptionViewType = .all,
        selectedOptions: Binding<[String]>,
        knownOptions: [String]
    ) {
        self._selectedOption = State(wrappedValue: selectedOption)
        self._selectedOptions = selectedOptions
        self.knownOptions = knownOptions
    }

    public var body: some View {
        VStack {
            SeatingOptionView(
                option: SeatingOptionViewType.allOption,
                isFilled: selectedOption.isFilled(id: SeatingOptionViewType.allOption)
            )
            .onTapGesture {
                self.selectedOption = .all
            }
            Divider()

            ScrollView(.horizontal) {
                HStack {
                    ForEach(Array(knownOptions), id: \.self) { knownOption in
                        SeatingOptionView(
                            option: knownOption,
                            isFilled: selectedOption.isFilled(id: knownOption)
                        )
                        .onTapGesture {
                            self.selectedOption.itemSelected(id: knownOption)
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
        .onChange(of: selectedOption) { _, newValue in
            self.selectedOptions = newValue.optionsSet
        }
    }
}

#Preview {
    SeatingOptionSelectionView(
        selectedOptions: .constant([]),
        knownOptions: ["Bar", "Outdoor", "Indoor", "Kitchen Counter", "Dining Room"]
    )
}
