import SwiftUI

struct LLMListView: View {
    @Bindable var coordinator: LLMListCoordinator
    var viewModel: LLMListViewModel

    var body: some View {
        Group {
            switch viewModel.state {
            case .idle:
                Color.clear
            case .loading:
                ProgressView("Loading LLMs...")
            case .loaded(let llms):
                List(llms) { llm in
                    LLMRowView(llm: llm)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            coordinator.showDetail(for: llm)
                        }
                }
            case .error(let message):
                ContentUnavailableView {
                    Label("Error", systemImage: "exclamationmark.triangle")
                } description: {
                    Text(message)
                } actions: {
                    Button("Retry") {
                        Task { await viewModel.loadLLMs() }
                    }
                }
            }
        }
        .navigationTitle("LLMs")
        .task {
            if case .idle = viewModel.state {
                await viewModel.loadLLMs()
            }
        }
    }
}
