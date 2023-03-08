//
//  LoggingUseCaseFactory.swift
//  CleanArchitectureComposition
//
//  Created by Gopal Gurram on 3/7/23.
//

import Foundation

final class LoggingUseCaseFactory {
    func makeUseCase() -> LoginUseCase {
        return LoginUseCase(loginUseCase: LoginUseCaseOutputComposer([
            LoginPresenter(),
            CrashlyticsLoginTracker(),
            FirebaseAnalyticsLoginTracker()
        ]))
    }
}
