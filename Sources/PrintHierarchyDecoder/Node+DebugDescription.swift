extension HierarchyNode {
    public func debugDescription(prefix: String = "", isLast: Bool = true) -> String {
        var descriptions: [String] = []
        let joint = isPresented ? "◇" : isLast ? "└" : "├"
        let nodeName = controllerName.prefix(24)
        descriptions.append("\(prefix)\(joint)── \(nodeName)")
        let newPrefix = prefix + (isLast ? "    " : "│   ")
        for (index, child) in children.enumerated() {
            let description = child.debugDescription(prefix: newPrefix, isLast: index == children.count - 1)
            descriptions.append(description)
        }
        return descriptions.joined(separator: "\n")
    }
}

extension HierarchyNode: CustomDebugStringConvertible {
    public var debugDescription: String {
        var descriptions: [String] = []
        for (index, child) in children.enumerated() {
            let description = child.debugDescription(prefix: "", isLast: index == children.count - 1)
            descriptions.append(description)
        }
        return descriptions.joined(separator: "\n")
    }
}
