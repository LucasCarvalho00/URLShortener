//
//  FlowController.swift
//  URLShortener
//
//  Created by Lucas on 07/12/25.
//

import SwiftUI
import Combine

final class NavigationCoordinator: ObservableObject {
    
    // MARK: - Internal Attributes

    @Published var path: [AppRoute] = []
    @Published var root: AppRoute = .home
    
    // MARK: - Internal Functions

    func push(_ route: AppRoute) {
        path.append(route)
    }
    
    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeAll()
    }
        
    func showDetail(alias: String) {
        push(.detail(alias: alias))
    }
}

