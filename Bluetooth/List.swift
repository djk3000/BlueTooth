//
//  List.swift
//  Bluetooth
//
//  Created by ruanjianyingyongbu on 2021/11/29.
//

import SwiftUI

struct List: View {
    @ObservedObject var model = Model.model
//    @State var dict: [String: Int] = ["test1": 1, "test2": 2, "test3": 3]
    
    var body: some View {
        let keys = model.dic.map{$0.key}
        let values = model.dic.map {$0.value}
        
        return ForEach(keys.indices, id: \.self) {index in
            HStack {
                Text(keys[index])
                Text("\(values[index])")
            }
        }
    }
}

struct List_Previews: PreviewProvider {
    static var previews: some View {
        List()
    }
}
