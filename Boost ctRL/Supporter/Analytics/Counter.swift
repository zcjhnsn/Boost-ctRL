//
//  Counter.swift
//  Supporter
//
//  Created by Jordi Bruin on 05/12/2021.
//

import Foundation
import CoreMedia

/// This handles the private analytics. When a user triggers an event, a +1 is added to a counter. You can replace this with your own analytics if you want.
struct Counter {
    
    func hit(_ option: CounterOption) {
        return;
        
        // Turned off by default
        //        guard let url = URL(string: "https://api.countapi.xyz/hit/snoozesupport.sample/\(option.stringValue())") else { return }
        //        let request = URLRequest(url: url)
        //        URLSession.shared.dataTask(with: request) { _, _, _ in }.resume()
        //        print("📊 \(option.stringValue()) ")
    }
    
    func get(_ option: CounterOption) async -> Int {
        guard let url = URL(string: "https://api.countapi.xyz/get/snoozesupport.sample/\(option.stringValue())") else { return 0
        }
        
        do {
            if #available(iOS 15.0, *) {
                let (data, _) = try await URLSession.shared.data(from: url)
                
                do {
                    // Parse the JSON data
                    let result = try JSONDecoder().decode([String: Int].self, from: data)
                    print(result.values)
                    if let single = result.values.first {
                        return single
                    }
                } catch {

                    return 0
                }
            } else {
                return 0
            }
            
        } catch {
            print(error.localizedDescription)
            return 0
        }
        
        return 0
    }
}


enum CounterOption: Hashable {
      
    static var normal: [CounterOption] {
        return [.support]
    }
    
    static var supportItems: [CounterOption] {
        let ids: [CounterOption] = (0...20).map( { .openedSupport($0)})
        return ids
    }
    
    
    case support
    case openedSupport(Int)
    
    func stringValue() -> String {
        switch self {
        case .support:
            return "support"
        case .openedSupport(let id):
            return "openedSupportId\(id)"
        }
    }
}
