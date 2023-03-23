//
//  ServiceTermView.swift
//  sluv-ios-renew
//
//  Created by JunYong Park on 2023/03/22.
//

import SwiftUI

struct ServiceTermView: View {
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
                    Text("서비스 이용약관")
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 0.14901960784313725, green: 0.14901960784313725, blue: 0.14901960784313725))
                }
            }
            .frame(width: UIScreen.main.bounds.width, height:50)
            .padding(0)
            Divider()
                .padding(.top, -10.0)
            Text("또한 여러분이 관련 법령, 본 약관, 계정 및 게시물 운영정책, 각 개별 서비스에서의 약관, 운영정책 등을 준수하지 않을 경우, 네이버는 여러분의 관련 행위 내용을 확인할 수 있으며, 그 확인 결과에 따라 네이버 서비스 이용에 대한 주의를 당부하거나, 네이버 서비스 이용을 일부 또는 전부, 일시 또는 영구히 정지시키는 등 그 이용을 제한할 수 있습니다. 한편, 이러한 이용 제한에도 불구하고 더 이상 네이버 서비스 이용계약의 온전한 유지를 기대하기 어려운 경우엔 부득이 여러분과의 이용계약을 해지할 수 있습니다.")
                .padding(.top, -10.0)
                .padding(20)
            Spacer()
            
            VStack{}
        }
    }
}

struct ServiceTermView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceTermView()
    }
}
