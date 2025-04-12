//
//  WindowHiddenToolbarModifier.swift
//  LookAway
//
//  Created by Bora Mert on 6.04.2025.
//

import Foundation
import SwiftUI

struct WindowHiddenToolbarModifier: ViewModifier {

    @State
    private var contentTopPadding: CGFloat = 0

    @ViewBuilder
    func body(content: Content) -> some View {
        if #available(macOS 15.0, *) {
            WindowHiddenToolbarView(
                contentTopPadding: $contentTopPadding,
                content: { content }
            )
            .toolbarVisibility(.hidden, for: .windowToolbar)
            .padding(.top, contentTopPadding)
        } else {
            // Fallback on earlier versions: simply return the view without modifying toolbar visibility
            WindowHiddenToolbarView(
                contentTopPadding: $contentTopPadding,
                content: { content }
            )
            .padding(.top, contentTopPadding)
        }
    }
}

extension View {

    func windowToolbarHidden() -> some View {
        modifier(WindowHiddenToolbarModifier())
    }
}
