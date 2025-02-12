import SwiftUI

struct ComposeView: View {
    @Environment(\.dismiss)
    var dismiss
    
    var body: some View {
        Text("Compose")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                    
                }
            }
    }
}
