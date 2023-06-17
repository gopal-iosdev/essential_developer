//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Gopal Gurram on 4/15/23.
//

import Foundation

public enum LoadFeedResult<Error: Swift.Error> {
    case success([FeedItem])
    case failure(Error)
}

extension LoadFeedResult: Equatable where Error: Equatable {}

protocol FeedLoader {
    associatedtype Error: Swift.Error

    func load(_ completion: @escaping (LoadFeedResult<Error>) -> (Void))
}
