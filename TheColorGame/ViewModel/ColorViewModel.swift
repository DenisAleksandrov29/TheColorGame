//
//  ColorViewModel.swift
//  TheColorGame
//
//  Created by Денис Александров on 07.09.2024.
//

import SwiftUI

class ColorViewModel: ObservableObject {
    
    enum ColorType {
        case red, green, blue
    }
    
    @Published var colorModel: ColorModel
    
    init() {
        self.colorModel = ColorModel(
            redValue: Double.random(in: 0...255),
            greenValue: Double.random(in: 0...255),
            blueValue: Double.random(in: 0...255)
        )
    }
    
    func updateColor(value: String, for color: ColorType) {
        if let newValue = Double(value), newValue >= 0, newValue <= 255 {
            switch color {
            case .red:
                colorModel.redValue = newValue
            case .green:
                colorModel.greenValue = newValue
            case .blue:
                colorModel.blueValue = newValue
            }
        }
    }
}
