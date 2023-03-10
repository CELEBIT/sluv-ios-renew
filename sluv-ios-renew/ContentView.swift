//
//  ContentView.swift
//  sluv-ios-renew
//
//  Created by JunYong Park on 2023/03/08.
//

import SwiftUI
import AuthenticationServices

extension Font {
    static let pretendardSemi_20 = Font.custom("Pretendard-SemiBold", size:20)
    static let pretendardRegular_14 = Font.custom("Pretendard-Regular", size:14)
}


struct ContentView: View {
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
                                    print(IdentityToken!)
                                    print(appleIDCredential.authorizationCode?.base64EncodedString() ?? "Authorization code not available")
                                    print("User ID : \(UserIdentifier)")
                                    print("User Email : \(email ?? "")")
                                    print("User Name : \((fullName?.givenName ?? "") + (fullName?.familyName ?? ""))")
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
            .padding()
            Spacer()
        }
        .frame(height:UIScreen.main.bounds.height)
        .background(Color.white)
        
    }
    
}
struct ContentView_Previews: PreviewProvider {
    @State static var isLoggedIn: Bool = false
    static var previews: some View {
        ContentView(isLoggedIn: $isLoggedIn)
    }
}
