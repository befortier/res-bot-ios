import SwiftUI

/// A colorful chip with a playful selection animation.
/// Use this when only one chip can be selected at a time.
public struct FunChip: View {
    private let title: Text
    private let isSelected: Bool
    private let onTap: () -> Void

    /// Creates a new chip.
    /// - Parameters:
    ///   - title: Displayed title.
    ///   - isSelected: Whether the chip is currently selected.
    ///   - onTap: Invoked when the chip is tapped.
    public init(
        _ title: Text,
        isSelected: Bool,
        onTap: @escaping () -> Void
    ) {
        self.title = title
        self.isSelected = isSelected
        self.onTap = onTap
    }

    public init(
        _ title: String,
        isSelected: Bool,
        onTap: @escaping () -> Void = {}
    ) {
        self.title = Text(title)
        self.isSelected = isSelected
        self.onTap = onTap
    }

    public var body: some View {
        title
            .font(.design(.subheadline))
            .foregroundStyle(isSelected ? Color.white : Color.accentColor)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(isSelected ? Color.accentColor : Color.accentColor.opacity(0.2))
            )
            .scaleEffect(isSelected ? 1.1 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isSelected)
            .onTapGesture(perform: onTap)
    }
}

#Preview {
    FunChip(Text("Chip"), isSelected: true, onTap: {})
        .padding()
        .previewLayout(.sizeThatFits)
}
