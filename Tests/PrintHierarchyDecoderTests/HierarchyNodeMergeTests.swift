import Testing
@testable import PrintHierarchyDecoder

@Suite
struct HierarchyNodeMergeTests {
    @Test
    func emptyVSOne() throws {
        var a = HierarchyNode()
        a.children = []
        var b = HierarchyNode()
        b.children = [
            HierarchyNode(id: "0", name: "0", address: "0x000000")
        ]
        a.merge(with: b)
        #expect(a.children.count == 1)
    }
    
    @Test
    func oneVSSameOne() throws {
        var a = HierarchyNode()
        a.children = [
            HierarchyNode(id: "0", name: "0", address: "0x000000")
        ]
        var b = HierarchyNode()
        b.children = [
            HierarchyNode(id: "0", name: "0", address: "0x000000")
        ]
        a.merge(with: b)
        #expect(a.children.count == 1)
    }
    
    @Test
    func oneVSOne() throws {
        var a = HierarchyNode()
        a.children = [
            HierarchyNode(id: "0", name: "0", address: "0x000000")
        ]
        var b = HierarchyNode()
        b.children = [
            HierarchyNode(id: "1", name: "1", address: "0x000000")
        ]
        a.merge(with: b)
        #expect(a.children.count == 2)
    }
    
    @Test
    func oneVSEmpty() throws {
        var a = HierarchyNode()
        a.children = [
            HierarchyNode(id: "0", name: "0", address: "0x000000")
        ]
        var b = HierarchyNode()
        b.children = []
        a.merge(with: b)
        #expect(a.children.count == 1)
    }
}

