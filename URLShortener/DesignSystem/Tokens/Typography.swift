//
//  Typography.swift
//  URLShortener
//
//  Created by Lucas on 06/12/25.
//

import SwiftUI

enum DSTypography {

    /// Título extra grande
    /// - Fonte: System
    /// - Tamanho: 28 pt
    /// - Estilo: Bold
    static let titleXL = Font.system(size: 22, weight: .bold, design: .default)

    /// Título grande
    /// - Fonte: System
    /// - Tamanho: 22 pt
    /// - Estilo: Bold
    static let titleL = Font.system(size: 18, weight: .bold, design: .default)

    /// Título médio
    /// - Fonte: System
    /// - Tamanho: 14 pt
    /// - Estilo: Semibold
    static let titleM = Font.system(size: 14, weight: .semibold, design: .default)

    /// Corpo de texto grande
    /// - Fonte: System
    /// - Tamanho: 16 pt
    /// - Estilo: Regular
    static let bodyL = Font.system(size: 16, weight: .regular, design: .default)

    /// Corpo de texto padrão
    /// - Fonte: System
    /// - Tamanho: 14 pt
    /// - Estilo: Regular
    static let bodyM = Font.system(size: 14, weight: .regular, design: .default)

    /// Legenda / texto de apoio
    /// - Fonte: System
    /// - Tamanho: 12 pt
    /// - Estilo: Regular
    static let caption = Font.system(size: 14, weight: .regular, design: .default)

    /// Legenda em destaque
    /// - Fonte: System
    /// - Tamanho: 12 pt
    /// - Estilo: Semibold
    static let captionBold = Font.system(size: 14, weight: .semibold, design: .default)
}
