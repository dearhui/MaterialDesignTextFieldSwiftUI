//
//  SwiftUIView.swift
//  
//
//  Created by minghui on 2023/7/3.
//

import SwiftUI
import PureSwiftUI

public struct MaterialTextField: View {
    @Environment(\.colorScheme) var colorSchema
    @Environment(\.leadingIcon) var leadingIcon: LeadingIconEnvironment.Value
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.hint) private var hint: LocalizedStringKey?
    @Environment(\.trailingIcon) var trailingIcon: TrailingIconEnvironment.Value
    @Environment(\.isSecureField) private var isSecureField: Bool

    private let name: LocalizedStringKey
    @Binding private var value: String
    private let verified: Bool
    private let focused: Bool
    private let accentColor: Color

    public init(name: LocalizedStringKey,
                value: Binding<String>,
                verified: Bool = true,
                focused: Bool = false,
                accentColor: Color = Color(UIColor.systemBlue)) {
        self.name = name
        self._value = value
        self.verified = verified
        self.focused = focused
        self.accentColor = accentColor
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
    
    private var isHintDisplay: Bool {
        return (focused || !_verified)
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
            
            if let trailingIconImage = trailingIcon.icon {
                Button {
                    trailingIcon.action()
                } label: {
                    trailingIconImage
                        .foregroundColor(trailingIcon.color)
                }
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
            .foregroundColor(isEnabled ?
                            (isMini ? accentColor : Color(UIColor.placeholderText)) :
                            Color(UIColor.tertiaryLabel))
            .zIndex(-1)
    }
    
    private var fieldBackground: some View {
        RoundedRectangle(cornerRadius: 8)
            .strokeBorder(_verified ? Color.clear : Color(UIColor.systemPink))
            .background(
                Color(colorSchema == .dark ? 
                      (isEnabled ? UIColor.tertiarySystemBackground : UIColor.systemGray5) : 
                      (isEnabled ? .secondarySystemBackground : UIColor.systemGray5))
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
                .opacity( isHintDisplay ? 1 : 0)
        }
    }
}

struct MaterialDesignTextField_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            MaterialTextField(name: "register_nick_name",
                              value: .constant(""),
                              verified: true,
                              focused: false)
            MaterialTextField(name: "register_nick_name",
                              value: .constant("disabled true"),
                              verified: true,
                              focused: false)
            .disabled(true)
            MaterialTextField(name: "register_nick_name",
                              value: .constant("123"),
                              verified: true,
                              focused: true)
            MaterialTextField(name: "name",
                              value: .constant("YOUR_NAME"),
                              verified: false,
                              focused: false)
            .hint("Please enter your password")
            MaterialTextField(name: "密碼",
                              value: .constant("123"),
                              verified: true,
                              focused: true)
            .leadingIcon(Image(systemName: "house"))
            .hint("Please enter your password")
            .trailingIcon(Image(systemName: "eye.fill"))
        }
        .padding()
    }
}

