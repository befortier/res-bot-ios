//
//  IconTextField.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/27/24.
//

import Foundation
import SwiftUI

struct IconTextField: View {
    var icon: String?
    var placeholder: String
    @Binding var text: String

    var body: some View {
        HStack {
            if let icon = icon {
                Image(systemName: icon)
                    .foregroundColor(.gray)
            }
            TextField(placeholder, text: $text)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(8)
        }
        .padding(.horizontal, 10)
    }
}
