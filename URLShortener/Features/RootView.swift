//
//  RootView.swift
//  URLShortener
//
//  Created by Lucas on 07/12/25.
//

import SwiftUI

struct RootView: View {
    
    @StateObject private var coordinator = NavigationCoordinator()
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            HomeView()
                .navigationDestination(for: AppRoute.self) { route in
                    switch route {
                    case .home:
                        HomeView()
                    case .detail(let alias):
                        DetailView(alias: alias)
                    }
                }
        }
        .environmentObject(coordinator)
    }
}
