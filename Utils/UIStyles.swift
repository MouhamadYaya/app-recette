//
//  UIStyles.swift
//  SwiftSupabaseStarter
//
//  Created by Cole Lucky on 11/20/25.
//

import SwiftUI

// colors

extension Color {
    static let patriotBlue = Color(red: 0/255, green: 48/255, blue: 108/255)      // Navy
    static let patriotRed = Color(red: 191/255, green: 13/255, blue: 62/255)      // Deep Red
    static let patriotWhite = Color.white
    static let patriotGray = Color(red: 240/255, green: 240/255, blue: 240/255)   // Soft Gray
}


// Styles

struct PatriotTextField: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.patriotWhite)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.patriotBlue.opacity(0.8), lineWidth: 1.5)
            )
            .shadow(color: .black.opacity(0.05), radius: 3, x: 0, y: 1)
    }
}

extension View {
    func patriotTextFieldStyle() -> some View {
        self.modifier(PatriotTextField())
    }
}

struct PatriotSecureField: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.patriotWhite)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.patriotBlue.opacity(0.8), lineWidth: 1.5)
            )
            .shadow(color: .black.opacity(0.05), radius: 3, x: 0, y: 1)
    }
}

extension View {
    func patriotSecureFieldStyle() -> some View {
        self.modifier(PatriotSecureField())
    }
}


// Primary Button Style (Red)

struct PatriotPrimaryButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(.headline)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.patriotRed)
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}

extension View {
    func patriotPrimaryButtonStyle() -> some View {
        self.modifier(PatriotPrimaryButton())
    }
}


// Secondary Button Style (Outlined Blue)

struct PatriotSecondaryButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.patriotBlue)
            .font(.headline)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.patriotBlue, lineWidth: 1.5)
            )
    }
}

extension View {
    func patriotSecondaryButtonStyle() -> some View {
        self.modifier(PatriotSecondaryButton())
    }
}


// Patriotic Logo (Reusable)

struct PatriotLogo: View {
    var body: some View {
        ZStack {
            // Flag stripes
            VStack(spacing: 4) {
                Color.patriotRed.frame(height: 8)
                Color.patriotWhite.frame(height: 8)
                Color.patriotRed.frame(height: 8)
            }
            .frame(width: 64)
            
            // Blue union
            Color.patriotBlue
                .frame(width: 28, height: 28)
                .offset(x: -18)
        }
        .clipShape(RoundedRectangle(cornerRadius: 6))
        .shadow(radius: 3)
    }
}


// Backgrounds

extension View {
    func patriotBackground() -> some View {
        self.background(
            LinearGradient(
                colors: [.patriotGray, .patriotWhite],
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }
}

