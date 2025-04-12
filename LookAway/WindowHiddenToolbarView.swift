import Foundation
import SwiftUI

struct WindowHiddenToolbarView<Content: View>: NSViewRepresentable {
    
    init(
        contentTopPadding: Binding<CGFloat>,
        content: @escaping () -> Content
    ) {
        _contentTopPadding = contentTopPadding
        self.content = content
    }
    
    @Binding private var contentTopPadding: CGFloat
    private let content: () -> Content
    
    func makeNSView(context: Context) -> NSView {
        // Use NSHostingView instead of NSHostingViewIgnoringSafeArea
        let hostingView = NSHostingView(rootView: content())
        
        DispatchQueue.main.async(execute: {
            if let window = hostingView.window {
                let windowFrameHeight = window.frame.height
                let contentLayoutFrameHeight = window.contentLayoutRect.height
                let titlebarHeight = windowFrameHeight - contentLayoutFrameHeight
                contentTopPadding = -titlebarHeight

                // Set the window alphaValue back to 1
                window.alphaValue = 1
            }
        })
        
        return hostingView
    }
    
    func updateNSView(_ nsView: NSViewType, context: Context) {}
}
