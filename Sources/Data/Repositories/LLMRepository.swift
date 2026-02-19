import Foundation

protocol LLMRepositoryProtocol: Sendable {
    func getLLMs() async throws -> [LLM]
}

struct LLMRepository: LLMRepositoryProtocol {
    private let localDataSource: LLMLocalDataSourceProtocol

    init(localDataSource: LLMLocalDataSourceProtocol) {
        self.localDataSource = localDataSource
    }

    func getLLMs() async throws -> [LLM] {
        let dtos = try await localDataSource.fetchLLMs()
        return try dtos
            .map { try $0.toDomain() }
            .sorted { $0.releaseDate > $1.releaseDate }
    }
}
