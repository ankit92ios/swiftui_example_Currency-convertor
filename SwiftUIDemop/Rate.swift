//
//  Rate.swift
//  SwiftUIDemop
//
//  Created by Demo on 11/06/2020.
//  Copyright © 2020 demo. All rights reserved.
//

import SwiftUI
import Foundation

let kApiKey = "39c4085acc28bb8fa924"
let kApicurrencies = "https://free.currconv.com/api/v7/currencies?apiKey=\(kApiKey)"
let kAPIConvert = "https://free.currconv.com/api/v7/convert?apiKey=\(kApiKey)&q=\(convertStr)&compact=y"
var convertStr = ""


struct CurrenciesData : Decodable {
    var results : resultsArray
}


struct resultsArray : Decodable {
//    var results : [Currency]
     var results : [String]
    private struct DynamicCodingKeys: CodingKey {

        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        var intValue: Int?
        init?(intValue: Int) {
            return nil
        }
    }

    init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: DynamicCodingKeys.self)

//           var tempArray = [Currency]()
            var tempArray = [String]()
           for key in container.allKeys {
               let decodedObject = try container.decode(Currency.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
              // tempArray.append(decodedObject)
                if(decodedObject.id != nil){
                    tempArray.append(decodedObject.id!)
                }
           }
           results = tempArray
       }
}


struct Currency: Decodable {
    let currencyName: String?
    let currencySymbol: String?
    let id : String?
}


struct Rate : Decodable {
     var results : Double?
    private struct DynamicCodingKeys: CodingKey {

        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        var intValue: Int?
        init?(intValue: Int) {
            return nil
        }
    }

    init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
           var tempArray : Double?
           for key in container.allKeys {
               let decodedObject = try container.decode(RateData.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
              // tempArray.append(decodedObject)
                if(decodedObject.val != nil){
                   tempArray = decodedObject.val
                }
           }
           results = tempArray
       }
}
struct RateData: Decodable {
    let val : Double?
}
