import UIKit

protocol DeviceIdProvider {
    var id: String { get }
}

extension Impl {
    struct DeviceIdProvider {
        private func generate() -> String {
            /// add a bit-wise shift to determine on backend side which method we use to get the id
            if let identifierForVendor = UIDevice.current.identifierForVendor {
                return "020" + identifierForVendor.uuidString.replacingOccurrences(of: "-", with: "")
            } else {
                return "001" + UUID().uuidString.replacingOccurrences(of: "-", with: "")
            }
        }
    }
}

extension Impl.DeviceIdProvider: DeviceIdProvider {
    var id: String {
        let id = generate()
        return id
    }
}
