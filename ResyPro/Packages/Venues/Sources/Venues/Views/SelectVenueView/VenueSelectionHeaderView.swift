//
//  VenueSelectionHeaderView.swift
//  Venues
//
//  Created by Ben Fortier on 5/13/25.
//

import SwiftUI
import DesignSystem

/// Header view for venue selection with title, search bar, filters button, and select/unselect all.
public struct VenueSelectionHeaderView: View {
    let title: String
    @Binding var searchText: String
    @Binding var isShowingFilters: Bool
    let selectedCount: Int
    let totalCount: Int
    let onToggleSelectAll: () -> Void

    public init(
        title: String = "Select Venues",
        searchText: Binding<String>,
        isShowingFilters: Binding<Bool>,
        selectedCount: Int,
        totalCount: Int,
        onToggleSelectAll: @escaping () -> Void
    ) {
        self.title = title
        self._searchText = searchText
        self._isShowingFilters = isShowingFilters
        self.selectedCount = selectedCount
        self.totalCount = totalCount
        self.onToggleSelectAll = onToggleSelectAll
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(title)
                    .font(.design(.title2)).bold()
                Spacer()
                Button {
                    isShowingFilters = true
                } label: {
                    Label("Filters", systemImage: "slider.horizontal.3")
                }
            }

            HStack(spacing: 4) {
                SearchBarView(text: $searchText)

                Button(action: onToggleSelectAll) {
                    Text(selectAllButtonLabel)
                }
                .buttonStyle(SecondaryButtonStyle())

            }
        }
    }

    private var selectAllButtonLabel: String {
        selectedCount < totalCount ? "Select All" : "Unselect All"
    }
}
