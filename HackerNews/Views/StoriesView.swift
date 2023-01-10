//
//  StoriesView.swift
//  HackerNewsBrowser
//
//  Created by Clark McCauley on 1/9/23.
//

import SwiftUI

struct StoriesView: View {
    var type: StorySortType
    
    @State var stories: [Item] = []
    @State var loading: Bool = false;
    @State var progress: Double = 0;
    
    var body: some View {
        VStack {
            if self.loading {
                ProgressView(value: progress).backgroundStyle(.white)
            }
            List(stories) { item in
                NavigationLink(destination: StoryDetailView(story: item.toStory())) {
                    StoryRowView(item: item)
                }.padding(.bottom, 5)
            }.onAppear {
                loadStories()
            }
        }
    }
    
    func loadStories() {
        self.loading = true;
        var loaded = 0;
        HackerNewsClient.fetchStories(type: type, limit: 25) { ids in
            if ids != nil {
                let totalStories = ids?.count ?? 0;
                ids!.forEach { id in
                    HackerNewsClient.fetchItem(id: id) { item in
                        if item != nil && item?.url != nil {
                            stories.append(item!)
                        }
                        loaded += 1
                        self.progress = Double(loaded) / Double(totalStories)
                    }
                }
            }
        }
        self.loading = false
    }
}

struct StoriesView_Previews: PreviewProvider {
    static var previews: some View {
        StoriesView(type: .top)
    }
}
