import SwiftUI

/// Convenience colors used across the design system.
extension Color {
  // MARK: - Text Colors
  public static let textPrimary = Color("TextPrimary", bundle: .module)  // #1A1A1A
  public static let textSecondary = Color("TextSecondary", bundle: .module)  // #4F4F4F
  public static let textDisabled = Color("TextDisabled", bundle: .module)  // #BDBDBD

  // MARK: - Background Colors
  public static let backgroundPrimary = Color("Background", bundle: .module)  // #FFFFFF
  public static let backgroundSecondary = Color("backgroundSecondary", bundle: .module)  // #FFFFFF
  public static let backgroundTertiary = Color("backgroundTertiary", bundle: .module)  // #FFFFFF

  public static let surface = Color("Surface", bundle: .module)  // #F2F2F2
  public static let elevatedSurface = Color("ElevatedSurface", bundle: .module)  // #FFFFFF + shadow

  // MARK: - Border Colors
  public static let border = Color("Border", bundle: .module)  // #E0E0E0
  public static let divider = Color("Divider", bundle: .module)  // #E0E0E0

  // MARK: - Primary Button Colors
  public static let primaryButtonEnabled = Color("PrimaryButtonEnabled", bundle: .module)  // #2F80ED
  public static let primaryButtonPressed = Color("PrimaryButtonPressed", bundle: .module)  // #1366D6
  public static let primaryButtonDisabled = Color("PrimaryButtonDisabled", bundle: .module)  // #BBDEFB
  public static let primaryButtonText = Color("PrimaryButtonText", bundle: .module)  // #FFFFFF

  // MARK: - Secondary Button Colors
  public static let secondaryButtonBorder = Color("SecondaryButtonBorder", bundle: .module)  // #2F80ED
  public static let secondaryButtonText = Color("SecondaryButtonText", bundle: .module)  // #2F80ED
  public static let secondaryButtonPressed = Color("SecondaryButtonPressed", bundle: .module)  // #1366D6
  public static let secondaryButtonDisabled = Color("SecondaryButtonDisabled", bundle: .module)  // #E0E0E0

  // MARK: - Tertiary Button Colors
  public static let tertiaryButtonText = Color("TertiaryButtonText", bundle: .module)  // #2F80ED
  public static let tertiaryButtonPressed = Color("TertiaryButtonPressed", bundle: .module)  // #1366D6
  public static let tertiaryButtonDisabled = Color("TertiaryButtonDisabled", bundle: .module)  // #BDBDBD

  // MARK: - System Feedback
  public static let success = Color("Success", bundle: .module)  // #27AE60
  public static let error = Color("Error", bundle: .module)  // #EB5757
  public static let warning = Color("Warning", bundle: .module)  // #F2994A
  public static let info = Color("Info", bundle: .module)  // #2D9CDB
}
