//
//  BaseViewModel.swift
//  pass2pastios
//
//  Created by Ali Nezamli on 28/01/2026.
//

import Foundation
import Combine

enum ViewState: Equatable {
    case idle
    case loading
    case success
    case error(String)
}

@MainActor
protocol ViewModelProtocol: ObservableObject {
    var state: ViewState { get set }
    var cancellables: Set<AnyCancellable> { get set }
}

@MainActor
class BaseViewModel: ObservableObject {
    @Published var state: ViewState = .idle
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false

    var cancellables = Set<AnyCancellable>()

    func setLoading(_ loading: Bool) {
        isLoading = loading
        state = loading ? .loading : .idle
    }

    func setError(_ message: String) {
        errorMessage = message
        state = .error(message)
        isLoading = false
    }

    func setSuccess() {
        state = .success
        isLoading = false
        errorMessage = nil
    }

    func resetState() {
        state = .idle
        isLoading = false
        errorMessage = nil
    }
}
