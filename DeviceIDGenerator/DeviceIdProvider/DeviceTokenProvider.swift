import Foundation

protocol DeviceTokenProvider {
    var token: String { get }
}

extension Impl {
    final class DeviceTokenProvider {
        private let idProvider: DeviceIdProvider
        private let deviceTokenGenerator: DeviceTokenGenerator

        init(idProvider: DeviceIdProvider,
             deviceTokenGenerator: DeviceTokenGenerator) {
            self.idProvider = idProvider
            self.deviceTokenGenerator = deviceTokenGenerator
        }
    }
}

extension Impl.DeviceTokenProvider: DeviceTokenProvider {
    var token: String {
        return deviceTokenGenerator.generate(id: idProvider.id)
    }
}
