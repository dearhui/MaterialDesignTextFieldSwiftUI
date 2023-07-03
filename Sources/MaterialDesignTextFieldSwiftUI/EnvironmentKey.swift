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
        let size: CGFloat
        
        static var defaultValue: Value = .init(icon: nil, color: .primary, size: 24)
    }
    
    public static var defaultValue: Value { .defaultValue }
}

extension EnvironmentValues {
    public var leadingIcon: LeadingIconEnvironment.Value {
        get { self[LeadingIconEnvironment.self] }
        set { self[LeadingIconEnvironment.self] = newValue }
    }
}

public extension MaterialDesignTextField {
    func leadingIcon(_ icon: Image?, color: Color, size: CGFloat = 24) -> some View {
        self.environment(\.leadingIcon, LeadingIconEnvironment.Value(icon: icon, color: color, size: size))
    }
}

