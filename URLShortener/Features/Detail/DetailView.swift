import SwiftUI

struct DetailView: View {
    
    // MARK: - Constants
    
    private enum Constants {
        static let loadingText = "Recuperando URL original..."
        static let title = "URL recuperada:"
    }
    
    // MARK: - Private Attributes
    
    @StateObject private var viewModel: DetailViewModel
    private let shouldLoadOnAppear: Bool

    // MARK: - Initializers
    
    init(alias: String) {
        _viewModel = StateObject(wrappedValue: DetailViewModel(alias: alias))
        self.shouldLoadOnAppear = true
    }
    
    /// Inicializador para testes / injeção de dependência
    init(
        viewModel: DetailViewModel,
        shouldLoadOnAppear: Bool = true
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.shouldLoadOnAppear = shouldLoadOnAppear
    }
    
    // MARK: - Body
    
    var body: some View {
        content.task {
            guard shouldLoadOnAppear else { return }
            await viewModel.loadScreenData()
        }
    }
    
    // MARK: - Private Views

    @ViewBuilder
    private var content: some View {
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
            if viewModel.errorMessage.isEmpty {
                DSText(
                    Constants.title,
                    style: .title,
                    color: .DSSecondary,
                    alignment: .center
                )
                DSText(
                    viewModel.originalURL,
                    style: .caption,
                    color: .DSSecondary,
                    alignment: .center
                )
                
            } else {
                DSText(
                    viewModel.errorMessage,
                    style: .caption,
                    color: .dsError,
                    alignment: .center
                )
            }
        }
    }
}

#Preview {
    DetailView(alias: "1571847627")
}
