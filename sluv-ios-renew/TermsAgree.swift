//
//  TermsAgree.swift
//  sluv-ios-renew
//
//  Created by JunYong Park on 2023/03/22.
//


import SwiftUI


struct TermsAgree: View {
    @State var agreeArray:[Bool] = [false, false, false, false]
    @State var agreeAll:Bool = false
    @State var agreeValid:Bool = false
    @State var login = false
    @Environment(\.presentationMode) var presentationMode
    
    func clickAll(){
        if agreeAll == false{
            for index in agreeArray.indices {
                if agreeArray[index] == false{
                    agreeArray[index] = true
                }
            }
        }
        else{
            for index in agreeArray.indices {
                if agreeArray[index] == true{
                    agreeArray[index] = false
                }
            }
        }
        agreeAll = !agreeAll
        if agreeArray[0] == true && agreeArray[1]==true && agreeArray[2]==true{
            agreeValid = true
        }else{
            agreeValid = false
        }
    }
    
    var body: some View {
            VStack{
                HStack{
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        NavigationLink(destination: LoginView(isLoggedIn: $login), label: {Image("Arrow_left_24")
                            .padding(.leading, 20)})
                        
                    })
                    Spacer()
                }
                .frame(width: UIScreen.main.bounds.width, height:50)
                
                Divider()
                    .padding(.top, -10.0)
                VStack{
                    HStack(alignment:.center){
                        Text("스럽 서비스 이용약관에 \n동의해주세요")
                            .font(.pretendardSemi_24)
                            .fontWeight(.semibold)
                            .foregroundColor(Color(red: 0.14901960784313725, green: 0.14901960784313725, blue: 0.14901960784313725))
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                    HStack(alignment:.center){
                        Button(action: {clickAll()}) {
                            if agreeAll == false{
                                Image("Check_off_24")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 24, height: 24, alignment: .center)
                            }
                            else{
                                Image("Check_on_24")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 24, height: 24, alignment: .center)
                            }
                            
                        }
                        Text("약관 전체동의")
                            .font(.pretendardSemi_16)
                            .fontWeight(.semibold)
                            .foregroundColor(Color(red: 0.14901960784313725, green: 0.14901960784313725, blue: 0.14901960784313725))
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                    .padding(.top,10)
                    Divider()
                        .padding(.bottom, 10)
                    CheckRow(idx: 0, Mandatory: true, CheckText: "만 14세 이상", agreeArray:$agreeArray, agreeAll:$agreeAll, agreeValid:$agreeValid)
                    CheckRow(idx: 1, Mandatory: true, CheckText: "이용약관 동의", NextView:AnyView(ServiceTermView()), agreeArray:$agreeArray, agreeAll:$agreeAll, agreeValid:$agreeValid)
                    CheckRow(idx: 2, Mandatory: true, CheckText: "개인정보 처리방침 동의", NextView:AnyView(PersonalInfoView()), agreeArray:$agreeArray, agreeAll:$agreeAll, agreeValid:$agreeValid)
                    CheckRow(idx: 3, Mandatory: false, CheckText: "광고성 정보 수신 및 마케팅 활용 동의", NextView:AnyView(AdvertisementMarketingView()), agreeArray:$agreeArray, agreeAll:$agreeAll, agreeValid:$agreeValid)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                Spacer()
                if agreeValid == false{
                   NavigationLink(destination: ProfileView(), label: {
                       HStack{
                           Text("다음")
                               .font(.pretendardSemi_16)
                               .foregroundColor(.white)
                               .fontWeight(.bold)
                       }
                       .frame(width : UIScreen.main.bounds.width * 0.9, height:50)
                       .background(Color(red: 0.8549019607843137, green: 0.8549019607843137, blue: 0.8549019607843137))
                       .cornerRadius(64)
                        }
                   ).disabled(true)
                }
                else{
                    NavigationLink(destination: ProfileView().navigationBarBackButtonHidden(true), label: {
                        HStack{
                            Text("다음")
                                .font(.pretendardSemi_16)
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                        }
                        .frame(width : UIScreen.main.bounds.width * 0.9, height:50)
                        .background(Color("AccentColor"))
                        .cornerRadius(64)
                         }
                    )
                }
                
            }
            .toolbar{
                
            }
            
        }
}

struct CheckRow: View {
    @State var idx: Int
    @State var Mandatory: Bool
    @State var CheckText: String
    @State var NextView: AnyView?
    @Binding var agreeArray:[Bool]
    @Binding var agreeAll:Bool
    @Binding var agreeValid:Bool
    
    func clickEach(index:Int){
        agreeArray[index] = !agreeArray[index]
        let numberOfTrue = agreeArray.filter{$0}.count
        if numberOfTrue == 4{
            agreeAll = true
        }
        else{
            agreeAll = false
        }
        if agreeArray[0] == true && agreeArray[1]==true && agreeArray[2]==true{
            agreeValid = true
        }else{
            agreeValid = false
        }
    }
    
    var body: some View {
        HStack(alignment:.center){
            Button(action: {clickEach(index:idx)}) {
                if agreeArray[idx] == false{
                    Image("Check_off_24")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 24, height: 24, alignment: .center)
                }
                else{
                    Image("Check_on_24")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 24, height: 24, alignment: .center)
                }
            }
            if Mandatory == true {
                Text("[필수]")
                    .font(.pretendardRegular_14)
                    .fontWeight(.regular)
                    .foregroundColor(Color("PointText"))
            }
            else{
                Text("[선택]")
                    .font(.pretendardRegular_14)
                    .fontWeight(.regular)
                    .foregroundColor(Color(red: 0.14901960784313725, green: 0.14901960784313725, blue: 0.14901960784313725))
            }
            Text(CheckText)
                .font(.pretendardRegular_14)
                .fontWeight(.regular)
                .foregroundColor(Color(red: 0.14901960784313725, green: 0.14901960784313725, blue: 0.14901960784313725))
            if NextView != nil{
                NavigationLink(destination: NextView.navigationBarBackButtonHidden(true)) {
                    Text("보기")
                        .font(.system(size: 12))
                        .fontWeight(.regular)
                        .underline()
                        .foregroundColor(Color(red: 0.6941176470588235, green: 0.6941176470588235, blue: 0.6941176470588235))
                }
            }
            Spacer()
        }
    }
}




struct TermsAgree_Previews: PreviewProvider {
    static var previews: some View {
        TermsAgree()
    }
}

