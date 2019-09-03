//
//  SlideInPresentationManager.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 8/28/19.
//  Copyright © 2019 Zac Johnson. All rights reserved.
//

import UIKit

enum PresentationDirection {
	case left
	case top
	case right
	case bottom
}

class SlideInPresentationManager: NSObject {
	var direction: PresentationDirection = .bottom
}

// MARK: - UIViewControllerTransitioningDelegate
extension SlideInPresentationManager: UIViewControllerTransitioningDelegate {
	func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
		let presentationController = SlideInPresentationController(presentedViewController: presented, presenting: presenting, direction: direction)
		return presentationController
	}
}
