//
//  LookAwayApp.swift
//  LookAway
//
//  Created by Bora Mert on 4.04.2025.
//

// TODO: Fix app icon. Try to push to app store.

import SwiftUI
import Foundation
import ObjectiveC.runtime

@main
struct LookAwayApp: App {
    @Environment(\.scenePhase) var scenePhase
    @StateObject var sessionManager = SessionManager()
    
    var body: some Scene {
        MenuBarExtra {
            ContentView()
                .environmentObject(sessionManager)
                .background(MenuBarExtraWindowHelperView())
        } label: {
            MenuBarIconView()
                .environmentObject(sessionManager)
        }
        .menuBarExtraStyle(.window)
        
        WindowGroup("Settings", id: "settings") {
            SettingsView()
                .frame(width: 400, height: 350)
        }
        .handlesExternalEvents(matching: Set(arrayLiteral: "settings"))
        .windowResizability(.contentSize)
        
        WindowGroup("Break", id: "break") {
            BreakView()
                .frame(width: 400)
                .onReceive(NotificationCenter.default.publisher(for: NSApplication.willUpdateNotification)) { _ in
                    hideWindowButtons()
                }
        }
        .handlesExternalEvents(matching: Set(arrayLiteral: "break"))
        .windowResizability(.contentSize)
    }
    
    func hideWindowButtons() {
        for window in NSApplication.shared.windows {
            // Only target windows hosting the BreakView
            if window.contentViewController is NSHostingController<BreakView> {
                window.standardWindowButton(.closeButton)?.isHidden = true
                window.standardWindowButton(.miniaturizeButton)?.isHidden = true
                window.standardWindowButton(.zoomButton)?.isHidden = true
            }
        }
    }
}

var __SwiftUIMenuBarExtraPanel___cornerMask__didExchange = false
fileprivate let kWindowCornerRadius: CGFloat = 20

extension NSObject {
    static func exchange(method: String, in className: String, for newMethod: String) {
        guard let classRef = objc_getClass(className) as? AnyClass,
              let original = class_getInstanceMethod(classRef, Selector((method))),
              let replacement = class_getInstanceMethod(self, Selector((newMethod)))
        else {
            fatalError("Could not exchange method \(method) on class \(className).")
        }

        method_exchangeImplementations(original, replacement)
    }

    @objc func __SwiftUIMenuBarExtraPanel___cornerMask() -> NSImage? {
        let width = kWindowCornerRadius * 2
        let height = kWindowCornerRadius * 2
        let image = NSImage(size: CGSize(width: width, height: height))
        image.lockFocus()
        NSColor.black.setFill()
        NSBezierPath(
            roundedRect: CGRect(x: 0, y: 0, width: width, height: height),
            xRadius: kWindowCornerRadius,
            yRadius: kWindowCornerRadius).fill()
        image.unlockFocus()
        image.capInsets = NSEdgeInsets(
            top: kWindowCornerRadius,
            left: kWindowCornerRadius,
            bottom: kWindowCornerRadius,
            right: kWindowCornerRadius)
        return image
    }
}

struct MenuBarExtraWindowHelperView: NSViewRepresentable {
    class WindowHelper: NSView {
        override func viewWillDraw() {
            if __SwiftUIMenuBarExtraPanel___cornerMask__didExchange { return }
            
            guard let window = self.window else { return }

            NSObject.exchange(
                method: "_cornerMask",
                in: window.className,
                for: "__SwiftUIMenuBarExtraPanel___cornerMask")
            
            _ = window.perform(Selector(("_cornerMaskChanged")))
            __SwiftUIMenuBarExtraPanel___cornerMask__didExchange = true
        }
    }

    func makeNSView(context: Context) -> WindowHelper { WindowHelper() }
    func updateNSView(_ nsView: WindowHelper, context: Context) { }
}

extension Notification.Name {
    static let breakEnded = Notification.Name("breakEnded")
}
