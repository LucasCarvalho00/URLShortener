//
//  DetailViewSnapshotTests.swift
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
 - Aparência da DetailView nos estados:
    - Loading (isLoading == true).
    - Sucesso (URL original recuperada, sem erro).
    - Erro (mensagem de erro exibida).
*/

@MainActor
struct DetailViewSnapshotTests {
    
    // MARK: - Helpers
    
    /// Helper para tirar snapshot de uma View SwiftUI em um device padrão.
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
    func detailView_loadingState_snapshot() {
        let vm = DetailViewModel(alias: "meu-alias")
        vm.isLoading = true
        vm.errorMessage = ""
        vm.originalURL = ""
        
        // Usa o init(viewModel:shouldLoadOnAppear:) para não disparar loadScreenData no .task
        let view = DetailView(viewModel: vm, shouldLoadOnAppear: false)
        
        assertSnapshot(of: view, named: "DetailView_LoadingState")
    }
    
    @Test
    func detailView_successState_snapshot() {
        let vm = DetailViewModel(alias: "meu-alias")
        vm.isLoading = false
        vm.errorMessage = ""
        vm.originalURL = "https://meu-site-original.com/path"
        
        let view = DetailView(viewModel: vm, shouldLoadOnAppear: false)
        
        assertSnapshot(of: view, named: "DetailView_SuccessState")
    }
    
    @Test
    func detailView_errorState_snapshot() {
        let vm = DetailViewModel(alias: "meu-alias")
        vm.isLoading = false
        vm.errorMessage = "Não foi possível recuperar a URL encurtada."
        vm.originalURL = ""
        
        let view = DetailView(viewModel: vm, shouldLoadOnAppear: false)
        
        assertSnapshot(of: view, named: "DetailView_ErrorState")
    }
}
