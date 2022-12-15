//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Gopal Gurram on 12/14/22.
//

import XCTest

class RemoteFeedLoader {
    
}

class HttpClient {
    var requestedURL: URL?
}

final class RemoteFeedLoaderTests: XCTestCase {
    
    func test_init_doesNotRequestDataFromURL() {
        let client = HttpClient()
        _ = RemoteFeedLoader()
        
        XCTAssertNil(client.requestedURL)
    }
    
}
