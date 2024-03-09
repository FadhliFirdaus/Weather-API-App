//
//  PairedRowText.swift
//  Weather-API-APP
//
//  Created by Fadhli Firdaus on 10/03/2024.
//

import Foundation
import SwiftUI

struct PairedRowText :View {
    let left:String
    let right:String
    var body : some View {
        HStack {
            Text("\(left)")
            Spacer()
            Text("\(right)")
        }
    }
}
