//
//  DSTextListItem.swift
//  URLShortener
//
//  Created by Lucas on 06/12/25.
//

import SwiftUI

struct DSTextListItem: View {

    // MARK: - Internal Attributes

    let primaryText: String
    let secondaryText: String
    let primaryStyle: DSTextStyle
    let secondaryStyle: DSTextStyle
    let primaryColor: Color
    let secondaryColor: Color

    // MARK: - Initializers

    init(
        primaryText: String,
        secondaryText: String,
        primaryStyle: DSTextStyle = .title,
        secondaryStyle: DSTextStyle = .body,
        primaryColor: Color = .DSSecondary,
        secondaryColor: Color = .DSSecondary
    ) {
        self.primaryText = primaryText
        self.secondaryText = secondaryText
        self.primaryStyle = primaryStyle
        self.secondaryStyle = secondaryStyle
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor
    }

    // MARK: - Body

    var body: some View {
        VStack(
            alignment: .leading,
            spacing: DSSpacing.xxs
        ) {
            DSText(
                primaryText,
                style: primaryStyle,
                color: primaryColor,
                alignment: .leading
            )
            .lineLimit(1)

            DSText(
                secondaryText,
                style: secondaryStyle,
                color: secondaryColor,
                alignment: .leading
            )
            .lineLimit(2)
        }
    }
}

// MARK: - Preview

#Preview {
    DSTextListItem(
        primaryText: "https://sou.nu/abc123",
        secondaryText: "https://www.example.com/minha-url-original"
    )
}
