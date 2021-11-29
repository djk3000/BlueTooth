//
//  ContentView.swift
//  Bluetooth
//
//  Created by ruanjianyingyongbu on 2021/11/16.
//

import SwiftUI

struct ContentView: View {
    @State private var isPresented = false
    @ObservedObject var model = Model.model
    
    var body: some View {
        VStack (alignment: .center){
            
            Text(model.name ?? "nil")
                .font(.system(size: 30))
                .foregroundColor(.black)
            
            Text(String(model.rssi ?? 0))
                .font(.system(size: 30))
                .foregroundColor(.black)
            
            Text(String(model.deviceName ?? "nil"))
                .font(.system(size: 30))
                .foregroundColor(.black)
            
            Bluetooth(isPress: $isPresented)
            
        }
        .frame(minWidth: 0, idealWidth: 0, maxWidth: .infinity, minHeight: 0, idealHeight: .infinity, maxHeight: .infinity)
        .onAppear(perform: {
            getDevice()
        })
    }
    
    func getDevice() {
        model.deviceName = UIDevice.current.name
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
