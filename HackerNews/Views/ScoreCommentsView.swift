//
//  ScoreCommentsView.swift
//  HackerNewsBrowser
//
//  Created by Clark McCauley on 1/9/23.
//

import SwiftUI

struct ScoreCommentsView: View {
    var score: Int = 0;
    var comments: Int = 0;
    
    var body: some View {
        HStack {
            // Likes
            HStack {
                Image(systemName: "arrow.up")
                Text("\(score)").fontWeight(.heavy)
            }
            
            Image(systemName: "circle.fill").resizable().frame(width: 6, height: 6)
            
            // Comments
            HStack {
                Image(systemName: "bubble.right.fill")
                Text("\(comments)").fontWeight(.heavy)
            }
        }
    }
}

struct ScoreCommentsView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreCommentsView(score: 1452, comments: 320)
    }
}
