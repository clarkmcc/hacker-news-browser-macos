//
//  StoryDetailView.swift
//  HackerNewsBrowser
//
//  Created by Clark McCauley on 1/9/23.
//

import SwiftUI
import LinkPresentation


struct StoryDetailView: View {
    var story: Story
    @State private var comments: [Comment] = [];
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            // Title
            Text(story.title)
                .fontWeight(.black)
                .font(.system(.title, design: .rounded))
    
            // Link
            Link(destination: story.url, label: {
                Text(story.url.absoluteString).font(.caption).foregroundColor(.blue)
            })
            
            // Author and timestamp
            AuthorTimestampView(author: story.by, timestamp: story.time, variant: .subtitle)
            
            // Scorecard
            ScoreCommentsView(score: story.score, comments: story.descendants)
            
            Divider().padding([.top], 10)
            
            // Comments
            List(comments) {comment in
                CommentView(comment: comment, storyAuthor: story.by)
            }
        }
        .padding([.leading, .trailing, .top], 20)
        .onAppear {
            loadComments()
        }
//        .edgesIgnoringSafeArea(.all)
        .background(Color.white)
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
