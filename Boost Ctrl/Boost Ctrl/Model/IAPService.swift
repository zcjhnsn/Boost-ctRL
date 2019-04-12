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
	
	let paymentQueue = SKPaymentQueue.default()
	
	func getProducts() {
		let products: Set = [IAPProduct.prospect.rawValue,
							 IAPProduct.challenger.rawValue,
							 IAPProduct.star.rawValue,
							 IAPProduct.champion.rawValue,
							 IAPProduct.gc.rawValue]
		
		let request = SKProductsRequest(productIdentifiers: products)
		request.delegate = self
		request.start()
		paymentQueue.add(self)
	}
	
	func purchase(product: IAPProduct) {
		guard let productToPurchase = products.filter({ $0.productIdentifier == product.rawValue }).first else { return }
		
		let payment = SKPayment(product: productToPurchase)
		
		paymentQueue.add(payment)
	}
	
	func restorePurchases() {
		print("Restoring purchases")
		paymentQueue.restoreCompletedTransactions()
	}
}

extension IAPService: SKProductsRequestDelegate {
	func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
		self.products = response.products
		for product in response.products {
			print(product.localizedTitle)
		}
	}
}

extension IAPService: SKPaymentTransactionObserver {
	func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
		for transaction in transactions {
			print(transaction.transactionState.status(), transaction.payment.productIdentifier)
			
			switch transaction.transactionState {
			case .purchasing:
				break
			default:
				queue.finishTransaction(transaction)
			}
		}
	}
}

extension SKPaymentTransactionState {
	func status() -> String {
		switch self  {
		case .deferred:
			return "deferred"
		case .failed:
			return "failed"
		case .purchased:
			return "purchased"
		case .purchasing:
			return "purchasing"
		case .restored:
			return "restored"
		}
	}
}
