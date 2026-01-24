//
//  TextStyles.swift
//  LeBip
//
//  Created by Anne Cahalan on 1/21/26.
//

import SwiftUI

protocol TextStyle: ViewModifier { }

extension Text {
    func textStyle<T: TextStyle>(_ style: T) -> some View {
        modifier(style)
    }
}

struct TitleTextStyle: TextStyle {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 50, weight: .bold, design: .rounded))
            .foregroundStyle(Color(AppColor.textPrimary))
    }
}

struct HeadlineTextStyle: TextStyle {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 40, weight: .bold, design: .rounded))
            .foregroundStyle(Color(AppColor.textPrimary))
    }
}

struct SubTitleTextStyle: TextStyle {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 25, weight: .bold, design: .rounded))
            .foregroundStyle(Color(AppColor.textSecondary))
            .frame(maxWidth: .infinity)
    }
}

struct BodyTextStyle: TextStyle {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 20, weight: .bold, design: .rounded))
            .foregroundStyle(Color(AppColor.textSecondary))
    }
}
