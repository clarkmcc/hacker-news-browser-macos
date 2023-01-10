//
//  Sidebar.swift
//  HackerNews
//
//  Created by Clark McCauley on 1/8/23.
//

import SwiftUI

struct SidebarView: View {
    @State private var selectedView: Int? = 0
    
    var body: some View {
        NavigationView {
            List {
                //Caption
                Text("News")
                //Navigation links
                Group{
                    NavigationLink(destination: StoriesView(type: .top), tag: 0, selection: self.$selectedView) {
                        Label("Top Stories", systemImage: "newspaper")
                    }
                    NavigationLink(destination: StoriesView(type: .best), tag: 1, selection: self.$selectedView) {
                        Label("Best Stories", systemImage: "star")
                    }
                    NavigationLink(destination: StoriesView(type: .new), tag: 2, selection: self.$selectedView) {
                        Label("New Stories", systemImage: "flame")
                    }
                    NavigationLink(destination: ContentView(), tag: 3, selection: self.$selectedView) {
                        Label("Ask HN", systemImage: "bubble.left.and.bubble.right")
                    }
                    NavigationLink(destination: ContentView(), tag: 4, selection: self.$selectedView) {
                        Label("Show HN", systemImage: "play")
                    }
                    NavigationLink(destination: ContentView(), tag: 5, selection: self.$selectedView) {
                        Label("Jobs", systemImage: "briefcase")
                    }
                }
                //Add some space :)
//                Spacer()
//                Text("More")
//                NavigationLink(destination: ContentView()) {
//                    Label("Shortcut", systemImage: "option")
//                }
//                NavigationLink(destination: ContentView()) {
//                    Label("Customize", systemImage: "slider.horizontal.3")
//                }
                //Add some space again!
//                Spacer()
//                //Divider also looks great!
//                Divider()
//                NavigationLink(destination: SettingsView()) {
//                    Label("Settings", systemImage: "gear")
//                }
            }
            .listStyle(SidebarListStyle())
            .navigationTitle("Explore")
            //Set Sidebar Width (and height)
            .frame(minWidth: 150, idealWidth: 250, maxWidth: 300)
            .toolbar{
                //Toggle Sidebar Button
                ToolbarItem(placement: .navigation){
                    Button(action: toggleSidebar, label: {
                        Image(systemName: "sidebar.left")
                    })
                }
            }
            //Default View on Mac
            ContentView()
            
            Text("Select something")
        }
    }
}

// Toggle Sidebar Function
func toggleSidebar() {
        NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
}

struct SidebarView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarView()
    }
}
