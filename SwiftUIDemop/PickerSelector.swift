//
//  SwiftUIView.swift
//  SwiftUIDemop
//
//  Created by Demo on 11/06/2020.
//  Copyright © 2020 demo. All rights reserved.
//

import SwiftUI

struct CurrencySelector: View {
    var options: [String]
    @Binding var selectCurrency : Int
    var body: some View {
        VStack{
            Picker(selection: $selectCurrency, label: Text("Currency")) {
                ForEach(0 ..< options.count, id: \.self) {
                   Text(self.options[$0])
               }
            }
            //.pickerStyle(WheelPickerStyle())
        }
        
    }
}

struct SwiftUIView_Previews: PreviewProvider {
     @State static var selectCurrency = 0
    static var previews: some View {
        CurrencySelector(options: ["opt1", "opt2"], selectCurrency: $selectCurrency)
    }
}
