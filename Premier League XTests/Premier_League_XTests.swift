//
//  Premier_League_XTests.swift
//  Premier League XTests
//
//  Created by Hady on 15/10/2023.
//

import XCTest

@testable import Premier_League_X

final class Premier_League_XTests: XCTestCase {

    let sut: MatchesArrangedProtocol!

    override func setUpWithError() throws {
        sut = ArrangeMatchManager()
        
    }
    
    func testNumberOfMatches() {
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
