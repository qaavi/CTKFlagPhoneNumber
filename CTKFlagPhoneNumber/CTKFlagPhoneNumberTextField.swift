//
//  LinearProgressBar.swift
//  CookMinute
//
//  Created by Philippe Boisney on 18/11/2015.
//  Copyright © 2015 CookMinute. All rights reserved.
//
//  Google Guidelines: https://www.google.com/design/spec/components/progress-activity.html#progress-activity-types-of-indicators
//

import UIKit

open class LinearProgressBar: UIView {
    
    //FOR DATA
    fileprivate var screenSize: CGRect = UIScreen.main.bounds
    
    
    fileprivate var isAnimationRunning = false
    fileprivate var progressX: Int!
    
    //FOR DESIGN
    fileprivate var progressBarIndicator: UIView!
    
    //PUBLIC VARS
    open var backgroundProgressBarColor: UIColor = UIColor(red:0.73, green:0.87, blue:0.98, alpha:1.0)
    @objc open var progressBarColor: UIColor = UIColor(red:0.12, green:0.53, blue:0.90, alpha:1.0)
    open var heightForLinearBar: CGFloat = 5
    @objc open var widthForLinearBar: CGFloat = 0
    
    public init () {
        super.init(frame: CGRect(x: 0, y: 20, width: screenSize.width, height: 0))
        self.progressBarIndicator = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: heightForLinearBar))
    }
    
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.progressBarIndicator = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: heightForLinearBar))
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: LIFE OF VIEW
    override open func layoutSubviews() {
        super.layoutSubviews()
        self.screenSize = UIScreen.main.bounds
        
        if widthForLinearBar == 0 || widthForLinearBar == self.screenSize.height {
            widthForLinearBar = self.screenSize.width
        }
        
        if (UIDeviceOrientationIsLandscape(UIDevice.current.orientation)) {
            self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: widthForLinearBar, height: self.frame.height)
        }
        
        if (UIDeviceOrientationIsPortrait(UIDevice.current.orientation)) {
            self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: widthForLinearBar, height: self.frame.height)
        }
    }
    
    //MARK: PUBLIC FUNCTIONS    ------------------------------------------------------------------------------------------
    
    //Start the animation
    @objc open func startAnimation() {
        
        
        self.configureColors()
        
        
        if !isAnimationRunning {
            
            self.isAnimationRunning = true
            
            UIView.animate(withDuration: 0, delay:0, options: [], animations: {
                
                self.frame = CGRect(x: 0, y: self.frame.origin.y, width: self.widthForLinearBar, height: self.heightForLinearBar)
                
                }, completion: { animationFinished in
                    
                    self.addSubview(self.progressBarIndicator)
                    self.configureAnimation()
                    
            })
        }
        
    }
    
    //Start the animation
    @objc open func stopAnimation() {
        
        self.isAnimationRunning = false
        
        UIView.animate(withDuration: 0.5, animations: {
            self.progressBarIndicator.frame = CGRect(x: 0, y: 0, width: self.widthForLinearBar, height: 0)
            self.frame = CGRect(x: 0, y: self.frame.origin.y, width: self.widthForLinearBar, height: 0)
            
        })
        
    }
    
    //Start progress animation
    @objc open func startProgressAnimation() {
        
        self.progressX = 0
        self.configureColors()
        
        
        if !isAnimationRunning {
            
            self.isAnimationRunning = true
            
            UIView.animate(withDuration: 0, delay:0, options: [], animations: {
                
                self.frame = CGRect(x: 0, y: self.frame.origin.y, width: self.widthForLinearBar, height: self.heightForLinearBar)
                
            }, completion: { animationFinished in
                
                self.addSubview(self.progressBarIndicator)
                self.configureProgressAnimation()
                
            })
        }
        
    }
    
    //Start the animation
    @objc open func stopProgressAnimation() {
        
        self.isAnimationRunning = false
        
        UIView.animate(withDuration: 0.1, animations: {
            self.progressBarIndicator.frame = CGRect(x: 0, y: 0, width: self.widthForLinearBar, height: 0)
            self.frame = CGRect(x: 0, y: self.frame.origin.y, width: self.widthForLinearBar, height: 0)
            
            self.progressBarIndicator.backgroundColor = UIColor.clear
            
        })
        
    }
    
    //MARK: PRIVATE FUNCTIONS    ------------------------------------------------------------------------------------------
    
    fileprivate func configureColors() {
        
        self.backgroundColor = self.backgroundColor
        self.progressBarIndicator.backgroundColor = self.progressBarColor
    }
    
    fileprivate func configureAnimation() {
        
        self.progressBarIndicator.frame = CGRect(x: 0, y: 0, width: 0, height: heightForLinearBar)
        
        UIView.animate(withDuration: 0.5, delay:0, options: [], animations: {
            
            
            self.progressBarIndicator.frame = CGRect(x: 0, y: 0, width: self.widthForLinearBar * 0.7, height: self.heightForLinearBar)
            
            }, completion: nil)
        
        UIView.animate(withDuration: 0.4, delay:0.4, options: [], animations: {
            
            self.progressBarIndicator.frame = CGRect(x: self.frame.width, y: 0, width: 0, height: self.heightForLinearBar)
            
            }, completion: { animationFinished in
                
                if (self.isAnimationRunning) {
                    self.configureAnimation()
                }
        })
        
    }
    
    fileprivate func configureProgressAnimation() {
        
        self.progressBarIndicator.frame = CGRect(x: progressX, y: 0, width: Int(self.widthForLinearBar * 0.2), height: Int(heightForLinearBar))
        
        UIView.animate(withDuration: 0.8, delay:0, options: [], animations: {
            
            
            self.progressBarIndicator.frame = CGRect(x: Int(self.progressX + Int(self.widthForLinearBar * 0.2)), y: 0, width: Int(self.widthForLinearBar * 0.2), height: Int(self.heightForLinearBar))
            
        }, completion: nil)
        
        UIView.animate(withDuration: 1.0, delay:0.4, options: [], animations: {
            
            if (self.progressX >= Int(self.frame.width)) {
                self.progressX = Int(self.widthForLinearBar * 0.2) * -1
            } else {
                self.progressX = self.progressX + Int(self.widthForLinearBar * 0.2)
            }
            self.progressBarIndicator.frame = CGRect(x: Int(self.progressX), y: 0, width: Int(self.widthForLinearBar * 0.2), height: Int(self.heightForLinearBar))
            
        }, completion: { animationFinished in
            
            if (self.isAnimationRunning) {
                
                self.configureProgressAnimation()
            }
        })
        
    }
    
}
