//
//  SupportFetcher.swift
//  Supporter
//
//  Created by Jordi Bruin on 05/12/2021.
//

import Foundation

/// The class that retrieves the json data either remotely or from a local file
class SupportFetcher: ObservableObject {
    
    // TODO: Can be cleaned up to only publish SupportItems, but not sure which I like more.. If you have any suggestions, let me know!
    
    @Published var headerItems: [HeaderItem] = []
    @Published var highlightedSections: [HighlightedSection] = []
    @Published var faqSections: [FAQSection] = []
    @Published var releaseNotes: SupportReleaseNote?
    @Published var contactSections: [SupportSection] = []
    @Published var contactItems: [SupportContactItem] = []
    @Published var changelogItems: [ChangelogItem] = []
    @Published var allItems: [SupportItemable] = []
    
    @Published var retrievedSupport: Bool = false
    
    var session = URLSession.shared
    
    // If you want to  load JSON remotely, change the init to use loadAsync
    init() {
        // Internal JSON
        loadFallback()
        
        // External JSON
//        loadAsync()
    }
    
    // Load test data from bundle
    func loadFallback() {
        let items = Bundle.main.SupporterDecode(SupportItems.self, from: "Supporter.json")
        
        DispatchQueue.main.async(execute: {
            
            self.headerItems = items.headerItems ?? []
            self.highlightedSections = items.highlightedSections ?? []
            self.faqSections = items.faqSections ?? []
            self.contactSections = items.contactSections ?? []
            self.contactItems = items.contactItems ?? []
            self.releaseNotes = items.releaseNotes
            self.changelogItems = items.changelogItems ?? []
            
            self.allItems.append(contentsOf: self.headerItems)
            self.allItems.append(contentsOf: self.highlightedSections)
            
            for section in self.faqSections {
                self.allItems.append(contentsOf: section.items)
            }
            
            self.allItems.append(contentsOf: self.contactSections)
            self.retrievedSupport = true
        })
    }
    
    
    /// Load JSON data from external server
    func loadAsync() {
//        let locale = SupportLocale()
        
        let url = URL(string: "https://hiddevdploeg.github.io/nowplaying-faq/en.json")!
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                print("Error with retrieving support: \(error.localizedDescription)")
                self.loadFallback()
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                      self.loadFallback()
                      return
                  }
            
            guard let data = data else {
                self.loadFallback()
                return
            }

            do {
                let items = try JSONDecoder().decode(SupportItems.self, from: data)
                
                                
                DispatchQueue.main.async(execute: {
                    self.headerItems = items.headerItems ?? []
                    self.highlightedSections = items.highlightedSections ?? []
                    self.faqSections = items.faqSections ?? []
                    
                    self.contactSections = items.contactSections ?? []
                    self.contactItems = items.contactItems ?? []
                    
                    
                    self.releaseNotes = items.releaseNotes
                    self.changelogItems = items.changelogItems ?? []
                    self.retrievedSupport = true
                })
                
            } catch DecodingError.keyNotFound(let key, let context) {
                fatalError("Failed to decode  from bundle due to missing key '\(key.stringValue)' not found – \(context.debugDescription)")
            } catch DecodingError.typeMismatch(_, let context) {
                fatalError("Failed to decode  from bundle due to type mismatch – \(context.debugDescription)")
            } catch DecodingError.valueNotFound(let type, let context) {
                fatalError("Failed to decode  from bundle due to missing \(type) value – \(context.debugDescription)")
            } catch DecodingError.dataCorrupted(_) {
                fatalError("Failed to decode  from bundle because it appears to be invalid JSON")
            } catch {
                fatalError("Failed to decode  from bundle: \(error.localizedDescription)")
            }
        })
                
        task.resume()
    }
    
}
