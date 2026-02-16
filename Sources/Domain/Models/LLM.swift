import Foundation

struct LLM: Identifiable, Hashable, Sendable {
    let id: UUID
    let name: String
    let company: String
    let releaseDate: Date
    let description: String

    var formattedReleaseDate: String {
        releaseDate.formatted(date: .abbreviated, time: .omitted)
    }
}
