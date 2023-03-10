//
//  sluv_ios_renewApp.swift
//  sluv-ios-renew
//
//  Created by JunYong Park on 2023/03/08.
//

import SwiftUI

@main
struct sluv_ios_renewApp: App {
    @State var isLoggedIn: Bool = false;
    var body: some Scene {
        WindowGroup {
            if !isLoggedIn {
                ContentView(isLoggedIn: self.$isLoggedIn)
            }
        }
    }
}
