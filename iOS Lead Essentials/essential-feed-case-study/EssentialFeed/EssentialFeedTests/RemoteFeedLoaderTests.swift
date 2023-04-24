//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Gopal Gurram on 4/24/23.
//

import XCTest

class RemoteFeedLoader {

}

class HttpClient {
    var requestedURL: URL?
}

final class RemoteFeedLoaderTests: XCTestCase {

    func test_init_doesNotRequestData() {
        let client = HttpClient()
        let _ = RemoteFeedLoader()

        XCTAssertNil(client.requestedURL)
    }
}
