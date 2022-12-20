//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Gopal Gurram on 12/17/22.
//

import Foundation

public final class RemoteFeedLoader {
    private let url: URL
    private let client: HttpClient
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public init(url: URL, client: HttpClient) {
        self.url = url
        self.client = client
    }
    
    public func load(completion: @escaping (Error) -> Void) {
        client.get(from: url) { result in
            let loadResult: Error
            
            defer {
                completion(loadResult)
            }
            
            switch result {
            case .success(_):
                loadResult = .invalidData
            case .failure(_):
                loadResult = .connectivity
            }
        }
    }
}

public protocol HttpClient {
    func get(from url: URL, completion: @escaping (Result<HTTPURLResponse, Error>) -> Void)
}
