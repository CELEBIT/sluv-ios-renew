//
//  ProfileView.swift
//  sluv-ios-renew
//
//  Created by JunYong Park on 2023/03/14.
//

import SwiftUI
import PhotosUI
import Alamofire 

struct ProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var usernameValid:Bool = true
    @State private var buttonValid:Bool = false
    @State private var username: String = ""
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    @State private var selectedImage: UIImage? = nil
    
    var body: some View {
        VStack(alignment: .center){
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
                    Text("캐릭터 만들기")
                        .font(.pretendardSemi_18)
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 0.14901960784313725, green: 0.14901960784313725, blue: 0.14901960784313725))
                }
            }
            .frame(width: UIScreen.main.bounds.width, height:50)
            .padding(0)
            Divider()
                .padding(.top, -10.0)
            
            if var selectedImageData,
               let uiImage = UIImage(data: selectedImageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 85, height: 85)
                    .clipShape(Circle())
                    .shadow(radius: 10)
                    .overlay(
                        PhotosPicker(
                            selection: $selectedItem,
                            matching: .images,
                            photoLibrary: .shared()) {
                                Image(systemName: "camera")
                                    .foregroundColor(Color("AccentColor"))
                                    .font(.system(size: 14))
                                    .opacity(0.1)
                            }
                            .onChange(of: selectedItem) { newItem in
                                Task {
                                    // Retrieve selected asset in the form of Data
                                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                        self.selectedImageData = data
                                        self.selectedImage = UIImage(data: selectedImageData)
                                    }
                                    
                                }
                            }
                    )
                    .padding(.top,50)
            }
            else{
                Circle()
                    .fill(Color(hue: 0.556, saturation: 0.012, brightness: 0.932))
                    .frame(width:85, height:85)
                    .overlay(
                        PhotosPicker(
                            selection: $selectedItem,
                            matching: .images,
                            photoLibrary: .shared()) {
                                Image(systemName: "camera")
                                    .foregroundColor(Color("AccentColor"))
                                    .font(.system(size: 14))
                            }
                            .onChange(of: selectedItem) { newItem in
                                Task {
                                    // Retrieve selected asset in the form of Data
                                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                        self.selectedImageData = data
                                        self.selectedImage = UIImage(data: selectedImageData!)
                                        
                                    }
                                }
                            }
                    )
                    .padding(.top,50)
            }
            HStack{
                TextField(
                        "닉네임은 최대 15자 입력 가능해요",
                        text: $username
                    )
                    .font(.pretendardRegular_14)
                    .onChange(of: username) { newValue in
                        if newValue.count > 15 {
                            username = String(newValue.prefix(15))
                        }
                        if newValue.count == 0 {
                            usernameValid = false
                            buttonValid = false
                        }
                        else{
                            usernameValid = true
                            buttonValid = true
                        }
                    }
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .padding()
                if !username.isEmpty {
                    Button(action: {
                        self.username = ""
                    }, label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(Color(red: 0.7803921568627451, green: 0.807843137254902, blue: 0.8313725490196079))
                            .padding()
                    })
                }
            }
            .frame(width : UIScreen.main.bounds.width * 0.9, height:50)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(usernameValid==true ? Color(red: 0.855, green: 0.855, blue: 0.855): .red)
            )
            .padding(.top, 50.0)
            
            
            Spacer()
            if buttonValid == false{
               NavigationLink(destination: WebviewView(), label: {
                   HStack{
                       Text("다음")
                           .font(.system(size: 16))
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
                NavigationLink(destination: WebviewView().navigationBarBackButtonHidden(true), label: {
                    HStack{
                        Text("다음")
                            .font(.system(size: 16))
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
    }
}


func ImageUpload(_ image: UIImage) {
    let imgData = image.jpegData(compressionQuality:0.2)
    let base = String("http://sluvdev-env.eba-vcrvfzjv.ap-northeast-2.elasticbeanstalk.com/app")
    let url = base+"/auth/profile"
//    let body = ["": imgData, "": imgData] as Dictionary
    AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imgData!, withName: "fileset",fileName: "file.jpg", mimeType: "image/jpg")
        },
    to:url).responseJSON { (response) in
        guard let statusCode = response.response?.statusCode else { return }
        switch statusCode {
        case 200:
            print("성공")
        default:
            if let responseJSON = try! response.result.get() as? [String : String] {
                if let error = responseJSON["error"] {
                    print(error)
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
