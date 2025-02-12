public final class HierarchyNode: Codable {
    public var controllerName: String = ""
    public var controllerAddress: String = ""
    public var isPresented: Bool = false
    public var children: [HierarchyNode] = []
    
    package init() {}
    
    init(rootChildren: [HierarchyNode]) {
        controllerName = "."
        controllerAddress = "0x000000"
        children = rootChildren
    }
    
    init(name: String, address: String) {
        self.controllerName = name
        self.controllerAddress = address
    }
}

extension HierarchyNode {
    public convenience init(_ printHierarchy: PrintHierarchy) {
        var nodes: [Int : HierarchyNode] = [:]
        var rootNodes: [HierarchyNode] = []
        
        for line in printHierarchy.lines {
            let parentIndex = line.header.positions.count
            let isPresented = line.header.positions.last == .presented
            // name:addressだとpresentするごとに生成されて大変
            // name:indexだとnameが重複したときにだるい
            let name = line.controller.name
            let address = line.controller.address
            let node = HierarchyNode(name: name, address: address)
            node.isPresented = isPresented
            nodes[parentIndex] = node
            
            if parentIndex == 0 {
                rootNodes.append(node)
            } else {
                if let parentNode = nodes[parentIndex - 1] {
                    parentNode.children.append(node)
                }
            }
        }
        self.init(rootChildren: rootNodes)
    }
}


