//
//  ContentView.swift
//  TheColorGame
//
//  Created by Денис Александров on 04.09.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var redValue = Double.random(in: 0...255)
    @State private var greenValue = Double.random(in: 0...255)
    @State private var blueValue = Double.random(in: 0...255)

    @FocusState private var isInputActive: Bool  // Состояние фокуса для полей ввода

    var body: some View {
        ZStack {  // Оборачиваем в ZStack для обработки касаний на любой области
            Color(red: 173/255, green: 210/255, blue: 240/255)
                .ignoresSafeArea()
            VStack {
                Rectangle()
                    .fill(Color(red: redValue/255, green: greenValue/255, blue: blueValue/255))
                    .frame(height: 150)
                    .cornerRadius(15)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)  // Форма для закругленной рамки
                            .stroke(Color.white, lineWidth: 4)  // Белая рамка шириной 4
                    )
                    .padding()

                SliderView(color: .red, value: $redValue, isInputActive: _isInputActive)  // Передаем состояние фокуса
                SliderView(color: .green, value: $greenValue, isInputActive: _isInputActive)  // Передаем состояние фокуса
                SliderView(color: .blue, value: $blueValue, isInputActive: _isInputActive)  // Передаем состояние фокуса

                Spacer()
            }
            .padding()

            // Добавляем жест для скрытия клавиатуры по нажатию на любую область экрана
            Color.clear
                .contentShape(Rectangle())  // Обеспечиваем возможность касания по пустому пространству
                .onTapGesture {
                    isInputActive = false  // Сбрасываем фокус, скрываем клавиатуру
                }
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Button("Done") {
                    isInputActive = false  // Скрытие клавиатуры по кнопке Done
                }
            }
        }
    }
}

struct SliderView: View {
    var color: Color
    @Binding var value: Double
    @FocusState var isInputActive: Bool  // Переменная для отслеживания состояния фокуса

    var body: some View {
        HStack {
            // Показываем текущее значение перед слайдером
            Text("\(Int(value))")
                .frame(width: 35)  // Ограничиваем ширину текста для выравнивания
                .font(.system(size: 16))
                .foregroundColor(.white)
            
            Slider(value: $value, in: 0...255, step: 1, onEditingChanged: { _ in
                value = value.clamped(to: 0...255)  // Ограничиваем значение диапазоном
            })
            .accentColor(color)
            
            TextField("", value: $value, formatter: NumberFormatter())
                .frame(width: 50)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
                .focused($isInputActive)  // Привязываем состояние фокуса к полю ввода
                .onSubmit {
                    value = value.clamped(to: 0...255)  // Ограничиваем значение после ввода
                }
        }
        .padding(.horizontal)
    }
}

extension Comparable {
    // Расширение для ограничения значений в диапазоне
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


#Preview {
    ContentView()
}
