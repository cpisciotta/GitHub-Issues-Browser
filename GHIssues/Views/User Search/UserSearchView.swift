//
//  UserSearchView.swift
//  GHIssues
//
//  Created by Charles Pisciotta on 11/2/20.
//

import SwiftUI

struct UserSearchView: View {

    @State private var username: String = ""

    var body: some View {
        NavigationView {
            VStack {
                Image("magnifying-glass")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 175, height: 175)

                TextField("Username", text: $username)
                    .autocapitalization(.none)
                    .font(.title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 50)
                    .padding(.vertical)

                NavigationLink(
                    destination: repoList(for: username),
                    label: {
                        Text("Search!")
                    })
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 25.0)
                            .foregroundColor(.ghBrowserPurple)
                            .frame(width: 200, height: 50, alignment: .center)
                    )
            }
            .offset(y: -25.0)
            .navigationTitle(Text("Search for a User!"))
        }
    }

    func repoList(for username: String) -> some View {
        let viewModel = GHRepoListViewModel(username: username)
        return ReposListView(viewModel: viewModel)
    }
}

struct UserSearchView_Previews: PreviewProvider {
    static var previews: some View {
        UserSearchView()
    }
}
