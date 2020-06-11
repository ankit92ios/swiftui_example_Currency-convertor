//
//  CardView.swift
//  SwiftUIDemop
//
//  Created by Demo on 10/06/2020.
//  Copyright © 2020 demo. All rights reserved.
//

import SwiftUI

struct CardView: View {
     var data = ["a","b","a","b"]
    var body: some View {
        VStack {
            HStack.init(alignment: .top, spacing: 0.0) {
                Text("My Balance")
                Spacer()
                Text("RM 1,500.00 ")
                Image("Group 10301").resizable().aspectRatio(contentMode: .fill).frame(width: 24, height: 24, alignment: .center)
                
                
            }
            HStack.init(alignment: .center, spacing: 0.0) {
                Text("My Silver and Gold Coins")
                Spacer()
                Text("157 ")
                Image("Group 8846").resizable().aspectRatio(contentMode: .fill).frame(width: 24, height: 24, alignment: .center)
                Text(" / 330 ")
                Image("Group 8845").resizable().aspectRatio(contentMode: .fill).frame(width: 24, height: 24, alignment: .center)
            }
           
            HStack.init(alignment: .center){
                
               
                ForEach(data, id: \.self) { item in
                    Button(action: {
                        print("first button")
                    }) {
                        VStack {
                            Image( uiImage: UIImage(named: "Group 10306")!)
                                .renderingMode(
                                .original)
                                .font(.title)
                                .foregroundColor(
                                .black)
                               Text("Transfer")
                        }
                            .fixedSize(horizontal: true, vertical: true)
                            .frame(minWidth: 0,
                            maxWidth: .infinity,
                            minHeight: 0,
                            maxHeight: 70)
                        }
                    .foregroundColor(Color.white)
                    .background(Color.red)
                }
             
            }
            
            }
        .padding()
        .background(Color.red)
        .cornerRadius(15.0)
        .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fit/*@END_MENU_TOKEN@*/)
        .shadow(color: .black, radius: 15.0, x: -0.5, y:-0.5)
        
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
         CardView().previewDevice(PreviewDevice(rawValue: "iPhone SE"))
        
//       Group {
//         CardView().previewDevice(PreviewDevice(rawValue: "iPhone SE"))
//         CardView().previewDevice(PreviewDevice(rawValue: "iPhone XS Max"))
//        
//        CardView().previewDevice(PreviewDevice(rawValue: "iPhone 11"))
//        }
    }
}
