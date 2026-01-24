//
//  ColorPickerView.swift
//  LeBip
//
//  Created by Anne Cahalan on 1/22/26.
//

import SwiftUI

struct ColorPickerView: View {
    @Binding var selectedColor: Color

    var body: some View {
        VStack(alignment: .leading) {
            Text("Select Player Color")
                .textStyle(SubTitleTextStyle())
            HStack {
                ForEach(AppColor.playerColors, id: \.self) { color in
                    ZStack{
                        Circle()
                            .foregroundStyle(color)
                            .frame(width: 50, height: 50)
                            .scaleEffect(color == selectedColor ? 1.15 : 1.0)
                            .onTapGesture {
                                selectedColor = color
                            }

                        Image(systemName: "star")
                            .opacity(color == selectedColor ? 1.0 : 0.0)
                    }

                }
            }
        }
        .padding()
    }
}

#Preview {
    ColorPickerView(selectedColor: .constant(AppColor.playerTeal))
}
