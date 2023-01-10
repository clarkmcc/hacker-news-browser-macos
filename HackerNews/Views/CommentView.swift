//
//  CommentView.swift
//  HackerNewsBrowser
//
//  Created by Clark McCauley on 1/9/23.
//

import SwiftUI

struct CommentView: View {
    var comment: Comment
    var storyAuthor: String?;
    @State private var comments: [Comment] = []
    @State private var appeared = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            HStack {
                if let author = storyAuthor, comment.by == author {
                    Rectangle()
                        .opacity(0)
                        .frame(width: 25, height: 16)
                        .background(Color.accentColor)
                        .overlay {
                            Text("OP")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                        .cornerRadius(4)
                }
                AuthorTimestampView(author: comment.by, timestamp: comment.time, variant: .caption)
                    .foregroundColor(.gray)
            }
            Text("\(String(htmlEncodedString: comment.text)!)")
                    
            HStack {
                // Likes
                HStack {
                    Image(systemName: "arrowtriangle.up.fill")
                    Text("\(comment.score)").fontWeight(.heavy)
                }.padding(.trailing, 10)
                
                // Comments
                HStack {
                    Image(systemName: "message.fill")
                    Text("\(comment.kids.count)").fontWeight(.heavy)
                }
            }.padding(.bottom, 10)
            
            if comments.count > 0 {
//                HStack {
//                    RoundedRectangle(cornerRadius: 10)
//                        .frame(width: 3, height: .infinity)
//                        .foregroundColor(.gray)
//                        .opacity(0.3)
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(comments) { comment in
                            CommentView(comment: comment, storyAuthor: storyAuthor)
                        }
                    }.padding(.leading, 10)
//                }
            }
        }.onAppear {
            if !self.appeared {
                comment.onChildComment { comment in
                    self.comments.append(comment)
                }
                self.appeared = true
            }
        }
    }
}

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView(comment: Comment(id: 0, deleted: false, by: "clarkmcc", time: TimeInterval(), text: "This is a comment about a story that I really like. It has multiple sentances so that we can see what more text looks like what it wraps. This is the end, and I don't have much more to say than this.", dead: false, kids: [], score: 25, descendants: 0), storyAuthor: "clarkmcc")
    }
}
