//
//  StoryRow.swift
//  HackerNewsBrowser
//
//  Created by Clark McCauley on 1/9/23.
//

import SwiftUI
import OpenGraph

struct StoryRowView: View {
    var item: Item;
    @State private var link: URL?;
    @State private var placeholderNeeded: Bool = false;
    
    var body: some View {
        HStack {
            AsyncImage(url: self.link) { image in
                image.resizable()
            } placeholder: {
                Rectangle().foregroundColor(.gray)
            }
            .scaledToFill()
            .frame(width: 50, height: 50)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .padding(5)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(item.title!).font(.headline)
                // Text("by \(item.by!) \(item.timeAgo)").font(.subheadline)
                AuthorTimestampView(author: item.by!, timestamp: item.time!, variant: .caption)
                ScoreCommentsView(score: item.score!, comments: item.descendants!)
            }.onAppear {
                getThumbnailLink()
            }
        }
    }
    
    func getThumbnailLink() {
        if item.url != nil {
            OpenGraph.fetch(url: item.url!) { result in
                switch result {
                case .success(let og):
                    if og[.image] != nil {
                        let url = URL(string: og[.image]!)
                        if url != nil {
                            self.link = URL(string: og[.image]!)!
                        }
                    }
                default:
                    self.placeholderNeeded = true
                    return
                }
            }
        }
    }
}

struct StoryRow_Previews: PreviewProvider {
    static var previews: some View {
        StoryRowView(
            item: Item(id: 0, deleted: false, type: .story, by: "dhouston", time: .infinity, text: nil, dead: false, parent: nil, kids: [ 8952, 9224, 8917, 8884, 8887, 8943, 8869, 8958, 9005, 9671, 8940, 9067, 8908, 9055, 8865, 8881, 8872, 8873, 8955, 10403, 8903, 8928, 9125, 8998, 8901, 8902, 8907, 8894, 8878, 8870, 8980, 8934, 8876 ], url: URL(string: "http://www.getdropbox.com/u/2/screencast.html")!, score: 111, title: "My YC app: Dropbox - Throw away your USB drive", parts: nil, descendants: 71)
        )
    }
}
