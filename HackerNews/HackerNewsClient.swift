//
//  HackerNewsClient.swift
//  HackerNewsBrowser
//
//  Created by Clark McCauley on 1/9/23.
//

import Foundation
import LinkPresentation

enum StorySortType {
    case top
    case best
    case new
}

struct HackerNewsClient {
    private static let baseURL = "https://hacker-news.firebaseio.com/v0"
    
    static func fetchStories(type: StorySortType, limit: Int, completion: @escaping ([Int]?) -> Void) {
        let url = URL(string: "\(baseURL)/\(HackerNewsClient.getStoriesPath(type))")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
                completion(nil)
                return
            }
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            let stories = try? JSONDecoder().decode([Int].self, from: data)
            if let stories = stories {
                let limitedStories = Array(stories.prefix(limit))
                completion(limitedStories)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    static func fetchItem(id: Int, completion: @escaping (Item?) -> Void) {
        let url = URL(string: "\(baseURL)/item/\(id).json")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
                completion(nil)
                return
            }
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            let item = try? JSONDecoder().decode(Item.self, from: data)
            completion(item)
        }
        task.resume()
    }
    
    private static func getStoriesPath(_ type: StorySortType) -> String {
        switch type {
        case .top:
            return "topstories.json"
        case .new:
            return "newstories.json"
        case .best:
            return "beststories.json"
        }
    }
}

struct Item: Codable, Identifiable {
    let id: Int
    let deleted: Bool?
    let type: ItemType
    let by: String?
    let time: TimeInterval?
    let text: String?
    let dead: Bool?
    let parent: Int?
    let kids: [Int]?
    let url: URL?
    let score: Int?
    let title: String?
    let parts: [Int]?
    let descendants: Int?
    
    /// Returns the time formatted in a time-ago format like "3 hours ago".
    var timeAgo: String {
        return getTimeAgo(time: self.time!)
    }
    
    func toStory() -> Story {
        return Story(
            id: self.id,
            deleted: self.deleted ?? false,
            by: self.by!,
            time: self.time!,
            text: self.text ?? "",
            dead: self.dead ?? false,
            kids: self.kids ?? [],
            url: self.url!,
            score: self.score!,
            title: self.title!,
            descendants: self.descendants ?? 0
        )
    }
    
    func toComment() -> Comment {
        return Comment(
            id: self.id,
            deleted: self.deleted ?? false,
            by: self.by ?? "",
            time: self.time!,
            text: self.text ?? "",
            dead: self.dead ?? false,
            kids: self.kids ?? [],
            score: self.score ?? 0,
            descendants: self.descendants ?? 0
        )
    }
}

enum ItemType: String, Codable {
    case job
    case story
    case comment
    case poll
    case pollopt
}

struct Story {
    let id: Int
    let deleted: Bool
    let by: String
    let time: TimeInterval
    let text: String
    let dead: Bool
    let kids: [Int]
    let url: URL
    let score: Int
    let title: String
    let descendants: Int
    
    var timeAgo: String {
        return getTimeAgo(time: self.time)
    }
    
    var metadata: LPLinkMetadata {
        var metadata = LPLinkMetadata();
        metadata.originalURL = self.url;
        return metadata
    }
}

struct Comment: Identifiable {
    let id: Int
    let deleted: Bool
    let by: String
    let time: TimeInterval
    let text: String
    let dead: Bool
    let kids: [Int]
    let score: Int
    let descendants: Int
    
    var timeAgo: String {
        return getTimeAgo(time: self.time)
    }
    
    func onChildComment(completion: @escaping (Comment) -> Void) {
        if self.kids.count > 0 {
            for id in self.kids {
                HackerNewsClient.fetchItem(id: id) {item in
                    if let item = item {
                        completion(item.toComment())
                    }
                }
            }
        }
    }
}

func getTimeAgo(time: TimeInterval) -> String {
    let formatter = RelativeDateTimeFormatter()
    formatter.unitsStyle = .full
    let date = Date(timeIntervalSince1970: time)
    return formatter.localizedString(for: date, relativeTo: Date())
}
