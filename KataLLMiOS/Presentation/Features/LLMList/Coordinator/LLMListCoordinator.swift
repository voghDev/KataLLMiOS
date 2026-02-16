import SwiftUI

@Observable
@MainActor
final class LLMListCoordinator {
    var path: [LLM] = []
    let viewModel: LLMListViewModel

    init(repository: LLMRepositoryProtocol) {
        self.viewModel = LLMListViewModel(repository: repository)
    }

    func showDetail(for llm: LLM) {
        path.append(llm)
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
