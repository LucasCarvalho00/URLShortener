//
//  DSTextField.swift
//  URLShortener
//
//  Created by Lucas on 06/12/25.
//

import SwiftUI

struct DSTextField: View {

    // MARK: - Internal Attributes

    @Binding var text: String
    let placeholder: String
    let keyboardType: UIKeyboardType

    // MARK: - Initializers

    init(
        text: Binding<String>,
        placeholder: String,
        keyboardType: UIKeyboardType = .URL
    ) {
        self._text = text
        self.placeholder = placeholder
        self.keyboardType = keyboardType
    }

    // MARK: - Body
    
    var body: some View {
        TextField(placeholder, text: $text)
            .keyboardType(keyboardType)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled(true)
            .font(DSTypography.bodyM)
            .padding(.horizontal, DSSpacing.md)
            .padding(.vertical, DSSpacing.sm)
            .background(Color.DSPrimary)
            .clipShape(Capsule())
    }
}

// MARK: - Preview

#Preview {
    VStack(spacing: DSSpacing.md) {
        DSTextField(
            text: .constant("https://sou.nu"),
            placeholder: "https://sou.nu"
        )

        DSTextField(
            text: .constant(""),
            placeholder: "Digite uma URL",
            keyboardType: .URL
        )
    }
    .padding()
}
