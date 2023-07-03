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
    
    @State private var isSecured: Bool = true
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            
            MaterialTextField(name: "Name", value: $name)
                .hint("Please input username")
                .leadingIcon(Image(systemName: "person"))
            
            MaterialTextField(name: "Password",
                                    value: $password)
            .leadingIcon(Image(systemName: "lock"))
            .isSecured($isSecured)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
