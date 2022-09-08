//
//  MainViewModel.swift
//  FidoHomeAssignment
//
//  Created by Nir Leshem on 08/09/2022.
//

import SwiftUI

final class MainViewModel: ObservableObject {
    
    @Published private(set) var articles: [Article] = []
    @Published private(set) var error: NetworkingError?
    @Published private(set) var viewState: ViewState?
    @Published var hasError = false
    
    private let networkingManager: NetworkingManagerProtocol!
    
    var isLoading: Bool {
        return viewState == .loading
    }
    
    var isFetching: Bool {
        return viewState == .fetching
    }

    //MARK: LifeCycle
    init(networkingManager: NetworkingManagerProtocol = NetworkingManager.shared) {
        self.networkingManager = networkingManager
    }
        
    @MainActor
    func fetchArticles() async {
        
        reset()
        
        viewState = .loading
        defer { viewState = .finished }
                
        do {
            let response = try JSONMapper.decode(file: "articles", type: Articles.self)
            self.articles = response.articles
//            let response = try await networkingManager.request(.getArticles, type: Articles.self)
//            self.articles = response.articles
        } catch {
            hasError = true
            if let networkingError = error as? NetworkingError {
                self.error = networkingError
            } else {
                self.error = .custom(error: error)
            }
        }
    }
    
    func reset() {
        if viewState == .finished {
            articles.removeAll()
            viewState = nil
        }
    }
}

extension MainViewModel {
    enum ViewState {
        case fetching
        case loading
        case finished
    }
}
