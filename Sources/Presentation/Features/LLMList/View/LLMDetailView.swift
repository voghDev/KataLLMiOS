import SwiftUI

struct LLMDetailView: View {
    let llm: LLM

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(llm.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text(llm.company)
                        .font(.title2)
                        .foregroundStyle(.secondary)
                }

                LabeledContent("Release Date") {
                    Text(llm.formattedReleaseDate)
                }
                .font(.body)

                VStack(alignment: .leading, spacing: 8) {
                    Text("Description")
                        .font(.headline)
                    Text(llm.description)
                        .font(.body)
                        .foregroundStyle(.secondary)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .navigationTitle(llm.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
