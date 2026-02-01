//
//  DependencyContainer.swift
//  pass2pastios
//
//  Created by Ali Nezamli on 28/01/2026.
//

import Foundation

final class DependencyContainer {
    static let shared = DependencyContainer()

    private init() {}

    // MARK: - Services
    lazy var networkService: NetworkServiceProtocol = {
        return NetworkService.shared
    }()

    // MARK: - ViewModels Factory
    @MainActor
    func makeHomeViewModel() -> HomeViewModel {
        return HomeViewModel()
    }
}
