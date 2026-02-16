import SwiftUI

@main
struct KataLLMiOSApp: App {
    private let container = DIContainer()
    @State private var coordinator: LLMListCoordinator?

    var body: some Scene {
        WindowGroup {
            Group {
                if let coordinator {
                    coordinator.start()
                } else {
                    ProgressView()
                }
            }
            .onAppear {
                if coordinator == nil {
                    coordinator = container.makeLLMListCoordinator()
                }
            }
        }
    }
}
