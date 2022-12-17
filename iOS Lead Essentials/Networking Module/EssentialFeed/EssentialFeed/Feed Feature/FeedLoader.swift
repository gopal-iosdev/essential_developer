//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Gopal Gurram on 12/14/22.
//

import Foundation

enum LoadFeedResult {
    case success([FeedItem])
    case error(Error)
}

protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
