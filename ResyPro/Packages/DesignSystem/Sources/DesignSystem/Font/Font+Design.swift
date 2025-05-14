import SwiftUI

public enum DesignFontStyle {
    case largeTitle
    case title
    case title2
    case title3
    case headline
    case subheadline
    case body
    case callout
    case footnote
    case caption
    case caption2
    case caption3
    case button
}


import SwiftUI

public extension Font {
    static func design(_ style: DesignFontStyle) -> Font {
        switch style {
        case .largeTitle:
            return .custom("Inter-Bold", size: 34)
        case .title:
            return .custom("Inter-SemiBold", size: 28)
        case .title2:
            return .custom("Inter-SemiBold", size: 22)
        case .title3:
            return .custom("Inter-SemiBold", size: 20)
        case .headline:
            return .custom("Inter-SemiBold", size: 17)
        case .subheadline:
            return .custom("Inter-Regular", size: 15)
        case .body:
            return .custom("Inter-Regular", size: 17)
        case .callout:
            return .custom("Inter-Regular", size: 16)
        case .footnote:
            return .custom("Inter-Regular", size: 13)
        case .caption:
            return .custom("Inter-Medium", size: 12)
        case .caption2:
            return .custom("Inter-Regular", size: 11)
        case .caption3:
            return .custom("Inter-Regular", size: 10)
        case .button:
            return .custom("Inter-Medium", size: 15)
        }
    }
}

