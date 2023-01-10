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

extension String {

    init?(htmlEncodedString: String) {

        guard let data = htmlEncodedString.data(using: .utf8) else {
            return nil
        }

        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]

        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return nil
        }

        self.init(attributedString.string)

    }

}
