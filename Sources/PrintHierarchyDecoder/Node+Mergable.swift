package protocol Mergable {
    mutating func merge(with other: Self)
}

extension Mergable {
    package func merged(with other: Self, allInclusive: Bool) -> Self {
        var copy = self
        copy.merge(with: other)
        return copy
    }
}

extension RootNode: Mergable {
    package mutating func merge(with other: RootNode) {
        for child in other.children {
            if let index = children.firstIndex(where: { $0.id == child.id }) {
                // 子ノードが既に存在する場合、再帰的にマージ
                children[index].merge(with: child)
            } else {
                // 子ノードが存在しない場合は追加
                children.append(child)
            }
        }
    }
}

extension HierarchyNode: Mergable {
    package func merge(with other: HierarchyNode) {
        for child in other.children {
            if let index = children.firstIndex(where: { $0.id == child.id }) {
                // 子ノードが既に存在する場合、再帰的にマージ
                children[index].merge(with: child)
            } else {
                // 子ノードが存在しない場合は追加
                children.append(child)
            }
        }
    }
}

