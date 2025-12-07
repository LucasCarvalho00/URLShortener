//
//  HomeViewSnapshotTests.swift
//  URLShortener
//
//  Created by Lucas on 07/12/25.
//

import SwiftUI
import Testing
import SnapshotTesting
@testable import URLShortener

/*
 O que estes snapshots verificam:
 - Aparência da HomeView nos estados:
    - Empty state (sem itens, sem loading).
    - Loading state.
    - Lista com itens.
*/

@MainActor
struct HomeViewSnapshotTests {
    
    // MARK: - Helpers
    
    /// Cria a HomeView com um HomeViewModel configurado e um NavigationCoordinator.
    private func makeView(viewModel: HomeViewModel) -> some View {
        let coordinator = NavigationCoordinator() 
        return HomeView(viewModel: viewModel)
            .environmentObject(coordinator)
    }
    
    /// Helper pra tirar snapshot de uma View SwiftUI em um device padrão.
    private func assertSnapshot<V: View>(
        of view: V,
        named name: String,
        file: StaticString = #file,
        testName: String = #function,
        line: UInt = #line
    ) {
        SnapshotTesting.assertSnapshot(
            of: view,
            as: .image(layout: .device(config: .iPhone13)),
            named: name,
            file: file,
            testName: testName,
            line: line
        )
    }
    
    // MARK: - Tests
    
    @Test
    func homeView_emptyState_snapshot() {
        let vm = HomeViewModel(createShortenURLUseCase: CreateShortenURLUseCaseMock())
        vm.isLoading = false
        vm.items = []
        vm.errorMessage = nil
        
        let view = makeView(viewModel: vm)
        
        assertSnapshot(of: view, named: "HomeView_EmptyState")
    }
    
    @Test
    func homeView_loadingState_snapshot() {
        let vm = HomeViewModel(createShortenURLUseCase: CreateShortenURLUseCaseMock())
        vm.isLoading = true
        vm.items = []
        vm.errorMessage = nil
        
        let view = makeView(viewModel: vm)
        
        assertSnapshot(of: view, named: "HomeView_LoadingState")
    }
    
    @Test
    func homeView_listWithItems_snapshot() {
        let vm = HomeViewModel(createShortenURLUseCase: CreateShortenURLUseCaseMock())
        vm.isLoading = false
        vm.errorMessage = nil
        vm.items = [
            HomeListItem(title: "alias-1", subTitle: "https://sho.rt/1"),
            HomeListItem(title: "alias-2", subTitle: "https://sho.rt/2"),
            HomeListItem(title: "alias-3", subTitle: "https://sho.rt/3")
        ]
        
        let view = makeView(viewModel: vm)
        
        assertSnapshot(of: view, named: "HomeView_ListWithItems")
    }
}
