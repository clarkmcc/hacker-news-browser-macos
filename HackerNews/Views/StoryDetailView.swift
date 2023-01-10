//
//  StoryDetailView.swift
//  HackerNewsBrowser
//
//  Created by Clark McCauley on 1/9/23.
//

import SwiftUI

struct StoryDetailView: View {
    var story: Story
    @State private var comments: [Comment] = [];
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(story.title).font(.headline)
            Text(story.url.absoluteString).font(.caption).foregroundColor(.blue)
            Text("by \(story.by) \(story.timeAgo)").font(.caption)
            
            HStack {
                // Likes
                HStack {
                    Image(systemName: "arrowtriangle.up.fill")
                    Text("\(story.score)").fontWeight(.heavy)
                }.padding(.trailing, 10)
                
                // Comments
                HStack {
                    Image(systemName: "message.fill")
                    Text("\(story.descendants)").fontWeight(.heavy)
                }
            }
            
            Divider().padding([.top, .bottom], 10)
            
            List(comments) {comment in
                CommentView(comment: comment)
            }.listStyle(.inset)
//            ForEach(comments) { comment in
                
//            }
            Spacer()
        }
        .padding(20)
        .onAppear {
            loadComments()
        }
    }
    
    func loadComments() {
        story.kids.forEach { id in
            HackerNewsClient.fetchItem(id: id) { item in
                if let item = item {
                    self.comments.append(item.toComment());
                }
            }
        }
    }
}

struct StoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StoryDetailView(story: Story(id: 0, deleted: false, by: "clarkmcc", time: TimeInterval(), text: "This is the text of the story", dead: false, kids: [ 8952, 9224, 8917, 8884, 8887, 8943, 8869, 8958, 9005, 9671, 8940, 9067, 8908, 9055, 8865, 8881, 8872, 8873, 8955, 10403, 8903, 8928, 9125, 8998, 8901, 8902, 8907, 8894, 8878, 8870, 8980, 8934, 8876 ], url: URL(string: "https://github.com/HackerNews/API")!, score: 1680, title: "This is the title of the story", descendants: 20))
    }
}
