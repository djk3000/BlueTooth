import Foundation

class Model: ObservableObject {
    static let model = Model()
    @Published var name : String?
    @Published var rssi : Int?
    @Published var dic : [String: Int] = ["default": 1]
    @Published var dicString : String?
    @Published var deviceName : String?
}
