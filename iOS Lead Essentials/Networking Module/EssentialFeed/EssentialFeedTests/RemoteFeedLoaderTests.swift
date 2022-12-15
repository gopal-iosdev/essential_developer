//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Gopal Gurram on 12/14/22.
//

import XCTest

class RemoteFeedLoader {
    func load() {
        HttpClient.shared.requestedURL = URL(string: "https://a-url.com")
    }
}

class HttpClient {
    static let shared = HttpClient()
    
    var requestedURL: URL?
    
    private init() {}
}

final class RemoteFeedLoaderTests: XCTestCase {
    
    func test_init_doesNotRequestDataFromURL() {
        let client = HttpClient.shared
        _ = RemoteFeedLoader()
        
        XCTAssertNil(client.requestedURL)
    }
    
    func test_load_requestDataFromURL() {
        let client = HttpClient.shared
        let sut = RemoteFeedLoader()
        
        sut.load()
        
        XCTAssertNotNil(client.requestedURL)
    }
    
}
