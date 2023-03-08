//
//  FirebaseAnalyticsLoginTracker.swift
//  CleanArchitectureComposition
//
//  Created by Gopal Gurram on 3/7/23.
//

import Foundation

final class FirebaseAnalyticsLoginTracker: LoginUseCaseOutput {
    func loginFinished(with result: Result<User, Error>) {
        switch result {
        case .success(let success):
            // send login event to Firebase.
            print("success")
        case .failure(let failure):
            // send error to Firebase.
            print("failure")
        }
    }
}
