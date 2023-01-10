//
//  AuthorTimestampView.swift
//  HackerNewsBrowser
//
//  Created by Clark McCauley on 1/9/23.
//

import SwiftUI

enum AuthorTimestampVariant {
    case caption
    case subtitle
}

struct AuthorTimestampView: View {
    var author: String;
    var timestamp: TimeInterval
    var variant: AuthorTimestampVariant
    
    var body: some View {
        HStack(spacing: 5) {
            switch variant {
            case .caption:
                Text(author).font(.caption)
                Image(systemName: "circle.fill").resizable().frame(width: 4, height: 4)
                Text(getTimeAgo(timestamp)).font(.caption)
            case .subtitle:
                Text(author).bold()
                Image(systemName: "circle.fill").resizable().frame(width: 6, height: 6)
                Text(getTimeAgo(timestamp)).bold()
            }        }
    }
}

func getTimeAgo(_ time: TimeInterval) -> String {
    let formatter = RelativeDateTimeFormatter()
    formatter.unitsStyle = .full
    let date = Date(timeIntervalSince1970: time)
    return formatter.localizedString(for: date, relativeTo: Date())
}


struct AuthorTimestampView_Previews: PreviewProvider {
    static var previews: some View {
        AuthorTimestampView(author: "clarkmcc", timestamp: TimeInterval(), variant: .caption)
        AuthorTimestampView(author: "clarkmcc", timestamp: TimeInterval(), variant: .subtitle)
    }
}
