//: [Previous](@previous)

/*
 Source: https://academy.essentialdeveloper.com/courses/447455/lectures/8484976
 
 Section: Video Lecture
 
 */

import UIKit

protocol FeedLoader {
    func loadFeed(completion: @escaping ([String]) -> Void)
}

class FeedViewController: UIViewController {
    var loader: FeedLoader!
    
    convenience init(loader: FeedLoader) {
        self.init()
        
        self.loader = loader
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loader.loadFeed { feedItems in
            // update UI
        }
    }
}

class RemoteFeedLoader: FeedLoader {
    func loadFeed(completion: @escaping ([String]) -> Void) {
        completion([String]())
    }
}

class LocalFeedLoader: FeedLoader {
    func loadFeed(completion: @escaping ([String]) -> Void) {
        completion([String]())
    }
}

struct Reachability {
    static let networkAvailable = false
}

class RemoteWithFallbackLocalFeedLoader: FeedLoader {
    let remote: RemoteFeedLoader
    let local: LocalFeedLoader
    
    init(remote: RemoteFeedLoader, local: LocalFeedLoader) {
        self.remote = remote
        self.local = local
    }
    
    func loadFeed(completion: @escaping ([String]) -> Void) {
        let load = Reachability.networkAvailable ? remote.loadFeed : local.loadFeed
        
        load(completion)
    }
}

//: [Next](@next)
