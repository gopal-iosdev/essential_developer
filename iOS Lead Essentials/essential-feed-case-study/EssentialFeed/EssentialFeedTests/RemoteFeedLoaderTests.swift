//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Gopal Gurram on 4/24/23.
//

import XCTest

class RemoteFeedLoader {
    let url: URL
    let client: HTTPClient

    init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }

    func load() {
        client.get(from: url)
    }
}

protocol HTTPClient {
    func get(from url: URL)
}

class HTTPClientSpy: HTTPClient {
    var requestedURL: URL?

    func get(from url: URL) {
        requestedURL = url
    }
}

final class RemoteFeedLoaderTests: XCTestCase {

    func test_init_doesNotRequestDataFromURL() {
        let client = HTTPClientSpy()
        _ = RemoteFeedLoader(url: URL(string: "https://a-url.com")!, client: client)

        XCTAssertNil(client.requestedURL)
    }

    func test_init_requestDataFromURL() {
        let client = HTTPClientSpy()
        let url = URL(string: "https://a-given-url.com")!
        let sut = RemoteFeedLoader(url: url, client: client)

        sut.load()

        XCTAssertEqual(client.requestedURL, url)
    }
}
