//
//  PersonalInfoView.swift
//  sluv-ios-renew
//
//  Created by JunYong Park on 2023/03/22.
//

import SwiftUI

struct PersonalInfoView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack{
            ZStack{
                HStack{
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image("Arrow_left_24")
                            .padding(.leading, 20)
                    })
                    Spacer()
                }
                
                HStack{
                    Text("개인정보 처리방침")
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 0.14901960784313725, green: 0.14901960784313725, blue: 0.14901960784313725))
                }
            }
            .frame(width: UIScreen.main.bounds.width, height:50)
            .padding(0)
            Divider()
                .padding(.top, -10.0)
            Spacer()
            VStack{}
        }
    }
}

struct PersonalInfoView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalInfoView()
    }
}
