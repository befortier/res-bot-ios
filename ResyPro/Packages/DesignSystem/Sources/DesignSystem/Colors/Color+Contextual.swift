import SwiftUI

public extension Color {
    // MARK: - Text Colors
    static let textPrimary = Color("TextPrimary", bundle: .module)     // #1A1A1A
    static let textSecondary = Color("TextSecondary", bundle: .module) // #4F4F4F
    static let textDisabled = Color("TextDisabled", bundle: .module)   // #BDBDBD

    // MARK: - Background Colors
    static let backgroundPrimary = Color("Background", bundle: .module)       // #FFFFFF
    static let backgroundSecondary = Color("backgroundSecondary", bundle: .module)       // #FFFFFF
    static let backgroundTertiary = Color("backgroundTertiary", bundle: .module)       // #FFFFFF

    static let surface = Color("Surface", bundle: .module)             // #F2F2F2
    static let elevatedSurface = Color("ElevatedSurface", bundle: .module) // #FFFFFF + shadow

    // MARK: - Border Colors
    static let border = Color("Border", bundle: .module)               // #E0E0E0
    static let divider = Color("Divider", bundle: .module)             // #E0E0E0

    // MARK: - Primary Button Colors
    static let primaryButtonEnabled = Color("PrimaryButtonEnabled", bundle: .module)   // #2F80ED
    static let primaryButtonPressed = Color("PrimaryButtonPressed", bundle: .module)   // #1366D6
    static let primaryButtonDisabled = Color("PrimaryButtonDisabled", bundle: .module) // #BBDEFB
    static let primaryButtonText = Color("PrimaryButtonText", bundle: .module)         // #FFFFFF

    // MARK: - Secondary Button Colors
    static let secondaryButtonBorder = Color("SecondaryButtonBorder", bundle: .module) // #2F80ED
    static let secondaryButtonText = Color("SecondaryButtonText", bundle: .module)     // #2F80ED
    static let secondaryButtonPressed = Color("SecondaryButtonPressed", bundle: .module) // #1366D6
    static let secondaryButtonDisabled = Color("SecondaryButtonDisabled", bundle: .module) // #E0E0E0

    // MARK: - Tertiary Button Colors
    static let tertiaryButtonText = Color("TertiaryButtonText", bundle: .module)       // #2F80ED
    static let tertiaryButtonPressed = Color("TertiaryButtonPressed", bundle: .module) // #1366D6
    static let tertiaryButtonDisabled = Color("TertiaryButtonDisabled", bundle: .module) // #BDBDBD

    // MARK: - System Feedback
    static let success = Color("Success", bundle: .module)     // #27AE60
    static let error = Color("Error", bundle: .module)         // #EB5757
    static let warning = Color("Warning", bundle: .module)     // #F2994A
    static let info = Color("Info", bundle: .module)           // #2D9CDB
}
