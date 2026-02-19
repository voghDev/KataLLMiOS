import Foundation

struct LLMDTO: Codable, Sendable {
    let id: String
    let name: String
    let company: String
    let releaseDate: String
    let description: String

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()

    func toDomain() throws -> LLM {
        guard let uuid = UUID(uuidString: id) else {
            throw AppError.decodingFailed("Invalid UUID: \(id)")
        }
        guard let date = Self.dateFormatter.date(from: releaseDate) else {
            throw AppError.decodingFailed("Invalid date: \(releaseDate)")
        }
        return LLM(
            id: uuid,
            name: name,
            company: company,
            releaseDate: date,
            description: description
        )
    }
}
