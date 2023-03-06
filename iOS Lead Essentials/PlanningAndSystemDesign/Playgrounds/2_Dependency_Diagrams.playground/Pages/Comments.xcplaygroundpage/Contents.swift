//: [Previous](@previous)

/*
 Source: https://academy.essentialdeveloper.com/courses/447455/lectures/8484976
 
 Section: Comments
 
 */

import UIKit


// MARK: - Composition

/*

struct FeedItem {}

protocol FeedLoader {
    func loadFeed(_ completion: (FeedItem) -> Void)
}

struct RemoteFeedLoader: FeedLoader {
    func loadFeed(_ completion: (FeedItem) -> Void) {
        // Fetching feed data from remote server
        completion(FeedItem())
    }
}

struct LocalFeedLoader: FeedLoader {
    func loadFeed(_ completion: (FeedItem) -> Void) {
        // Fetching feed data from local cache
        completion(FeedItem())
    }
}

// Before

class FeedViewController: UIViewController {
    var remote: RemoteFeedLoader!
    var local: LocalFeedLoader!
    
    convenience init(remote: RemoteFeedLoader, local: LocalFeedLoader) {
        self.init()
        
        self.remote = remote
        self.local = local
    }
}

// After, with Composition => we moved the composition out of the FeedViewController into a new component, the RemoteWithLocalFallbackLoader.

class FeedViewControllerNew: UIViewController {
    var loader: FeedLoader!
    
    convenience init(loader: FeedLoader) {
        self.init()
        
        self.loader = loader
    }
}

class RemoteWithLocalFallbackLoader: FeedLoader {
    let remote: RemoteFeedLoader
    let local: LocalFeedLoader
    
    init(remote: RemoteFeedLoader, local: LocalFeedLoader) {
        self.remote = remote
        self.local = local
    }
    
    func loadFeed(_ completion: (FeedItem) -> Void) {
        completion(FeedItem())
    }
}
 
 */

// MARK: - Using Closures instead of protocols

/*

struct Reachability {
    static let networkAvailable = false
}

typealias FeedLoader = (@escaping ([String]) -> Void) -> Void

class FeedViewController: UIViewController {

    var loader: FeedLoader!

    convenience init(loader: @escaping FeedLoader) {
        self.init()
        self.loader = loader
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loader { loadedItems in
            // update UI
        }
    }
}

class RemoteFeedLoader {
    
    func load(completion: @escaping ([String]) -> Void) {
        // do something
    }
}

class LocalFeedLoader {
    
    func load(completion: @escaping ([String]) -> Void) {
        // do something
    }
}

class RemoteWithLocalFallbackFeedLoader {
    
    var remoteFeedLoader: RemoteFeedLoader!
    var localFeedLoader: LocalFeedLoader!
    
    init(remoteFeedLoader: RemoteFeedLoader, localFeedLoader: LocalFeedLoader) {
        self.remoteFeedLoader = remoteFeedLoader
        self.localFeedLoader = localFeedLoader
    }
    
    func load(completion: @escaping ([String]) -> Void) {
        let load = Reachability.networkAvailable ? remoteFeedLoader.load : localFeedLoader.load
        load(completion)
    }
}

let loader = RemoteWithLocalFallbackFeedLoader(remoteFeedLoader: RemoteFeedLoader(), localFeedLoader: LocalFeedLoader()).load

let vc = FeedViewController(loader: loader)
 
 */

//: [Next](@next)
