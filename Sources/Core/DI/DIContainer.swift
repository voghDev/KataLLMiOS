import Foundation

struct DIContainer {
    func makeLLMLocalDataSource() -> LLMLocalDataSourceProtocol {
        LLMLocalDataSource()
    }

    func makeLLMRepository() -> LLMRepositoryProtocol {
        LLMRepository(localDataSource: makeLLMLocalDataSource())
    }

    func makeLLMListCoordinator() -> LLMListCoordinator {
        LLMListCoordinator(repository: makeLLMRepository(), profileDataSource: makeProfileDataSource())
    }

    func makeProfileDataSource() -> ProfileDataSourceProtocol {
        ProfileDataSource()
    }

    func makeProfileViewModel() -> ProfileViewModel {
        ProfileViewModel(dataSource: makeProfileDataSource())
    }
}
