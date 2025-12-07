//
//  ContentView.swift
//  URLShortener
//
//  Created by Lucas on 06/12/25.
//

import SwiftUI

struct HomeView: View {
    
    // MARK: - Constants
    
    private enum Constants {
        static let placeholderURL = "https://sou.nu"
        static let recentlyShortenedTitle = "Recently shortened URLs"
        static let titleEmptyState = "Nenhuma URL encurtada ainda"
        static let descriptionEmptyState = "Digite uma URL acima e toque no botão para criar seu primeiro link encurtado."
        static let loadingText = "Encurtando URL..."
    }
    
    // MARK: - Private Attributes
    
    @StateObject private var viewModel: HomeViewModel
    @EnvironmentObject private var coordinator: NavigationCoordinator

    // MARK: - Initializers
    
    init(viewModel: HomeViewModel = HomeViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: DSSpacing.sm) {
                DSTextField(
                    text: $viewModel.inputText,
                    placeholder: Constants.placeholderURL
                )
                .onChange(of: viewModel.inputText) { _ in
                    viewModel.errorMessage = nil
                }
                
                DSIconButton(
                    image: DSImages.send
                ) {
                    viewModel.didTapAddButton()
                }
                .disabled(viewModel.isLoading)
                .opacity(viewModel.isLoading ? 0.5 : 1.0)
            }
            .padding(.top, DSSpacing.xl)
            
            DSText(
                viewModel.errorMessage ?? "",
                style: .caption,
                color: .DSError
            )
            .frame(height: DSMetrics.Text.xs)
            
            DSText(
                Constants.recentlyShortenedTitle,
                style: .title,
                color: .DSSecondary
            )
            .padding(.top, DSSpacing.lg)
            
            if viewModel.isLoading {
                VStack(spacing: DSSpacing.xs) {
                    ProgressView()
                        .scaleEffect(0.9)

                    DSText(
                        Constants.loadingText,
                        style: .caption,
                        color: .DSSecondary,
                        alignment: .center
                    )
                }
                .padding(DSSpacing.md)
                .background(Color.DSBackground)
                .cornerRadius(DSRadius.md)
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .center
                )
            } else {
                
                if viewModel.items.isEmpty {
                    VStack(spacing: DSSpacing.sm) {
                        DSText(
                            Constants.titleEmptyState,
                            style: .title,
                            color: .DSSecondary,
                            alignment: .center
                        )

                        DSText(
                            Constants.descriptionEmptyState,
                            style: .body,
                            color: .DSSecondary,
                            alignment: .center
                        )
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .padding(.vertical, DSSpacing.xl)
                    
                } else {
                    List(viewModel.items) { item in
                        DSTextListItem(
                            primaryText: item.title,
                            secondaryText: item.subTitle
                        )
                        .listRowInsets(
                            .init(
                                top: DSSpacing.sm,
                                leading: 0,
                                bottom: DSSpacing.sm,
                                trailing: 0
                            )
                        )
                        .onTapGesture {
                            coordinator.showDetail(alias: item.title)
                        }
                    }
                    .listStyle(.plain)
                    .padding(.vertical, DSSpacing.xs)
                }
            }
        }
        .padding(DSSpacing.md)
    }
}

#Preview {
    HomeView()
}
