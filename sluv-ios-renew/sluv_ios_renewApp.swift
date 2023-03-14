//
//  sluv_ios_renewApp.swift
//  sluv-ios-renew
//
//  Created by JunYong Park on 2023/03/08.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct sluv_ios_renewApp: App {
    init() {
        // Kakao SDK 초기화
        KakaoSDK.initSDK(appKey:"7b9e4a65e4241b6e222f88eb845c4b64")
    }
    @State var isLoggedIn: Bool = false;
    var body: some Scene {
        WindowGroup {
            if !isLoggedIn {
                LoginView(isLoggedIn: self.$isLoggedIn)
                    .onOpenURL { url in
                        if (AuthApi.isKakaoTalkLoginUrl(url)) {
                            _ = AuthController.handleOpenUrl(url: url)
                        }
                    }
            }
            else{
                ProfileView()
            }
        }
    }
}
