//
//  LoggingUseCaseFactoryTests.swift
//  CleanArchitectureCompositionTests
//
//  Created by Gopal Gurram on 3/7/23.
//

import XCTest
@testable import CleanArchitectureComposition

final class LoggingUseCaseFactoryTests: XCTestCase {
    func test_CreatedUseCase_hasComposedOutputs() {
        let sut = LoggingUseCaseFactory()
        let useCase = sut.makeUseCase()
        let composer = useCase.loginUseCase as? LoginUseCaseOutputComposer
        
        XCTAssertNotNil(composer)
        XCTAssertEqual(composer?.outputs.count, 3)
        XCTAssertEqual(composer?.count(ofType: LoginPresenter.self), 1)
        XCTAssertEqual(composer?.count(ofType: CrashlyticsLoginTracker.self), 1)
        XCTAssertEqual(composer?.count(ofType: FirebaseAnalyticsLoginTracker.self), 1)
    }
}

private extension LoginUseCaseOutputComposer {
    func count<T>(ofType: T.Type) -> Int {
        outputs.filter { $0 is T }.count
    }
}
