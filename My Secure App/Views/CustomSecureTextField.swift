//
//  CustomSecureTextField.swift
//  MyAcademy
//
//  Created by khawlah khalid on 08/05/2022.
//
//
import SwiftUI
struct CustomSecureField: View {
    @Binding var text : String
    @State var placeholder : String
    @Environment(\.colorScheme) var colorScheme
    var  textFieldPlaceholder : String {
        if text.isEmpty{return placeholder}
        return ""
    }
    
    var body: some View {
        ZStack(alignment:.leading){
            Text(textFieldPlaceholder)
                .foregroundColor(colorScheme == .dark ? Color(.init(white: 1, alpha: 0.87)) : .gray)
                .padding(.leading,53)
            
            HStack(spacing:16){
                Image(systemName: "lock")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(colorScheme == .dark ? Color(.init(white: 1, alpha: 0.87)) : .gray)
                
                SecureField("", text: $text)
            }
            .padding()
            .background(colorScheme == .dark ? RoundedRectangle(cornerRadius:10 )
                            .foregroundColor( Color(.init(white:1,alpha:0.15)))
                        :
                            RoundedRectangle(cornerRadius:10 )
                            .foregroundColor(.gray.opacity(0.1))
            )
            .cornerRadius(10)
            .foregroundColor(Color(.label))
        }
    }
}

struct CustomSecureField_Previews: PreviewProvider {
    static var previews: some View {
        CustomSecureField(text: .constant(""), placeholder: "Email")
    }
}



