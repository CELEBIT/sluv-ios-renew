//
//  ContentView.swift
//  sluv-ios-renew
//
//  Created by JunYong Park on 2023/03/08.
//

import SwiftUI
import AuthenticationServices
import Alamofire
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

extension Font {
    static let pretendardSemi_20 = Font.custom("Pretendard-SemiBold", size:20)
    static let pretendardRegular_14 = Font.custom("Pretendard-Regular", size:14)
}


struct LoginView: View {
    @Binding private var isLoggedIn: Bool
    @AppStorage("token") var token: String=""
    init(isLoggedIn: Binding<Bool>) {
        self._isLoggedIn = isLoggedIn
    }

    func appleAutoLogin() {
        if !token.isEmpty{
            self.isLoggedIn = true
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            VStack{
                Image("logo")
                    .padding(.bottom, 20.0)
                Text("셀럽의 아이템 정보 집합소")
                    .font(.pretendardSemi_20)
                    .foregroundColor(Color(red: 0.14901960784313725, green: 0.14901960784313725, blue: 0.14901960784313725)	)
                Text("스럽의 정보는 사랑스럽다!")
                    .font(.pretendardRegular_14)
                    .foregroundColor(Color(red: 0.41568627450980394, green: 0.41568627450980394, blue: 0.41568627450980394))
                    .padding(1.0)
            }
            .padding()
            Spacer()
            VStack {
                AppleSigninButton()
                KakaoSigninButton()
            }
            .padding()
            Spacer()
        }
        .frame(height:UIScreen.main.bounds.height)
        .background(Color.white)
        
    }
    
}


struct KakaoSigninButton: View{
    var body: some View{
        Button {
            if (UserApi.isKakaoTalkLoginAvailable()) {
                UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                    if let error = error {
                        print(error)
                    }
                    if let oauthToken = oauthToken{
                        socialLogin(token:oauthToken.accessToken, snsType:"KAKAO")
                    }
                }
            } else {
                UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                    if let error = error {
                        print(error)
                    }
                    if let oauthToken = oauthToken{
                        print("kakao success")
                        socialLogin(token:oauthToken.accessToken, snsType:"KAKAO")
                    }
                }
            }
        } label : {
            Image("kakao_login_large_wide")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width : UIScreen.main.bounds.width * 0.9)
        }
    }
}



struct AppleSigninButton : View{
    var body: some View{
        SignInWithAppleButton(
            onRequest: { request in
                request.requestedScopes = [.fullName, .email]
            },
            onCompletion: { result in
                switch result {
                case .success(let authResults):
                    print("Apple Login Successful")
                    switch authResults.credential{
                        case let appleIDCredential as ASAuthorizationAppleIDCredential:
//                                     계정 정보 가져오기
                            let UserIdentifier = appleIDCredential.user
                            let fullName = appleIDCredential.fullName
                            let name =  (fullName?.familyName ?? "") + (fullName?.givenName ?? "")
                            let email = appleIDCredential.email
                            let IdentityToken = String(data: appleIDCredential.identityToken!, encoding: .utf8)
                            let AuthorizationCode = String(data: appleIDCredential.authorizationCode!, encoding: .utf8)
                            socialLogin(token:IdentityToken!, snsType:"APPLE")
    
                    default:
                        break
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    print("error")
                }
            }
        )
        .frame(width : UIScreen.main.bounds.width * 0.9, height:50)
        .cornerRadius(5)
    }
}



let base = String("http://15.165.98.183:8080")

func socialLogin(token: String, snsType: String){
    let url = base+"/auth/social-login"
    let body = ["accessToken": token, "snsType": snsType] as Dictionary
    AF.request(url,
               method: .post,
               parameters: body,
               encoding: JSONEncoding(options: []),
                headers: ["Content-Type":"application/json", "Accept":"application/json"]).responseJSON
    { response in
      switch response.result {
      case .success:
        if let data = try! response.result.get() as? [String: Any] {
          print(data)
        }
      case .failure(let error):
        print("Error: \(error)")
        return
      }
    }
    
}




struct LoginView_Previews: PreviewProvider {
    @State static var isLoggedIn: Bool = false
    static var previews: some View {
        LoginView(isLoggedIn: $isLoggedIn)
    }
}
