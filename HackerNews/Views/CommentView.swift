//
//  CommentView.swift
//  HackerNewsBrowser
//
//  Created by Clark McCauley on 1/9/23.
//

import SwiftUI

struct CommentView: View {
    var comment: Comment
    var load = true
    @State private var comments: [Comment] = []
    @State private var appeared = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text("\(comment.by) \(comment.timeAgo)").font(.caption)
            Text("\(comment.text)")
            
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
            }.padding(.bottom, 20)
            
            if load && comments.count > 0 {
                HStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 3, height: .infinity)
                        .foregroundColor(.accentColor)
                        .opacity(0.3)
                    VStack(alignment: .leading, spacing: 20) {
                        ForEach(comments) { comment in
                            CommentView(comment: comment, load: true)
                        }
                    }
                }
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
        CommentView(comment: Comment(id: 0, deleted: false, by: "clarkmcc", time: TimeInterval(), text: "This is a comment about a story that I really like. It has multiple sentances so that we can see what more text looks like what it wraps. This is the end, and I don't have much more to say than this.", dead: false, kids: [], score: 25, descendants: 0))
    }
}
