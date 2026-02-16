import Foundation

@Observable
@MainActor
final class LLMListViewModel {
    enum ViewState: Sendable {
        case idle
        case loading
        case loaded([LLM])
        case error(String)
    }

    private(set) var state: ViewState = .idle
    private let repository: LLMRepositoryProtocol

    init(repository: LLMRepositoryProtocol) {
        self.repository = repository
    }

    func loadLLMs() async {
        state = .loading
        do {
            let llms = try await repository.getLLMs()
            state = .loaded(llms)
        } catch let error as AppError {
            state = .error(error.userMessage)
        } catch {
            state = .error(error.localizedDescription)
        }
    }
}
