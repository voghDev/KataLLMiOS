import SwiftUI

struct ProfileView: View {
    var viewModel: ProfileViewModel

    var body: some View {
        Group {
            switch viewModel.state {
            case .idle, .loading:
                ProgressView("Loading profile...")
            case .loaded(let user):
                ProfileContentView(user: user)
            case .error(let message):
                ContentUnavailableView {
                    Label("Error", systemImage: "exclamationmark.triangle")
                } description: {
                    Text(message)
                }
            }
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            if case .idle = viewModel.state {
                await viewModel.loadProfile()
            }
        }
    }
}

private struct ProfileContentView: View {
    let user: User

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Circle()
                    .fill(Color.accentColor.opacity(0.2))
                    .frame(width: 120, height: 120)
                    .overlay {
                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFit()
                            .padding(28)
                            .foregroundStyle(Color.accentColor)
                    }

                Text(user.name)
                    .font(.title)
                    .fontWeight(.bold)

                VStack(spacing: 0) {
                    ProfileInfoRow(
                        systemImage: "house.fill",
                        label: "Address",
                        value: user.address
                    )
                    Divider().padding(.leading, 56)
                    ProfileInfoRow(
                        systemImage: "phone.fill",
                        label: "Phone",
                        value: user.phoneNumber
                    )
                }
                .background(Color(.secondarySystemGroupedBackground))
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
    }
}

private struct ProfileInfoRow: View {
    let systemImage: String
    let label: String
    let value: String

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: systemImage)
                .foregroundStyle(Color.accentColor)
                .frame(width: 32)

            VStack(alignment: .leading, spacing: 2) {
                Text(label)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(value)
                    .font(.body)
            }

            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }
}
