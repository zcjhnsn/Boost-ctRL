//
//  IAPService.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 4/10/19.
//  Copyright © 2019 Zac Johnson. All rights reserved.
//

import Foundation
import StoreKit

class IAPService: NSObject  {
	
	private override init() {}
	static let shared = IAPService() // singleton
	
	var products = [SKProduct]()
	
	func getProducts() {
		let products: Set = [IAPProduct.bronze.rawValue,
							 IAPProduct.silver.rawValue,
							 IAPProduct.gold.rawValue,
							 IAPProduct.platinum.rawValue,
							 IAPProduct.diamond.rawValue,
							 IAPProduct.champion.rawValue,
							 IAPProduct.gc.rawValue]
		
		let request = SKProductsRequest(productIdentifiers: products)
		request.delegate = self
		request.start()
	}
	
	func purchase(product)
}

extension IAPService: SKProductsRequestDelegate {
	func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
		self.products = response.products
		for product in response.products {
			print(product.localizedTitle)
		}
	}
}
