import Testing
import Foundation
@testable import PrintHierarchyDecoder

@Test
func decodeFailedCase001() async throws {
    let string = """
    <_TtGC7SwiftUI19UIHostingControllerV7Example11ContentView_ 0x104027800>, state: appearing, view: <_TtGC7SwiftUI14_UIHostingViewV7Example11ContentView_: 0x102f0fb30>
       | <SwiftUI.UIKitTabBarController 0x103810a00>, state: appearing, view: <UILayoutContainerView: 0x104c0ebd0>
       |    | <_TtGC7SwiftUI19UIHostingControllerVVS_7TabItem8RootView_ 0x103828a00>, state: appearing, view: <_TtGC7SwiftUI14_UIHostingViewVVS_7TabItem8RootView_: 0x104c10fc0>
       |    |    | <SwiftUI.NotifyingMulticolumnSplitViewController 0x104c283e0>, state: appearing, view: <_UISplitViewControllerPanelImplView: 0x104c33030>
       |    |    |    | <_TtGC7SwiftUI41StyleContextSplitViewNavigationControllerVS_19SidebarStyleContext_ 0x10389b600>, state: appearing, view: <UILayoutContainerView: 0x104c33f20>
       |    |    |    |    | <_TtGC7SwiftUI19UIHostingControllerGVS_15ModifiedContentGS1_VVS_22_VariadicView_Children7ElementVS_24NavigationColumnModifier_GVS_18StyleContextWriterVS_19SidebarStyleContext___ 0x1038a2400>, state: appearing, view: <_TtGC7SwiftUI14_UIHostingViewGVS_15ModifiedContentGS1_VVS_22_VariadicView_Children7ElementVS_24NavigationColumnModifier_GVS_18StyleContextWriterVS_19SidebarStyleContext___: 0x104c2f0a0>
       |    | <_TtGC7SwiftUI19UIHostingControllerVVS_7TabItem8RootView_ 0x103829000>, state: disappeared, view: (view not loaded)
    """
    
    let decoder = PrintHierarchyDecoder()
    _ = try! decoder.decodeAsNode(from: Data(string.utf8))
}

@Test
func decodeFailedCase002() async throws {
    let string = "<_TtGC7SwiftUI19UIHostingControllerV7Example11ContentView_ 0x104027800>, state: appearing, view: <_TtGC7SwiftUI14_UIHostingViewV7Example11ContentView_: 0x102f0fb30>"
    let decoder = PrintHierarchyDecoder()
    _ = try decoder.decode(line: string[...])
}

@Test
func decodeFailedCase003() async throws {
    let string = """
    <_TtGC7SwiftUI19UIHostingControllerV7Example11ContentView_ 0x106021c00>, state: appeared, view: <_TtGC7SwiftUI14_UIHostingViewV7Example11ContentView_: 0x105812080>
       | <SwiftUI.UIKitTabBarController 0x10509ba00>, state: appeared, view: <UILayoutContainerView: 0x105914650>
       |    | <_TtGC7SwiftUI19UIHostingControllerVVS_7TabItem8RootView_ 0x10508d200>, state: disappearing, view: <_TtGC7SwiftUI14_UIHostingViewVVS_7TabItem8RootView_: 0x10591b800> not in the window
       |    |    | <SwiftUI.NotifyingMulticolumnSplitViewController 0x105b10f80>, state: disappearing, view: <_UISplitViewControllerPanelImplView: 0x105c16020> not in the window
       |    |    |    | <_TtGC7SwiftUI41StyleContextSplitViewNavigationControllerVS_19SidebarStyleContext_ 0x10784ec00>, state: disappearing, view: <UILayoutContainerView: 0x10591e390> not in the window
       |    |    |    |    | <_TtGC7SwiftUI19UIHostingControllerGVS_15ModifiedContentGS1_VVS_22_VariadicView_Children7ElementVS_24NavigationColumnModifier_GVS_18StyleContextWriterVS_19SidebarStyleContext___ 0x107849600>, state: disappearing, view: <_TtGC7SwiftUI14_UIHostingViewGVS_15ModifiedContentGS1_VVS_22_VariadicView_Children7ElementVS_24NavigationColumnModifier_GVS_18StyleContextWriterVS_19SidebarStyleContext___: 0x105c11f70> not in the window
       |    | <_TtGC7SwiftUI19UIHostingControllerVVS_7TabItem8RootView_ 0x107815400>, state: appeared, view: <_TtGC7SwiftUI14_UIHostingViewVVS_7TabItem8RootView_: 0x105c08fa0>
       |    |    | <SwiftUI.NotifyingMulticolumnSplitViewController 0x105a22ad0>, state: appearing, view: <_UISplitViewControllerPanelImplView: 0x105a25080>
       |    |    |    | <_TtGC7SwiftUI41StyleContextSplitViewNavigationControllerVS_19SidebarStyleContext_ 0x1068b2a00>, state: appearing, view: <UILayoutContainerView: 0x105827310>
       |    |    |    |    | <_TtGC7SwiftUI19UIHostingControllerGVS_15ModifiedContentGS1_VVS_22_VariadicView_Children7ElementVS_24NavigationColumnModifier_GVS_18StyleContextWriterVS_19SidebarStyleContext___ 0x10685b200>, state: appearing, view: <_TtGC7SwiftUI14_UIHostingViewGVS_15ModifiedContentGS1_VVS_22_VariadicView_Children7ElementVS_24NavigationColumnModifier_GVS_18StyleContextWriterVS_19SidebarStyleContext___: 0x105a1dcb0>
    """
    let decoder = PrintHierarchyDecoder()
    _ = try decoder.decode(from: Data(string.utf8))
}

@Test
func decodeFailedCase004() throws {
    let string = "   |    | <_TtGC7SwiftUI19UIHostingControllerVVS_7TabItem8RootView_ 0x10508d200>, state: disappearing, view: <_TtGC7SwiftUI14_UIHostingViewVVS_7TabItem8RootView_: 0x10591b800> not in the window"
    let decoder = PrintHierarchyDecoder()
    _ = try decoder.decode(line: string[...])
}
