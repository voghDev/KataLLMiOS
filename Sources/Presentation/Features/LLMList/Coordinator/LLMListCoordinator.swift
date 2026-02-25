import SwiftUI

@Observable
@MainActor
final class LLMListCoordinator {
    var path: [LLM] = []
    var showingProfile = false
    let viewModel: LLMListViewModel
    let profileViewModel: ProfileViewModel

    init(repository: LLMRepositoryProtocol, profileDataSource: ProfileDataSourceProtocol) {
        self.viewModel = LLMListViewModel(repository: repository)
        self.profileViewModel = ProfileViewModel(dataSource: profileDataSource)
    }

    func showDetail(for llm: LLM) {
        path.append(llm)
    }

    func openProfile() {
        showingProfile = true
    }

    func start() -> some View {
        NavigationStack(path: Binding(get: { self.path }, set: { self.path = $0 })) {
            LLMListView(coordinator: self, viewModel: viewModel)
                .navigationDestination(for: LLM.self) { llm in
                    LLMDetailView(llm: llm)
                }
        }
    }
}
