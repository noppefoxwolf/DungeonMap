import Testing
import Foundation
import UIKit

@Suite
struct AddressTests {
    
    @MainActor
    @Test
    func example() throws {
        let result = UIViewController()
        let address = Unmanaged.passUnretained(result).toOpaque()
        address
        let hexAddress = String(describing: address)
        print("Memory address: \(hexAddress)")
    }
}

