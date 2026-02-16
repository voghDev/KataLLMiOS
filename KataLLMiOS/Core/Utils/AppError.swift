import Foundation

enum AppError: Error, Sendable {
    case dataNotFound(String)
    case decodingFailed(String)
    case unknown(String)

    var userMessage: String {
        switch self {
        case .dataNotFound(let detail):
            return "Data not found: \(detail)"
        case .decodingFailed(let detail):
            return "Failed to read data: \(detail)"
        case .unknown(let detail):
            return "Something went wrong: \(detail)"
        }
    }
}
