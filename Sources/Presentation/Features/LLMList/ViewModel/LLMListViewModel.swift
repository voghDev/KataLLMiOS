import Foundation

@Observable
@MainActor
final class LLMListViewModel {
    enum ViewState: Sendable {
        case idle
        case loading
        case loaded([LLM], User, Subscription)
        case error(String)
    }

    private(set) var state: ViewState = .idle
    private let repository: LLMRepositoryProtocol
    private let profileDataSource: ProfileDataSourceProtocol
    private let subscriptionDataSource: SubscriptionDataSourceProtocol

    init(
        repository: LLMRepositoryProtocol,
        profileDataSource: ProfileDataSourceProtocol,
        subscriptionDataSource: SubscriptionDataSourceProtocol
    ) {
        self.repository = repository
        self.profileDataSource = profileDataSource
        self.subscriptionDataSource = subscriptionDataSource
    }

    func load() async {
        state = .loading
        do {
            async let llms = repository.getLLMs()
            async let user = profileDataSource.getUser()
            async let subscription = subscriptionDataSource.getUserSubscription()
            state = .loaded(try await llms, await user, await subscription)
        } catch let error as AppError {
            state = .error(error.userMessage)
        } catch {
            state = .error(error.localizedDescription)
        }
    }
}
