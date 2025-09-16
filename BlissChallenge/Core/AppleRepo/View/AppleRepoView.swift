//
//  AppleRepoView.swift
//  BlissChallenge
//
//  Created by Jamerson Macedo on 13/09/25.
//

import SwiftUI

struct AppleRepoView: View {
    @State var viewmodel: AppleRepoViewModel = .init()
    
    var body: some View {
            List {
                ForEach(viewmodel.repo) { repo in
                    VStack(alignment: .leading) {
                        Text(repo.fullName)
                            .font(.headline)
                    }
                    .task {
                        if repo.id == viewmodel.repo.last?.id {
                            await viewmodel.fetchAppleRepo()
                        }
                    }
                }
                
                if viewmodel.isLoading {
                    HStack {
                        Spacer()
                        ProgressView("Loading...")
                        Spacer()
                    }
                }
            }
            .alert(
                "Error",
                isPresented: Binding(
                    get: { viewmodel.errormessage != nil },
                    set: { _ in viewmodel.errormessage = nil }
                )
            ) {
                Button("OK", role: .cancel) {
                    
                }
            } message: {
                Text(viewmodel.errormessage ?? "Unknown error")
            }
            .navigationTitle("Apple Repo")
            .navigationBarTitleDisplayMode(.inline)
            .task {
                await viewmodel.fetchAppleRepo()
            }
            
    }
}

#Preview {
    AppleRepoView()
}
