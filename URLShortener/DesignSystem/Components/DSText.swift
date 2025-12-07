//
//  DSText.swift
//  URLShortener
//
//  Created by Lucas on 06/12/25.
//

import SwiftUI

// MARK: - DSTextStyle

enum DSTextStyle {
    case title
    case subtitle
    case body
    case caption
}

// MARK: - DSText

struct DSText: View {

    // MARK: - Internal Attributes

    let text: String
    let style: DSTextStyle
    let color: Color
    let alignment: TextAlignment

    // MARK: - Initializers

    init(
        _ text: String,
        style: DSTextStyle = .body,
        color: Color = .DSPrimary,
        alignment: TextAlignment = .leading
    ) {
        self.text = text
        self.style = style
        self.color = color
        self.alignment = alignment
    }
    
    // MARK: - Body

    var body: some View {
        Text(text)
            .font(resolvedFont)
            .foregroundColor(color)
            .multilineTextAlignment(alignment)
            .frame(
                maxWidth: .infinity,
                alignment: resolvedHorizontalAlignment
            )
    }

    // MARK: - Private Computed Properties

    private var resolvedFont: Font {
        switch style {
        case .title:
            return DSTypography.titleM
        case .subtitle:
            return DSTypography.bodyL
        case .body:
            return DSTypography.bodyM
        case .caption:
            return DSTypography.caption
        }
    }

    private var resolvedHorizontalAlignment: Alignment {
        switch alignment {
        case .leading:
            return .leading
        case .center:
            return .center
        case .trailing:
            return .trailing
        }
    }
}

// MARK: - Preview

#Preview {
    VStack(spacing: DSSpacing.sm) {
        DSText(
            "Título de exemplo",
            style: .title,
            color: .DSPrimary
        )

        DSText(
            "Subtítulo explicativo",
            style: .subtitle,
            color: .DSSecondary
        )

        DSText(
            "Texto de corpo padrão para demonstrar o uso do componente DSText.",
            style: .body,
            color: .DSPrimary
        )

        DSText(
            "Legenda ou texto auxiliar",
            style: .caption,
            color: .DSSecondary
        )
    }
    .padding()
    .background(Color.DSBackground)
}
