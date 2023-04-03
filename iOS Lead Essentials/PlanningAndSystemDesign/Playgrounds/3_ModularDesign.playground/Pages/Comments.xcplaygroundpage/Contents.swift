//: [Previous](@previous)

/*
 Source: https://academy.essentialdeveloper.com/courses/447455/lectures/8470080
 
 Section: Comments
 
 */

import Foundation

// MARK: - "conforms to" relationship

// Dashed line, empty head
protocol Feature {}

class Composer: Feature {
    let feature: Feature
    
    init(feature: Feature) {
        self.feature = feature
    }
}

// MARK: - "not conforms to" relationship

// Solid line, filled head = "depends on"
class Composer2 {
    let feature: Feature
    
    init(feature: Feature) {
        self.feature = feature
    }
}

//: [Next](@next)
