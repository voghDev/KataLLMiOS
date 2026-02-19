import SwiftUI

struct LLMRowView: View {
    let llm: LLM

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(llm.name)
                .font(.headline)
            HStack {
                Text(llm.company)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Spacer()
                Text(llm.formattedReleaseDate)
                    .font(.caption)
                    .foregroundStyle(.tertiary)
            }
        }
        .padding(.vertical, 4)
    }
}
