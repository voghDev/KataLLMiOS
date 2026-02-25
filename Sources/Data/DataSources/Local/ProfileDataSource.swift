import Foundation

protocol ProfileDataSourceProtocol: Sendable {
    func getUser() async -> User
}

struct ProfileDataSource: ProfileDataSourceProtocol {
    func getUser() async -> User {
        User(
            name: "Jane Doe",
            address: "742 Evergreen Terrace, Springfield",
            phoneNumber: "+1 (555) 123-4567",
            profilePictureUrl: ""
        )
    }
}
