//
//  LoginView.swift
//  WarStat
//
//  Created by a.antoniak on 26.09.2023.
//

import SwiftUI

final class LoginViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    
    func update(username: String, password: String) {
        self.username = username
        self.password = password
    }
}

struct LoginView: View {
    private enum Constants {
        static let storeInput = "Store"
        
        static let username = "Username"
        static let password = "Password"
    }
    
    @Binding var username: String
    @Binding var password: String
    
    @ObservedObject private var observedStoredViewModel = LoginViewModel()
    @ObservedObject var observedInjectedViewModel: LoginViewModel
    
    @Environment(\.theme) var theme: Theme
    
    var body: some View {
        VStack {
            TextField(Constants.username, text: $username)
            TextField(Constants.password, text: $password)
            
            Text("Stored username - \(observedStoredViewModel.username)")
            Text("Stored password - \(observedStoredViewModel.password)")
                .padding(.bottom, theme.verticalPadding)
            
            Text("Injected username - \(observedInjectedViewModel.username)")
            Text("Injected password - \(observedInjectedViewModel.password)")
            
            Button(Constants.storeInput) {
                observedStoredViewModel.update(
                    username: username,
                    password: password
                )
                observedInjectedViewModel.update(
                    username: username,
                    password: password
                )
            }
            .padding(.top, theme.verticalPadding)
        }
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(
            username: .constant("username"),
            password: .constant("1"),
            observedInjectedViewModel: LoginViewModel()
        )
    }
}
