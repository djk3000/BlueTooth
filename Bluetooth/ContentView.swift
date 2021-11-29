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
            HStack{
                Text("本机名：")
                    .font(.system(size: 30))
                    .foregroundColor(.black)
                Text(String(model.deviceName ?? "nil"))
                    .font(.system(size: 30))
                    .foregroundColor(.black)
            }
            HStack{
                Text("最近外设蓝牙：")
                    .font(.system(size: 30))
                    .foregroundColor(.black)
                Text(model.name ?? "nil")
                    .font(.system(size: 30))
                    .foregroundColor(.black)
            }
            HStack{
                Text("最强信号强度：")
                    .font(.system(size: 30))
                    .foregroundColor(.black)
                Text(String(model.rssi ?? 0))
                    .font(.system(size: 30))
                    .foregroundColor(.black)
            }
            
            VStack{
                Text("蓝牙列表和信号强度：")
                    .font(.system(size: 30))
                    .foregroundColor(.black)
//                Text(String(model.dicString ?? "nil"))
//                    .font(.system(size: 30))
//                    .foregroundColor(.black)
                List()
            }
            
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
