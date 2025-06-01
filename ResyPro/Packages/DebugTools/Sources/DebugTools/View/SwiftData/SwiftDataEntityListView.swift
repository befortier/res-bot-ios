import SwiftUI
import SwiftData
import ProjectFoundation

/// Lists all stored entities of the provided type.
public struct SwiftDataEntityListView<Entity: PersistentModel & Identifiable>: View {
    @Query private var entities: [Entity]

    public init() {}

    public var body: some View {
        List(entities) { entity in
            NavigationLink("\(String(describing: entity.id))") {
                SwiftDataEntityDetailView(entity: entity)
            }
        }
        .navigationTitle(String(describing: Entity.self))
    }
}
