//
//  SlideInPresentationController.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 8/28/19.
//  Copyright © 2019 Zac Johnson. All rights reserved.
//

import UIKit

class SlideInPresentationController: UIPresentationController {
	// MARK: - Properties
	private var dimmingView: UIView!
	private var direction: PresentationDirection
	
	override var frameOfPresentedViewInContainerView: CGRect {
		//1
		var frame: CGRect = .zero
		frame.size = size(forChildContentContainer: presentedViewController,
						  withParentContainerSize: containerView!.bounds.size)
		
		//2
		switch direction {
		case .right:
			frame.origin.x = containerView!.frame.width*(1.0/3.0)
		case .bottom:
			frame.origin.y = containerView!.frame.height / 2.0
		default:
			frame.origin = .zero
		}
		return frame
	}
	
	init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?, direction: PresentationDirection) {
		self.direction = direction
		
		super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
		
		setupDimmingView()
	}
	
	override func presentationTransitionWillBegin() {
		guard let dimmingView = dimmingView else {
			return
		}

		if let container = containerView {
			container.insertSubview(dimmingView, at: 0)
		}
		//containerView?.insertSubview(dimmingView, at: 0)
		
		NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[dimmingView]|", options: [], metrics: nil, views: ["dimmingView": dimmingView]))
		NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[dimmingView]|", options: [], metrics: nil, views: ["dimmingView": dimmingView]))
		
		guard let coordinator = presentedViewController.transitionCoordinator else {
			dimmingView.alpha = 1.0
			return
		}
		
		coordinator.animate(alongsideTransition: { _ in
			self.dimmingView.alpha = 1.0
		})
	}
	
	override func dismissalTransitionWillBegin() {
		guard let coordinator = presentedViewController.transitionCoordinator else {
			dimmingView.alpha = 0.0
			return
		}
		
		coordinator.animate(alongsideTransition: { _ in
			self.dimmingView.alpha = 0.0
		})
	}
	
	override func containerViewWillLayoutSubviews() {
		presentedView?.frame = frameOfPresentedViewInContainerView
	}
	
	override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
		switch direction {
		case .left, .right:
			return CGSize(width: parentSize.width*(2.0/3.0), height: parentSize.height)
		case .bottom, .top:
			return CGSize(width: parentSize.width, height: parentSize.height*(2.0/3.0))
		}
	}
}

// MARK: - Private
private extension SlideInPresentationController {
	func setupDimmingView() {
		dimmingView = UIView()
		dimmingView.translatesAutoresizingMaskIntoConstraints = false
		dimmingView.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
		dimmingView.alpha = 0.0
		
		let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
		dimmingView.addGestureRecognizer(recognizer)
	}
	
	@objc func handleTap(recognizer: UITapGestureRecognizer) {
		presentingViewController.dismiss(animated: true)
	}
}
