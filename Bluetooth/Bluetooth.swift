import Foundation
import UIKit
import SwiftUI

struct Bluetooth:UIViewControllerRepresentable {
    @Binding var press: Bool
    @State var isPress = false
    let blue : BluetoothViewController
    
    init(isPress: Binding<Bool>){
        self._press = isPress
        self.blue = BluetoothViewController()
    }
    
    func makeUIViewController(context: Context) -> BluetoothViewController {
        return blue
    }
    
    func updateUIViewController(_ uiViewController: BluetoothViewController, context: Context) {
//        blue.refresh()
    }
    
    typealias UIViewControllerType = BluetoothViewController
}
