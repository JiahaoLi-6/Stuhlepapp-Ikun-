//
//  Untitled.swift
//  StuHlep
//
//  Created on 4/5/2026.
//
import SwiftUI

struct SearchBar: View {
    let placeholder: String
    @Binding var text: String

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)

            TextField(placeholder, text: $text)
                .font(.subheadline)
        }
        .padding(12)
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

struct FilterChip: View {
    let title: String
    let selected: Bool

    var body: some View {
        Text(title)
            .font(.caption)
            .fontWeight(.medium)
            .padding(.horizontal, 14)
            .padding(.vertical, 8)
            .background(selected ? Color.purple : Color(.systemGray6))
            .foregroundColor(selected ? .white : .primary)
            .cornerRadius(18)
    }
}

struct AvatarCircle: View {
    let text: String
    let color: Color

    var body: some View {
        Text(text)
            .font(.caption)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .frame(width: 26, height: 26)
            .background(color)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 2))
    }
}

struct CanvasButton: View {
    var body: some View {
        Button {
            print("Canvas link opened")
        } label: {
            Text("Canvas")
                .font(.caption)
                .fontWeight(.bold)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color.purple.opacity(0.15))
                .foregroundColor(.purple)
                .cornerRadius(12)
        }
    }
}
