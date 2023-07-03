//
//  SwiftUIView.swift
//  
//
//  Created by minghui on 2023/7/3.
//

import SwiftUI
import PureSwiftUI

public struct MaterialDesignTextField: View {
    @Environment(\.leadingIcon) var leadingIcon: LeadingIconEnvironment.Value
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.hint) private var hint: LocalizedStringKey?
    
    private let name: LocalizedStringKey
    @Binding private var value: String
    @Binding private var isSecureField: Bool
    private let verified: Bool
    private let focused: Bool
    
    public init(name: LocalizedStringKey,
                value: Binding<String>,
                isSecureField: Binding<Bool> = .constant(false),
                verified: Bool = true,
                focused: Bool = false) {
        self.name = name
        self._value = value
        self._isSecureField = isSecureField
        self.verified = verified
        self.focused = focused
    }
    
    public var body: some View {
        VStack (spacing: 4) {
            textField
            
            hintView
        }
        .animation(.easeInOut, value: isMini)
    }
    
    private var _verified: Bool {
        if focused || value.isEmpty { return true }
        return verified
    }
    
    private var isMini: Bool {
        return focused || !value.isEmpty
    }
    
    private var textField: some View {
        HStack {
            if let icon = leadingIcon.icon {
                icon
                    .foregroundColor(leadingIcon.color)
            }
            
            ZStack {
                inputField
                label
            }
            
            if isSecureField {
                eyeButton
            }
        }
        .padding()
        .background(fieldBackground)
    }
    
    @ViewBuilder
    private var inputField: some View {
        Group {
            if isSecureField {
                SecureField("", text: $value)
            } else {
                TextField("", text: $value)
            }
        }
        .autocorrectionDisabled(true)
        .autocapitalization(.none)
        .yOffsetIf(isMini, 8)
        .foregroundColor(isEnabled ? Color(UIColor.label) : Color(UIColor.secondaryLabel))
    }
    
    private var label: some View {
        Text(name)
            .greedyWidth(.leading)
            .font(isMini ? .caption : .body)
            .yOffsetIf(isMini, -12)
            .foregroundColor(isMini ? .accentColor : Color(UIColor.placeholderText))
            .zIndex(-1)
    }
    
    private var fieldBackground: some View {
        RoundedRectangle(cornerRadius: 8)
            .strokeBorder(_verified ? Color.clear : Color(UIColor.systemPink))
            .background(
                Color(UIColor.tertiarySystemBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            )
    }
    
    @ViewBuilder
    private var hintView: some View {
        if let hint = hint {
            Text(hint)
                .font(.caption)
                .greedyWidth(.leading)
                .padding(.horizontal)
                .foregroundColor(_verified ? Color(UIColor.secondaryLabel) : Color(UIColor.systemPink))
                .opacity( (focused || !_verified) ? 1 : 0)
        }
    }
    
    private var eyeButton: some View {
        Button {
            isSecureField.toggle()
        } label: {
            Image(systemName: isSecureField ? "eye.slash.fill" : "eye.fill")
                .foregroundColor(.secondary)
        }
    }
}


struct MaterialDesignTextField_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            MaterialDesignTextField(name: "register_nick_name",
                                    value: .constant(""),
                                     verified: true,
                                     focused: false)
            MaterialDesignTextField(name: "register_nick_name",
                                     value: .constant("disabled true"),
                                     verified: true,
                                     focused: false)
            .disabled(true)
            MaterialDesignTextField(name: "register_nick_name",
                                     value: .constant("123"),
                                     verified: true,
                                     focused: true)
            MaterialDesignTextField(name: "name",
                                     value: .constant("YOUR_NAME"),
                                     verified: false,
                                     focused: false)
            .hint("Please enter your password")
            MaterialDesignTextField(name: "密碼",
                                    value: .constant("123"), isSecureField: .constant(true),
                                     verified: false,
                                     focused: false)
            .leadingIcon(Image(systemName: "house"))
            .hint("Please enter your password")
        }
        .padding()
    }
}

