//
//  NetworkMonitor.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 7/23/21.
//

import Foundation
import Network

final class NetworkMonitor: ObservableObject {
    let monitor = NWPathMonitor()
    let queue = DispatchQueue.global(qos: .background)
    
    @Published var isNotConnected: Bool = false
    
    init() {
        monitor.pathUpdateHandler = {  path in
            OperationQueue.main.addOperation {
                print("💦 \(path.status)")
                self.isNotConnected = path.status != .satisfied
            }
        }
        
        monitor.start(queue: queue)
    }
}
