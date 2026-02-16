import Foundation

struct DIContainer {
    func makeLLMLocalDataSource() -> LLMLocalDataSourceProtocol {
        LLMLocalDataSource()
    }

    func makeLLMRepository() -> LLMRepositoryProtocol {
        LLMRepository(localDataSource: makeLLMLocalDataSource())
    }

    func makeLLMListCoordinator() -> LLMListCoordinator {
        LLMListCoordinator(repository: makeLLMRepository())
    }
}
