//
//  MainRootView.swift
//  WarStat
//
//  Created by a.antoniak on 26.09.2023.
//

import SwiftUI

final class MainRootViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    
    func printTheme() {
        print("Dark theme - \(UserDefaults.standard.bool(forKey: "themeKey"))")
    }
}

struct MainRootView: View {
    private enum Constants {
        static let changeTheme = "Change Theme"
        static let printValues = "Print Values"
        static let hideValues = "Hide Values"
        
        static let themeKey = "themeKey"
    }
    
    @EnvironmentObject var theme: Theme
    
    @ObservedObject private var viewModel: MainRootViewModel
    
    @State private var shouldShowValues = false
    private var loginViewModel = LoginViewModel()
    
    @AppStorage(Constants.themeKey) var isDarkTheme = true
    
    init(viewModel: MainRootViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            
            LoginView(
                username: $viewModel.username,
                password: $viewModel.password,
                observedInjectedViewModel: loginViewModel
            )
            
            Button(Constants.changeTheme) {
                viewModel.printTheme()
                
                isDarkTheme.toggle()
                
                viewModel.printTheme()
            }
            .padding(.bottom, theme.verticalPadding)
            
            Button(
                shouldShowValues
                ? Constants.hideValues
                : Constants.printValues
            ) {
                shouldShowValues.toggle()
            }
            
            Text(shouldShowValues ? viewModel.username : "")
            Text(shouldShowValues ? viewModel.password : "")
            
            Spacer()
        }
        .foregroundColor(isDarkTheme ? .white : .black)
        .background(isDarkTheme ? .black : .white)
        .onAppear {
            viewModel.printTheme()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainRootView(viewModel: MainRootViewModel())
    }
}
