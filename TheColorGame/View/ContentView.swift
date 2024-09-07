//
//  ContentView.swift
//  TheColorGame
//
//  Created by Денис Александров on 04.09.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ColorViewModel()
    @FocusState private var isInputActive: Bool
    
    var body: some View {
        ZStack {
            Color(red: 173/255, green: 210/255, blue: 240/255)
                .ignoresSafeArea()
            VStack {
                Rectangle()
                    .fill(Color(red: viewModel.colorModel.redValue/255,
                                green: viewModel.colorModel.greenValue/255,
                                blue: viewModel.colorModel.blueValue/255))
                    .frame(height: 150)
                    .cornerRadius(15)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.white, lineWidth: 4)
                    )
                    .padding()
                
                SliderView(color: .red, value: $viewModel.colorModel.redValue, isInputActive: _isInputActive)
                SliderView(color: .green, value: $viewModel.colorModel.greenValue, isInputActive: _isInputActive)
                SliderView(color: .blue, value: $viewModel.colorModel.blueValue, isInputActive: _isInputActive)
                
                Spacer()
            }
            .padding()
            
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture {
                    isInputActive = false
                }
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Button("Done") {
                    isInputActive = false
                }
            }
        }
    }
}

#Preview {
    ContentView()
}


