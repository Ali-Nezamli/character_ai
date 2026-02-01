//
//  AppConstants.swift
//  pass2pastios
//
//  Created by Ali Nezamli on 28/01/2026.
//

import Foundation

enum AppConstants {

    enum API {
        static let baseURL = "http://164.92.192.249:37575/"
        static let timeout: TimeInterval = 30
    }

    enum App {
        static let name = "pass2pastios"
        static let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
        static let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
    }

    enum Storage {
        static let userDefaultsPrefix = "com.pass2pastios."
    }
}
