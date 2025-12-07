//
//  DSButton.swift
//  URLShortener
//
//  Created by Lucas on 06/12/25.
//

import SwiftUI

struct DSIconButton: View {

    // MARK: - Internal Attributes

    let image: Image
    let backgroundColor: Color
    let foregroundColor: Color
    let action: () -> Void

    // MARK: - Initializers

    init(
        image: Image,
        backgroundColor: Color = .DSPrimary,
        foregroundColor: Color = .DSSecondary,
        action: @escaping () -> Void
    ) {
        self.image = image
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.action = action
    }

    // MARK: - Body

    var body: some View {
        Button(action: action) {
            image
                .resizable()
                .scaledToFit()
                .frame(
                    width: DSMetrics.Icon.md,
                    height: DSMetrics.Icon.md
                )
                .foregroundColor(foregroundColor)
                .padding(.horizontal, DSSpacing.md)
                .padding(.vertical, DSSpacing.sm)
        }
        .background(backgroundColor)
        .cornerRadius(DSRadius.lg)
        .buttonStyle(.plain)
    }
}

// MARK: - Preview

#Preview {
    DSIconButton(
        image: DSImages.send
    ) {
        print("Tocou no botão")
    }
    .padding()
    .background(Color.DSBackground)
}
