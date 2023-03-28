//
//  MovieDBApp.swift
//  MovieDB
//
//  Created by Himan Dhawan on 9/16/22.
//

import SwiftUI

@main
struct MovieDBApp: App {
    var body: some Scene {
        WindowGroup {
            LoginView(loginService: LoginDataService())
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
//    let navBarAppearance = UINavigationBarAppearance()
//    navBarAppearance.backgroundColor = .systemMint
//    navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
//    navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
//
//    UINavigationBar.appearance().standardAppearance = navBarAppearance
//    UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
//    UINavigationBar.appearance().compactAppearance = navBarAppearance

    return true
  }
}
