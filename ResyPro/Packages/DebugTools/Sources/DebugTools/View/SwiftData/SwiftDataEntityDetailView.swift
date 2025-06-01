import SwiftUI
import SwiftData

/// Displays the stored properties for a SwiftData entity.
public struct SwiftDataEntityDetailView<Entity: PersistentModel>: View {
    private let entity: Entity

    public init(entity: Entity) {
        self.entity = entity
    }

    public var body: some View {
        ScrollView {
            Text(String(reflecting: entity))
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
        }
        .navigationTitle("Details")
        .textSelection(.enabled)
    }
}
