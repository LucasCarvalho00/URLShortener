//
//  Metrics.swift
//  URLShortener
//
//  Created by Lucas on 06/12/25.
//

import SwiftUI

enum DSMetrics {
    enum Icon {
        
       /// 12 pt – ícone extra pequeno, usado em labels sutis
       static let xs: CGFloat = 12

       /// 16 pt – ícone pequeno, ideal para textos de apoio
       static let sm: CGFloat = 16

       /// 20 pt – ícone médio, tamanho padrão para botões
       static let md: CGFloat = 20

       /// 24 pt – ícone grande, destaque visual maior
       static let lg: CGFloat = 24

       /// 32 pt – ícone extra grande, usado em empty states ou ações principais
       static let xl: CGFloat = 32
   }
    
    enum Text {
        
       /// 20 pt – texto pequeno
       static let xs: CGFloat = 20

       /// 24 pt – texto medio
       static let lg: CGFloat = 24

       /// 32 pt – texto grande
       static let xl: CGFloat = 32
   }
}
