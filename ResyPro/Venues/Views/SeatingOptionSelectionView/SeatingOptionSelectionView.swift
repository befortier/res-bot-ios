//
//  SeatingOptionSelectionView.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/27/24.
//

import Foundation
import SwiftUI

struct SeatingOptionSelectionView: View {
    @State private var selectedOption: SeatingOptionViewType = .all
    @Binding var selectedOptions: [String]
    let knownOptions: [String]

    var body: some View {
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
