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
            case .loaded(let llms, _, _):
                List(llms) { llm in
                    LLMRowView(llm: llm)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            coordinator.showDetail(for: llm)
                        }
                }
                .contentMargins(.top, 0, for: .scrollContent)
            case .error(let message):
                ContentUnavailableView {
                    Label("Error", systemImage: "exclamationmark.triangle")
                } description: {
                    Text(message)
                } actions: {
                    Button("Retry") {
                        Task { await viewModel.load() }
                    }
                }
            }
        }
        .navigationTitle("LLMs")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    coordinator.openProfile()
                } label: {
                    Image(systemName: "person.circle")
                }
            }
        }
        .sheet(isPresented: Binding(get: { coordinator.showingProfile }, set: { coordinator.showingProfile = $0 })) {
            NavigationStack {
                ProfileView(viewModel: coordinator.profileViewModel)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button("Close") {
                                coordinator.showingProfile = false
                            }
                        }
                    }
            }
        }
        .task {
            if case .idle = viewModel.state {
                await viewModel.load()
            }
        }
    }
}
