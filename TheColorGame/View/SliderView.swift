//
//  SliderView.swift
//  TheColorGame
//
//  Created by Денис Александров on 07.09.2024.
//

import SwiftUI

struct SliderView: View {
    var color: Color
    @Binding var value: Double
    @State private var textValue: String = ""
    @State private var showAlert = false
    @FocusState var isInputActive: Bool
    
    var body: some View {
        HStack {
            Text("\(Int(value))")
                .frame(width: 35)
                .font(.system(size: 16))
                .foregroundColor(.white)
            
            Slider(value: $value, in: 0...255, step: 1, onEditingChanged: { _ in
                value = value.clamped(to: 0...255)
                textValue = "\(Int(value))"
            })
            .accentColor(color)
            
            TextField("", text: $textValue)
                .frame(width: 50)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
                .focused($isInputActive)
                .onChange(of: isInputActive) { oldValue, newValue in
                    if !newValue {
                        if let newValue = Double(textValue), newValue >= 0 && newValue <= 255 {
                            value = newValue
                        } else {
                            textValue = "\(Int(value))"
                            showAlert = true
                        }
                    }
                }
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Некорректное значение"),
                        message: Text("Введите число от 0 до 255."),
                        dismissButton: .default(Text("Закрыть"))
                    )
                }
        }
        .padding(.horizontal)
        .onAppear {
            textValue = "\(Int(value))"
        }
    }
}

extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}

#Preview {
    ContentView()
}
