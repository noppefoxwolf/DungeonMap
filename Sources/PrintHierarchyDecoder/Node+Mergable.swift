package protocol Mergable {
    func merge(with other: Self, by predicate: (Self, Self) throws -> Bool)
}

extension Mergable {
    package func merged(with other: Self, by predicate: (Self, Self) throws -> Bool) -> Self {
        var copy = self
        copy.merge(with: other, by: predicate)
        return copy
    }
}

extension HierarchyNode: Mergable {
    package func merge(with other: HierarchyNode, by predicate: (HierarchyNode, HierarchyNode) throws -> Bool) {
        for child in other.children {
            if let index = try! children.firstIndex(where: { try predicate($0, child) }) {
                children[index].merge(with: child, by: predicate)
            } else {
                children.append(child)
            }
        }
    }
}
