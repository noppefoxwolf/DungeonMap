//
//  RootNodeMergeTests.swift
//  DungeonMap
//
//  Created by Tomoya Hirano on 2025/02/10.
//


import Testing
@testable import PrintHierarchyDecoder

@Suite
struct RootNodeMergeTests {
    @Test
    func emptyVSOne() throws {
        var a = RootNode()
        a.children = []
        var b = RootNode()
        b.children = [
            HierarchyNode(id: "0", name: "0", isPresented: false)
        ]
        a.merge(with: b)
        #expect(a.children.count == 1)
    }
    
    @Test
    func oneVSSameOne() throws {
        var a = RootNode()
        a.children = [
            HierarchyNode(id: "0", name: "0", isPresented: false)
        ]
        var b = RootNode()
        b.children = [
            HierarchyNode(id: "0", name: "0", isPresented: false)
        ]
        a.merge(with: b)
        #expect(a.children.count == 1)
    }
    
    @Test
    func oneVSOne() throws {
        var a = RootNode()
        a.children = [
            HierarchyNode(id: "0", name: "0", isPresented: false)
        ]
        var b = RootNode()
        b.children = [
            HierarchyNode(id: "1", name: "1", isPresented: false)
        ]
        a.merge(with: b)
        #expect(a.children.count == 2)
    }
    
    @Test
    func oneVSEmpty() throws {
        var a = RootNode()
        a.children = [
            HierarchyNode(id: "0", name: "0", isPresented: false)
        ]
        var b = RootNode()
        b.children = []
        a.merge(with: b)
        #expect(a.children.count == 1)
    }
    
    @Test
    func aaa() throws {
        var a = RootNode()
        a.children = [
            HierarchyNode(id: "0", name: "0", isPresented: false),
            HierarchyNode(id: "1", name: "1", isPresented: false),
        ]
        var b = RootNode()
        b.children = [
            HierarchyNode(id: "0", name: "0", isPresented: false),
            HierarchyNode(id: "2", name: "2", isPresented: false),
        ]
        a.merge(with: b)
        #expect(a.children.count == 1)
    }
}

