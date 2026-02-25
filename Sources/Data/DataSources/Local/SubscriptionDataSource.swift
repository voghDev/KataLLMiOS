import Foundation

protocol SubscriptionDataSourceProtocol: Sendable {
    func getUserSubscription() async -> Subscription
}

struct SubscriptionDataSource: SubscriptionDataSourceProtocol {
    func getUserSubscription() async -> Subscription {
        try? await Task.sleep(for: .seconds(2)) // simulates slow App Store API
        return .free
    }
}
