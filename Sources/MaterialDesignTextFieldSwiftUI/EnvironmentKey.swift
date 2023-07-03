//
//  EnvironmentKey.swift
//  
//
//  Created by minghui on 2023/7/3.
//

import SwiftUI

public struct LeadingIconEnvironment: EnvironmentKey {
    public struct Value {
        let icon: Image?
        let color: Color
        
        static var defaultValue: Value = .init(icon: nil, color: .secondary)
    }
    
    public static var defaultValue: Value { .defaultValue }
}

extension EnvironmentValues {
    public var leadingIcon: LeadingIconEnvironment.Value {
        get { self[LeadingIconEnvironment.self] }
        set { self[LeadingIconEnvironment.self] = newValue }
    }
}

public struct HintEnvironment: EnvironmentKey {
    public static let defaultValue: LocalizedStringKey? = nil
}

extension EnvironmentValues {
    public var hint: LocalizedStringKey? {
        get { self[HintEnvironment.self] }
        set { self[HintEnvironment.self] = newValue }
    }
}

public extension View {
    func leadingIcon(_ icon: Image?, color: Color = .secondary) -> some View {
        self.environment(\.leadingIcon, LeadingIconEnvironment.Value(icon: icon, color: color))
    }
    
    func trailingIcon(_ icon: Image?, color: Color = .secondary, action: @escaping () -> Void = {}) -> some View {
        self.environment(\.trailingIcon, TrailingIconEnvironment.Value(icon: icon, color: color, action: action))
    }
    
    func hint(_ hint: LocalizedStringKey) -> some View {
        self.environment(\.hint, hint)
    }
    
    func isSecureField(_ isSecureField: Bool) -> some View {
        self.environment(\.isSecureField, isSecureField)
    }
    
    func isSecured(_ isSecured: Binding<Bool>) -> some View {
        self
            .isSecureField(isSecured.wrappedValue)
            .trailingIcon(isSecured.wrappedValue ? Image(systemName: "eye.slash.fill") : Image(systemName: "eye.fill"), action: {
                isSecured.wrappedValue.toggle()
            })
    }
}

public struct TrailingIconEnvironment: EnvironmentKey {
    public struct Value {
        let icon: Image?
        let color: Color
        let action: () -> Void
        
        static var defaultValue: Value = .init(icon: nil, color: .secondary, action: {})
    }
    
    public static var defaultValue: Value { .defaultValue }
}

extension EnvironmentValues {
    public var trailingIcon: TrailingIconEnvironment.Value {
        get { self[TrailingIconEnvironment.self] }
        set { self[TrailingIconEnvironment.self] = newValue }
    }
}

public struct IsSecureFieldEnvironment: EnvironmentKey {
    public static var defaultValue: Bool = false
}

extension EnvironmentValues {
    public var isSecureField: Bool {
        get { self[IsSecureFieldEnvironment.self] }
        set { self[IsSecureFieldEnvironment.self] = newValue }
    }
}


