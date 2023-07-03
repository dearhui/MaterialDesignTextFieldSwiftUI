//
//  ContentView.swift
//  MaterialDesignTextFieldDemo
//
//  Created by minghui on 2023/7/3.
//

import SwiftUI
import MaterialDesignTextFieldSwiftUI

struct ContentView: View {
    @State private var name: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            
            MaterialDesignTextField(name: "Name", value: $name)
                .hint("Please input username")
                .leadingIcon(Image(systemName: "person"))
            
            MaterialDesignTextField(name: "Password",
                                    value: $password,
                                    isSecureField: true)
            .leadingIcon(Image(systemName: "lock"))
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
