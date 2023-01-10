//
//  HackerNewsApp.swift
//  HackerNews
//
//  Created by Clark McCauley on 1/8/23.
//

import SwiftUI

@main
struct HackerNewsApp: App {
    var body: some Scene {
        WindowGroup {
            #if os(macOS)
            SidebarView()
            #else
            ContentView()
            #endif
        }
    }
}
