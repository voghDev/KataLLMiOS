import Foundation

protocol LLMLocalDataSourceProtocol: Sendable {
    func fetchLLMs() async throws -> [LLMDTO]
}

struct LLMLocalDataSource: LLMLocalDataSourceProtocol {
    func fetchLLMs() async throws -> [LLMDTO] {
        guard let url = Bundle.main.url(forResource: "llms", withExtension: "json") else {
            throw AppError.dataNotFound("llms.json not found in bundle")
        }
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([LLMDTO].self, from: data)
        } catch let error as AppError {
            throw error
        } catch {
            throw AppError.decodingFailed(error.localizedDescription)
        }
    }
}
