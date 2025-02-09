import Testing
@testable import PrintHierarchyDecoder

@Suite
struct HierarchyNodeMergeTests {
    @Test
    func emptyVSOne() throws {
        var a = HierarchyNode(id: "root", name: "root", isPresented: false)
        a.children = []
        var b = HierarchyNode(id: "root", name: "root", isPresented: false)
        b.children = [
            HierarchyNode(id: "0", name: "0", isPresented: false)
        ]
        a.merge(with: b)
        #expect(a.children.count == 1)
    }
    
    @Test
    func oneVSSameOne() throws {
        var a = HierarchyNode(id: "root", name: "root", isPresented: false)
        a.children = [
            HierarchyNode(id: "0", name: "0", isPresented: false)
        ]
        var b = HierarchyNode(id: "root", name: "root", isPresented: false)
        b.children = [
            HierarchyNode(id: "0", name: "0", isPresented: false)
        ]
        a.merge(with: b)
        #expect(a.children.count == 1)
    }
    
    @Test
    func oneVSOne() throws {
        var a = HierarchyNode(id: "root", name: "root", isPresented: false)
        a.children = [
            HierarchyNode(id: "0", name: "0", isPresented: false)
        ]
        var b = HierarchyNode(id: "root", name: "root", isPresented: false)
        b.children = [
            HierarchyNode(id: "1", name: "1", isPresented: false)
        ]
        a.merge(with: b)
        #expect(a.children.count == 2)
    }
    
    @Test
    func oneVSEmpty() throws {
        var a = HierarchyNode(id: "root", name: "root", isPresented: false)
        a.children = [
            HierarchyNode(id: "0", name: "0", isPresented: false)
        ]
        var b = HierarchyNode(id: "root", name: "root", isPresented: false)
        b.children = []
        a.merge(with: b)
        #expect(a.children.count == 1)
    }
}

