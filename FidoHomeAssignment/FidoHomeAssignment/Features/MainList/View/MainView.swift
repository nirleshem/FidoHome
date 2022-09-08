//
//  MainView.swift
//  FidoHomeAssignment
//
//  Created by Nir Leshem on 08/09/2022.
//

import SwiftUI

struct MainView: View {
    
    @Environment(\.scenePhase) var scenePhase
    @StateObject private var viewModel = MainViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                if viewModel.isLoading {
                    VStack {
                        ProgressView()
                        Spacer()
                    }
                    
                } else {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 10) {
                            ForEach(viewModel.articles) { article in
                                NavigationLink {
                                    DetailsView(article: article)
                                } label: {
                                    ArticleItem(article: article)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                    .onChange(of: scenePhase) { newPhase in
                         if newPhase == .active {
                             Task {
                                 await viewModel.fetchArticles()
                             }
                         }
                     }
                }
            }
            .navigationTitle("Fido")
            .task {
                await viewModel.fetchArticles()
            }
            .alert(isPresented: $viewModel.hasError, error: viewModel.error) {
                Button {
                    Task {
                        await viewModel.fetchArticles()
                    }
                } label: {
                    Text("Retry")
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

//MARK: - Private Views
private extension MainView {
    var RefreshButton: some View {
        Button {
            Task {
                await viewModel.fetchArticles()
            }
        } label: {
            Image(systemName: "arrow.clockwise")
        }
        .disabled(viewModel.isLoading)
    }
}
