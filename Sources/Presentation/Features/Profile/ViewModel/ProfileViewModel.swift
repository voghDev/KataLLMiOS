import Foundation

@Observable
@MainActor
final class ProfileViewModel {
    enum ViewState: Sendable {
        case idle
        case loading
        case loaded(User)
        case error(String)
    }

    private(set) var state: ViewState = .idle
    private let dataSource: ProfileDataSourceProtocol

    init(dataSource: ProfileDataSourceProtocol) {
        self.dataSource = dataSource
    }

    func loadProfile() async {
        state = .loading
        let user = await dataSource.getUser()
        state = .loaded(user)
    }
}
