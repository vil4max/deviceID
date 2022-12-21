import CommonCrypto
import Foundation

protocol DeviceTokenGenerator {
    func generate(id: String) -> String
}

extension Impl {
    struct DeviceTokenGenerator {
        private func sha256(data: Data) -> Data {
            var hash = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
            data.withUnsafeBytes {
                _ = CC_SHA256($0.baseAddress, CC_LONG(data.count), &hash)
            }
            return Data(hash)
        }
        
        private let formatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.calendar = Calendar(identifier: .iso8601)
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            formatter.dateFormat = "yyyyMMddHHmmss"
            return formatter
        }()
    }
}

extension Impl.DeviceTokenGenerator: DeviceTokenGenerator {
    func generate(id: String) -> String {
        let time = formatter.string(from: Date())
        
        let idForData = time + id
        let data = idForData.data(using: .utf8)!
        
        let secret = Data([4, 65, 22, 42, 42, 62, 137, 220, 146, 11, 153, 102, 212, 2, 195, 150, 42, 67, 201, 10, 232, 67, 177, 172,
                           79, 212, 82, 29, 118, 59, 156, 178, 42, 207, 88, 155, 85, 92, 136, 42, 132, 91, 141, 16, 19, 127, 175, 235,
                           177, 85, 28, 22, 20, 177, 251, 239, 143, 186, 68, 135, 121, 71, 189, 23, 100, 177, 212, 20, 64, 36, 156, 3,
                           117, 38, 151, 145, 138, 229, 25, 142, 83, 122, 102, 185, 168, 60, 18, 123, 100, 133, 238, 112, 202, 165,
                           183, 140, 135, 13, 91, 175, 131, 32, 172, 254, 179, 18, 253, 200, 57, 110, 107, 107, 216, 235, 171, 237,
                           153, 4, 169, 210, 17, 36, 255, 11, 215, 101, 31, 106])
        
        let sha = sha256(data: data + secret)
        let tokenData = sha + data
        
        return tokenData.base64EncodedString()
    }
}
