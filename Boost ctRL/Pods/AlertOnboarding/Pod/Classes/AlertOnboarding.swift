//
//  AlertOnboarding.swift
//  AlertOnboarding
//
//  Created by Philippe on 26/09/2016.
//  Copyright © 2016 CookMinute. All rights reserved.
//

import UIKit

@objc public protocol AlertOnboardingDelegate {
    func alertOnboardingSkipped(_ currentStep: Int, maxStep: Int)
    func alertOnboardingCompleted()
    func alertOnboardingNext(_ nextStep: Int)
    
    @objc optional func alertOnboardingDidDisplayStep(alertOnboarding: AlertOnboarding, alertChildPageViewController: AlertChildPageViewController, step: Int)
}

open class AlertOnboarding: UIView, AlertPageViewDelegate {
    
    //FOR DATA  ------------------------
    fileprivate var arrayOfAlerts = [Alert]()
    
    //FOR DESIGN    ------------------------
    open var buttonBottom: UIButton!
    fileprivate var container: AlertPageViewController!
    open var background: UIView!
    
    
    //PUBLIC VARS   ------------------------
    @objc open var colorForAlertViewBackground: UIColor = UIColor.white
    
    @objc open var colorButtonBottomBackground: UIColor = UIColor(red: 226/255, green: 237/255, blue: 248/255, alpha: 1.0)
    @objc open var colorButtonText: UIColor = UIColor(red: 118/255, green: 125/255, blue: 152/255, alpha: 1.0)
    
    @objc open var colorTitleLabel: UIColor = UIColor(red: 171/255, green: 177/255, blue: 196/255, alpha: 1.0)
    @objc open var colorDescriptionLabel: UIColor = UIColor(red: 171/255, green: 177/255, blue: 196/255, alpha: 1.0)
    
    @objc open var fontTitleLabel: UIFont? = UIFont(name: "Avenir-Heavy", size: 17);
    @objc open var fontDescriptionLabel: UIFont? = UIFont(name: "Avenir-Book", size: 13);
    @objc open var fontButtonText: UIFont? = UIFont(name: "Avenir-Black", size: 15);
    
    @objc open var colorPageIndicator = UIColor(red: 171/255, green: 177/255, blue: 196/255, alpha: 1.0)
    @objc open var colorCurrentPageIndicator = UIColor(red: 118/255, green: 125/255, blue: 152/255, alpha: 1.0)
    
    open var heightForAlertView: CGFloat!
    open var widthForAlertView: CGFloat!
    
    @objc open var percentageRatioHeight: CGFloat = 0.8
    @objc open var percentageRatioWidth: CGFloat = 0.8
    
    @objc open var nextInsteadOfSkip = false
    
    @objc open var titleNextButton = "NEXT"
    @objc open var titleSkipButton = "SKIP"
    @objc open var titleGotItButton = "GOT IT !"
    
    @objc open var delegate: AlertOnboardingDelegate?
    
    @objc public init (arrayOfAlerts: [Alert]) {
        super.init(frame: CGRect(x: 0,y: 0,width: 0,height: 0))
        self.configure()
        self.arrayOfAlerts = arrayOfAlerts
        
        self.interceptOrientationChange()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
    }
    
    //-----------------------------------------------------------------------------------------
    // MARK: PUBLIC FUNCTIONS    --------------------------------------------------------------
    //-----------------------------------------------------------------------------------------
    
    @objc open func show() {
        
        //Update Color
        self.buttonBottom.backgroundColor = colorButtonBottomBackground
        self.backgroundColor = colorForAlertViewBackground
        self.buttonBottom.setTitleColor(colorButtonText, for: UIControl.State())
        self.buttonBottom.setTitle(self.titleSkipButton, for: UIControl.State())
        
        self.container = AlertPageViewController(arrayOfAlerts: arrayOfAlerts, alertView: self)
        self.container.delegate = self
        self.insertSubview(self.container.view, aboveSubview: self)
        self.insertSubview(self.buttonBottom, aboveSubview: self)
        
        // Only show once
        if self.superview != nil {
            return
        }
        
        // Find current stop viewcontroller
        if let topController = getTopViewController() {
            let superView: UIView = topController.view
            superView.addSubview(self.background)
            superView.addSubview(self)
            self.configureConstraints(topController.view)
            self.animateForOpening()
        }
    }
    
    //Hide onboarding with animation
    @objc open func hide(){
        self.checkIfOnboardingWasSkipped()
        DispatchQueue.main.async { () -> Void in
            self.animateForEnding()
        }
    }
    
    
    //------------------------------------------------------------------------------------------
    // MARK: PRIVATE FUNCTIONS    --------------------------------------------------------------
    //------------------------------------------------------------------------------------------
    
    //MARK: Check if onboarding was skipped
    fileprivate func checkIfOnboardingWasSkipped(){
        let currentStep = self.container.currentStep
        if currentStep < (self.container.arrayOfAlerts.count - 1) && !self.container.isCompleted {
            self.delegate?.alertOnboardingSkipped(currentStep, maxStep: self.container.maxStep)
        }
        else {
            self.delegate?.alertOnboardingCompleted()
        }
    }
    
    
    //MARK: FOR CONFIGURATION    --------------------------------------
    fileprivate func configure() {
        self.buttonBottom = UIButton(frame: CGRect(x: 0,y: 0, width: 0, height: 0))
        self.buttonBottom.titleLabel?.font = fontButtonText
        self.buttonBottom.addTarget(self, action: #selector(AlertOnboarding.onClick), for: .touchUpInside)
        
        self.background = UIView(frame: CGRect(x: 0,y: 0, width: 0, height: 0))
        self.background.backgroundColor = UIColor.black
        self.background.alpha = 0.5
        
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
    }
    
    
    fileprivate func configureConstraints(_ superView: UIView) {
        removeConstraints(constraints)
        buttonBottom.removeConstraints(buttonBottom.constraints)
        container.view.removeConstraints(container.view.constraints)
        
        equal(width: superView.widthAnchor, widthMultiplier: percentageRatioWidth,
              height: superView.heightAnchor, heightMultiplier: percentageRatioHeight)
        anchorCenterSuperview()
        
        buttonBottom.equal(width: widthAnchor, height: heightAnchor, heightMultiplier: 0.1)
        buttonBottom.anchor(bottom: bottomAnchor)
        buttonBottom.anchorCenterXToSuperview()
        
        //Constraints for container
        container.view.equal(width: widthAnchor, height: heightAnchor, heightMultiplier: 0.9)
        container.view.anchor(top: topAnchor)
        container.view.anchorCenterXToSuperview()
        
        //Constraints for background
        background.fillSuperview()
    }
    
    //MARK: FOR ANIMATIONS ---------------------------------
    fileprivate func animateForOpening(){
        self.alpha = 1.0
        self.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
        UIView.animate(withDuration: 1, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: nil)
    }
    
    fileprivate func animateForEnding(){
        UIView.animate(withDuration: 0.2, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.alpha = 0.0
            }, completion: {
                (finished: Bool) -> Void in
                // On main thread
                DispatchQueue.main.async {
                    () -> Void in
                    self.background.removeFromSuperview()
                    self.removeFromSuperview()
					self.container.removeFromParentViewController()
                    self.container.view.removeFromSuperview()
                }
        })
    }
    
    //MARK: BUTTON ACTIONS ---------------------------------
    
    @objc func onClick(){
        if (nextInsteadOfSkip) {
            if let viewController = self.container.viewControllerAtIndex((self.container.pageController.viewControllers?[0] as! AlertChildPageViewController).pageIndex!-1)
            {
                self.container.pageController.setViewControllers([viewController], direction: UIPageViewController.NavigationDirection.forward, animated: true, completion: nil)
                self.container.didMoveToPageIndex(pageIndex: (viewController as! AlertChildPageViewController).pageIndex)
                
                return;
            }
        }
        
        self.hide()
    }
    
    //MARK: ALERTPAGEVIEWDELEGATE    --------------------------------------
    
    func nextStep(_ step: Int) {
        self.delegate?.alertOnboardingNext(step)
    }
    
    //MARK: OTHERS    --------------------------------------
    fileprivate func getTopViewController() -> UIViewController? {
        var topController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController
        while topController?.presentedViewController != nil {
            topController = topController?.presentedViewController
        }
        return topController
    }
    
    //MARK: NOTIFICATIONS PROCESS ------------------------------------------
    fileprivate func interceptOrientationChange(){
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
		NotificationCenter.default.addObserver(self, selector: #selector(AlertOnboarding.onOrientationChange), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
		
    }
    
    @objc func onOrientationChange(){
        if let superview = self.superview {
            self.configureConstraints(superview)
            self.container.configureConstraintsForPageControl()
        }
    }
}

extension UIView {
    
    func fillSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
            rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true
            topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
            bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
        }
    }
    
    func anchorCenterXToSuperview(constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let anchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        }
    }
    
    func anchorCenterYToSuperview(constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let anchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        }
    }
    
    func anchorCenterSuperview() {
        anchorCenterXToSuperview()
        anchorCenterYToSuperview()
    }
    
    func anchor(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        
        _ = anchorWithReturnAnchors(top, left: left, bottom: bottom, right: right, topConstant: topConstant, leftConstant: leftConstant, bottomConstant: bottomConstant, rightConstant: rightConstant, widthConstant: widthConstant, heightConstant: heightConstant)
    }
    
    func anchorWithReturnAnchors(_ top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        
        var anchors = [NSLayoutConstraint]()
        
        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant))
        }
        
        if let left = left {
            anchors.append(leftAnchor.constraint(equalTo: left, constant: leftConstant))
        }
        
        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant))
        }
        
        if let right = right {
            anchors.append(rightAnchor.constraint(equalTo: right, constant: -rightConstant))
        }
        
        if widthConstant > 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: widthConstant))
        }
        
        if heightConstant > 0 {
            anchors.append(heightAnchor.constraint(equalToConstant: heightConstant))
        }
        
        anchors.forEach({$0.isActive = true})
        
        return anchors
    }
    
    func equal(width: NSLayoutDimension? = nil, widthMultiplier: CGFloat? = 1.0, height: NSLayoutDimension? = nil, heightMultiplier: CGFloat? = 1.0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let width = width {
            widthAnchor.constraint(equalTo: width, multiplier: widthMultiplier!).isActive = true
        }
        if let height = height {
            heightAnchor.constraint(equalTo: height, multiplier: heightMultiplier!).isActive = true
        }
    }
}
