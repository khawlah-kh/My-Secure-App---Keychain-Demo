//
//  CustomTextField.swift
//  Twitter
//
//  Created by khawlah khalid on 25/09/2021.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var text : String
    @State var placeholder : String
    @Environment(\.colorScheme) var colorScheme
    let imageName : String
    var  textFieldPlaceholder : String {
        if text.isEmpty{return placeholder }
        return ""
    }
    
    var body: some View {
        ZStack(alignment:.leading){
            Text(textFieldPlaceholder)
                .foregroundColor(colorScheme == .dark ? Color(.init(white: 1, alpha: 0.87)) : .gray)
                .padding(.leading,53)
            
            HStack(spacing:16){
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(colorScheme == .dark ? Color(.init(white: 1, alpha: 0.87)) : .gray)
                
                TextField("", text: $text)
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

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(text: .constant(""), placeholder: "Email", imageName: "envelope")
    }
}


