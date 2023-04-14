//: [Previous](@previous)

/*
 Source: https://academy.essentialdeveloper.com/courses/447455/lectures/8469954

 Section: Comments

 */

import Foundation

// MARK: - Loading Images

enum FeedImageSource {
    case url(URL)
    case data(Data)
}

struct FeedImage {
    let id: UUID
    let location: String?
    let description: String?
    let source: FeedImageSource
}

// MARK: - Protocols for data models will complicate the design

// Problem

/*

protocol message {
    var id :Int {get set}
    var date:String {get set}
    var senderName:String {get set}
    var senderImageUrl:String {get set }
}

struct textMessage: message {
    var id: Int

    var date: String

    var senderName: String

    var senderImageUrl: String

    var body:String
}

struct fileMessage: message {
    var id: Int

    var date: String

    var senderName: String

    var senderImageUrl: String

    var fileUrl:String
}

 */

// Solution - Using Structs & Enum

/*

struct TextMessage {
    let id: Int
    let date: String
    let senderName: String
    let senderImageUrl: String
    let body:String
}

struct FileMessage {
    let id: Int
    let date: String
    let senderName: String
    let senderImageUrl: String
    let fileUrl:String
}

enum Message {
  case text(TextMessage)
  case file(FileMessage)
}

 */

// MARK: - Modelling an example response(i.e. refer news.json in Resources folder)

struct NewsResponse {
    let status: String
    let totalResults: Int
    let news: [NewsItem]
}

struct NewsItem {
    let source: Source
    let tags: [Tag]?
    let author: String
    let title: String
}

struct Source {
    let id: UUID?
    let name: String
}

struct Tag {
    let id: UUID
    let name: String
}

//: [Next](@next)
