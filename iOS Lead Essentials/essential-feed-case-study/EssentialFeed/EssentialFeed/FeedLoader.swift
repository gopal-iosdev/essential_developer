//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Gopal Gurram on 4/15/23.
//

import Foundation

enum LoadFeedResult {
    case success([FeedItem])
    case error(Error)
}

protocol FeedLoader {
    func load(_ completion: @escaping (LoadFeedResult) -> (Void))
}
