//
//  URLSessionHTTPClientTests.swift
//  EssentialFeedTests
//
//  Created by Gopal Gurram on 7/30/23.
//

import XCTest
import EssentialFeed

class URLSessionHTTPClient {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    struct UnexpectedValuesRepresentation: Error {}

    func get(from url: URL, completion: @escaping(HTTPClientResult) -> Void) {
        session.dataTask(with: url) { data, response, error in
            if let error {
                completion(.failure(error))
            } else if let data, !data.isEmpty, let response = response as? HTTPURLResponse {
                completion(.success(data, response))
            } else {
                completion(.failure(UnexpectedValuesRepresentation()))
            }
        }.resume()
    }
}

final class URLSessionHTTPClientTests: XCTestCase {

    override func setUp() {
        super.setUp()

        URLProtocolStub.startInterceptingRequests()
    }

    override func tearDown() {
        super.tearDown()

        URLProtocolStub.stopInterceptingRequests()
    }

    func test_getFromURL_performsGETRequestWithURL() {
        let url = URL.anyURL
        let exp = expectation(description: "Wait for request")

        URLProtocolStub.observeRequests { request in
            XCTAssertEqual(request.url, url)
            XCTAssertEqual(request.httpMethod, "GET")
            exp.fulfill()
        }

        makeSUT().get(from: url) { _ in }

        wait(for: [exp], timeout: 1.0)
    }

    func test_getFromURL_failsOnRequestError() {
        let requestError = NSError.anyError

        let recievedError = resultErrorFor(data: nil, response: nil, error: requestError) as NSError?

        XCTAssertEqual(recievedError?.domain, requestError.domain)
        XCTAssertEqual(recievedError?.code, requestError.code)
    }

    func test_getFromURL_failsOnAllInvalidRepresentationCases() {
        let nonHTTPURLResponse = URLResponse.nonHTTPURLResponse
        let anyHTTPURLResponse = HTTPURLResponse.anyHTTPURLResponse
        let anyData = Data.anyData
        let anyError = NSError.anyError

        XCTAssertNotNil(resultErrorFor(data: nil, response: nil, error: nil))
        XCTAssertNotNil(resultErrorFor(data: nil, response: nonHTTPURLResponse, error: nil))
        XCTAssertNotNil(resultErrorFor(data: nil, response: anyHTTPURLResponse, error: nil))
        XCTAssertNotNil(resultErrorFor(data: anyData, response: nil, error: nil))
        XCTAssertNotNil(resultErrorFor(data: anyData, response: nil, error: anyError))
        XCTAssertNotNil(resultErrorFor(data: nil, response: nonHTTPURLResponse, error: anyError))
        XCTAssertNotNil(resultErrorFor(data: nil, response: anyHTTPURLResponse, error: anyError))
        XCTAssertNotNil(resultErrorFor(data: anyData, response: nonHTTPURLResponse, error: anyError))
        XCTAssertNotNil(resultErrorFor(data: anyData, response: anyHTTPURLResponse, error: anyError))
        XCTAssertNotNil(resultErrorFor(data: anyData, response: nonHTTPURLResponse, error: nil))
    }

    func test_getFromURL_suceedsOnHTTPURLResponseWithData() {
        let data = Data.anyData
        let response = HTTPURLResponse.anyHTTPURLResponse
        URLProtocolStub.stub(data: data, response: response, error: nil)

        let exp = expectation(description: "Wait for completion")
        makeSUT().get(from: URL.anyURL) { result in
            switch result {
            case let .success(receivedData, receivedResponse):
                XCTAssertEqual(receivedData, data)
                XCTAssertEqual(receivedResponse.url, response?.url)
                XCTAssertEqual(receivedResponse.statusCode, response?.statusCode)
            default:
                XCTFail("Excpected success, got \(result) instead")
            }

            exp.fulfill()
        }

        wait(for: [exp], timeout: 1.0)
    }

    // MARK: - Helpers

    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> URLSessionHTTPClient {
        let sut = URLSessionHTTPClient()
        trackMemoryLeaks(sut)
        return sut
    }

    private func resultErrorFor(data: Data?, response: URLResponse?, error: Error?, file: StaticString = #filePath, line: UInt = #line) -> Error? {
        URLProtocolStub.stub(data: data, response: response, error: error)

        let sut = makeSUT(file: file, line: line)
        let exp = expectation(description: "Wait for completion")

        var receivedError: Error?
        sut.get(from: URL.anyURL) { result in
            switch result {
            case let .failure(error):
                receivedError = error
            default:
                XCTFail("Expected failure, got \(result) instead.", file: file, line: line)
            }

            exp.fulfill()
        }

        wait(for: [exp], timeout: 1.0)

        return receivedError
    }

    private class URLProtocolStub: URLProtocol {
        private static var stub: Stub?
        private static var requestObserver: ((URLRequest) -> (Void))?

        private struct Stub {
            let data: Data?
            let response: URLResponse?
            let error: Error?
        }

        static func stub(data: Data?, response: URLResponse?, error: Error?) {
            stub = Stub(data: data, response: response, error: error)
        }

        static func startInterceptingRequests() {
            URLProtocol.registerClass(URLProtocolStub.self)
        }

        static func stopInterceptingRequests() {
            URLProtocol.unregisterClass(URLProtocolStub.self)
            stub = nil
            requestObserver = nil
        }

        override class func canInit(with request: URLRequest) -> Bool {
            requestObserver?(request)
            return true
        }

        override class func canonicalRequest(for request: URLRequest) -> URLRequest {
            request
        }

        override func startLoading() {
            guard let stub = Self.stub
            else { return }

            if let data = stub.data {
                client?.urlProtocol(self, didLoad: data)
            }

            if let response = stub.response {
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            }

            if let error = stub.error {
                client?.urlProtocol(self, didFailWithError: error)
            }

            client?.urlProtocolDidFinishLoading(self)
        }

        static func observeRequests(observer: @escaping (URLRequest) -> (Void)) {
            requestObserver = observer
        }

        override func stopLoading() {

        }
    }
}

private extension URL {
    static let anyURL = URL(string: "https://any-url.com")!
}

private extension URLResponse {
    static let nonHTTPURLResponse = URLResponse(url: URL.anyURL, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
}

private extension HTTPURLResponse {
    static let anyHTTPURLResponse = HTTPURLResponse(url: URL.anyURL, statusCode: 200, httpVersion: nil, headerFields: nil)

}

private extension Data {
    static let anyData = Data("any data".utf8)
}

private extension NSError {
    static let anyError = NSError(domain: "any error", code: 0)
}
