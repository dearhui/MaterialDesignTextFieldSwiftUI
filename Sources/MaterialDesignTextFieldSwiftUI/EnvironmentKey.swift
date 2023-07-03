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
    
    func hint(_ hint: LocalizedStringKey) -> some View {
        self.environment(\.hint, hint)
    }
}

