//
//  DebugUtils.swift
//  Weather-API-APP
//
//  Created by Fadhli Firdaus on 09/03/2024.
//

import Foundation
import SwiftUI

func d(_ any:Any){
    print(any)
}

func d(_ key:Any, _ any:Any){
    print(any)
}

extension View {
    func debugRed() -> some View {
        self.background(Color.red)
    }
    
    func debugBlue() -> some View {
        self.background(Color.blue)
    }
    
    func debugYellow() -> some View {
        self.background(Color.yellow)
    }
    
    func debugYellow(color:Color) -> some View {
        self.background(color)
    }
}
