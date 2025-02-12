import SwiftUI

struct ContentView: View {
    @State
    var isComposeViewPresented: Bool = false
    
    var body: some View {
        TabView {
            homeContentView(
                createComposeAction: { isComposeViewPresented.toggle() }
            )
            .tabItem {
                Label("Home", systemImage: "house")
            }
            
            notificationContentView()
                .tabItem {
                    Label("Notifications", systemImage: "bell")
                }
        }.sheet(isPresented: $isComposeViewPresented) {
            composeContentView()
        }
    }
    
    @ViewBuilder
    func composeContentView() -> some View {
        NavigationView {
            ComposeView()
        }
    }
    
    @ViewBuilder
    func homeContentView(
        createComposeAction: @escaping () -> Void
    ) -> some View {
        NavigationView {
            Button(action: createComposeAction, label: {
                Text("New Post")
            })
        }
    }
    
    @ViewBuilder
    func notificationContentView() -> some View {
        NavigationView {
            List {
                NavigationLink {
                    Text("Hello, World!")
                } label: {
                    Text("You got a new notification")
                }
            }
        }
    }
}
