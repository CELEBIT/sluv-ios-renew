//
//  sluv_ios_renewApp.swift
//  sluv-ios-renew
//
//  Created by JunYong Park on 2023/03/08.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth
import GoogleSignIn
import GoogleSignInSwift

extension Font {
    static let pretendardSemi_16 = Font.custom("Pretendard-SemiBold", size:16)
    static let pretendardSemi_18 = Font.custom("Pretendard-SemiBold", size:18)
    static let pretendardSemi_20 = Font.custom("Pretendard-SemiBold", size:20)
    static let pretendardSemi_24 = Font.custom("Pretendard-SemiBold", size:24)
    static let pretendardRegular_14 = Font.custom("Pretendard-Regular", size:14)
}



@main
struct sluv_ios_renewApp: App {
    init() {
        // Kakao SDK 초기화
        KakaoSDK.initSDK(appKey:"7b9e4a65e4241b6e222f88eb845c4b64")
    }
    @State var isLoggedIn: Bool = false;
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                if !isLoggedIn {
                    LoginView(isLoggedIn: self.$isLoggedIn)
                        .onOpenURL { url in
                            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                                _ = AuthController.handleOpenUrl(url: url)
                            }
                        }
                        .onOpenURL { url in
                          GIDSignIn.sharedInstance.handle(url)
                        }
                        .onAppear {
                          GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
                            // Check if `user` exists; otherwise, do something with `error`
                          }
                        }
                        .navigationBarBackButtonHidden(true)
                }
                else{
                    WebviewView()
                        .navigationBarBackButtonHidden(true)
    //                ProfileView()
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .edgesIgnoringSafeArea(.all)
            .navigationBarBackButtonHidden(true)
            
        }
        
    }
}
