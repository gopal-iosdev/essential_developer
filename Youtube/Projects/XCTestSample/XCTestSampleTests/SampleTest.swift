//
//  SampleTest.swift
//  XCTestSampleTests
//
//  Created by Gopal Gurram on 8/1/23.
//

import XCTest

final class SampleTest: XCTestCase {
    let sample = Sample()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testExample() {
        sample.changeState()

        XCTAssertEqual(sample.state, 1)
    }

    func testExample2() {
        sample.changeState()

        XCTAssertEqual(sample.state, 2)
    }

    class Sample {
        var state = 0

        func changeState() {
            state += 1
        }
    }

}
