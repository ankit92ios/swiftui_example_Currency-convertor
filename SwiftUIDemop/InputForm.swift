//
//  InputForm.swift
//  SwiftUIDemop
//
//  Created by Demo on 11/06/2020.
//  Copyright © 2020 demo. All rights reserved.
//

import SwiftUI

struct InputForm: View {
    @State var currency  = ["MYR", "INR", "USD", "AED", "CAD"]
    @State private var selectToCurrency = 0
    @State private var selectFromCurrency = 0
    @State private var fromAmount = "0.0"
    @State private var TotalAmount = "0.0"
    @State private var errMsg = ""
    private var errTitle = "Conversion App"
    @State private var isError : Bool = false
    
    var errorActionSheet : ActionSheet {
        ActionSheet.init(title: Text(errTitle), message: Text(errMsg), buttons: [
                    .default(Text("Ok")),
                    .destructive(Text("Cancel"))
            ])
    }
    
    var errorAlert : Alert {
        Alert.init(title: Text(errTitle), message: Text(errMsg), dismissButton: .destructive(Text("Cancel")))
    }
    
    var body: some View {
        VStack {
            
            NavigationView {
                Form {
                    Section(header: Text("Enter Amount From")) {
                         TextField("Amount", text: $fromAmount)
                                               CurrencySelector( options : currency, selectCurrency: $selectFromCurrency)
                    }
                    
                    Section(header: Text("Select Currency")) {
                         CurrencySelector( options : currency, selectCurrency: $selectToCurrency)
                    }
                   
                }.navigationBarTitle(Text("Converter"))
                  
            }
            Text("Amount: \(TotalAmount) \(currency[selectToCurrency])")
            Spacer()
            Button(action:{
                self.convertAction()
            }) {
                Text("Convert")
            }
            .alert(isPresented: $isError) {
                self.errorAlert
            }
            
//            .actionSheet(isPresented: $isError) {
//                self.errorActionSheet
//            }
//
            
        }.onAppear {
            self.loadData()
        }
       
    }
    
    func convertAction(){
        if(Double(fromAmount) != nil){
            if(Double(fromAmount) == 0.0){
                self.errMsg = "Amount must be more than 0"
                self.isError = true
               
            }else{
                self.convertData()
            }
        }else{
            self.errMsg = "Amount must be a number"
            self.isError = true
        }
    }
    
    func loadData(){
        guard let url = URL(string: kApicurrencies) else {
            print("Invalid URL")
            return
        }
         let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {

                    if let decodedResponse = try? JSONDecoder().decode(CurrenciesData.self, from: data) {
                        DispatchQueue.main.async {
                            // update our UI
                            dump(decodedResponse.results.results)
                            
                            self.currency = decodedResponse.results.results.sorted{ $0 < $1 }
                        }
                       
                        return
                    }
                     print("JSON not decoded")
                }
                print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
            }.resume()
        
    }
    
    func convertData(){
        convertStr = "\(currency[selectFromCurrency])_\(currency[selectToCurrency])"
        guard let url = URL(string: kAPIConvert) else {
            print("Invalid URL")
            return
        }
         let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {

                    if let decodedResponse = try? JSONDecoder().decode(Rate.self, from: data) {
                        DispatchQueue.main.async {
                            // update our UI
                           // dump(decodedResponse.results)
                            self.TotalAmount = String.init(format: "%.2f", decodedResponse.results!)
                        }
                       
                        return
                    }
                     print("JSON not decoded")
                }
                print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
            }.resume()
        
    }
}

struct InputForm_Previews: PreviewProvider {
    static var previews: some View {
        InputForm().navigationBarTitle("Conversion")
    }
}


