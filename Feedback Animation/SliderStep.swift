//
//  SliderStep.swift
//  Feedback Animation
//
//  Created by O-mkar on 10/10/16.
//  Copyright © 2016 O-mkar. All rights reserved.
//

import UIKit

class SliderStep: UISlider {
    
    var size = CGSize(width: 80, height: 80)
    var activeImageSize = CGSize(width: 100, height: 100)
    var sliderLineHeight: Float = 4
    var sliderLineColor: UIColor = UIColor.lightGrayColor()
    var minLabelOffset:CGFloat = 0
    var maxLabelOffset:CGFloat = 10
    var activeImages: [UIImage]?
    var titleLabels: [String]?
    var bottomImages: [UIImage]?
    var unselectedFont: UIFont = UIFont(name: "Helvetica Neue", size: 13)!
    var selectedFont: UIFont = UIFont(name: "Helvetica Neue", size: 14)!
    
    private var stepTitleLabels: [UILabel]?
    private var stepbottomImages: [UIImageView]?
    
    var stepWidth: Double {
        return Double(sliderLineWidth) / Double(noOfSteps)
    }
    var sliderLineWidth: CGFloat {
        return self.bounds.size.width
    }
    var slideLineLeftOffset: CGFloat {
        let rect = rectForValue(minimumValue)
        return rect.width / 2
    }
    var slideLineRightOffset: CGFloat {
        let rect = rectForValue(maximumValue)
        return rect.width / 2
    }
    var noOfSteps: Int {
        return Int(maximumValue - minimumValue)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentMode = .Redraw
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.didTap(_:)))
        self.addGestureRecognizer(tap)
        self.addTarget(self, action: #selector(self.sliderValueChanged), forControlEvents: .ValueChanged)
        self.addTarget(self, action: #selector(self.handleTouches), forControlEvents: [.TouchUpInside, .TouchUpOutside, .TouchCancel])
        if self.value != 0.0 {
            handleTouches(true)
        }
        
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        drawLine()
        self.value = self.minimumValue
    }
    internal func didTap(gestureRecognizer: UIGestureRecognizer) {
        if self.highlighted {
            return
        }
        
        let pointTapped: CGPoint = gestureRecognizer.locationInView(self)
        let percentage = Float(pointTapped.x / sliderLineWidth)
        let delta = percentage * (maximumValue - minimumValue)
        let newValue = minimumValue + delta
        self.setValue(newValue, animated: false)
        adjustAll()
        handleTouches(true)
        
    }
    
    internal func sliderValueChanged() {
        let intValue = Int(round(self.value))
        let floatValue = Float(intValue)
        valueChanged(self.value - 1)
        setImageForValue(floatValue)
    }
    internal func handleTouches(valueChanged: Bool = false) {
        
        let intValue = Int(round(self.value))
        let floatValue = Float(intValue)
        UIView.animateWithDuration(0.6, animations: {
            self.setValue(floatValue, animated: true)
            self.setImageForValue(floatValue)
            
            },completion: { Void in
                if valueChanged == true {
                    self.sendActionsForControlEvents(.ValueChanged)
                }
                self.adjustAll()
        })
        
        
    }
    
    private func moveLabelDown(tag :Int){
        //Label Move Down
        UIView.animateWithDuration(0.3) {
            let label = self.viewWithTag(tag) as! UILabel
            if label.frame.origin.y != (self.minLabelOffset + self.maxLabelOffset)  {
                
                label.frame.origin.y = (self.minLabelOffset + self.maxLabelOffset)
            }
        }
    }
    private func moveLabelUp(tag :Int){
        //Label Move Up
        UIView.animateWithDuration(0.3) {
            let label = self.viewWithTag(tag) as! UILabel
            if label.frame.origin.y != self.minLabelOffset {
                label.frame.origin.y = self.minLabelOffset
            }
        }
    }
    private func valueChanged(value: Float){
        if value >= 1.0 && value < 1.5 {
            let view = self.viewWithTag(400) as! UIImageView
            view.transform = CGAffineTransformScale(CGAffineTransformIdentity, CGFloat(value-0.5), CGFloat(value-0.5))
            moveLabelDown(500)
        }else {
            //Image
            UIView.animateWithDuration(0.1) {
                let view = self.viewWithTag(400) as! UIImageView
                view.transform = CGAffineTransformScale(CGAffineTransformIdentity, CGFloat(1.0), CGFloat(1.0))
                
            }
            moveLabelUp(500)
        }
        if value > 1.5 && value < 2.0 {
            let view = self.viewWithTag(401) as! UIImageView
            
            view.transform = CGAffineTransformScale(CGAffineTransformIdentity, CGFloat(1.0-(value-1.5)), CGFloat(1.0-(value-1.5)))
            moveLabelDown(501)
            
        }else if value >= 2.0 && value < 2.5 {
            let view = self.viewWithTag(401) as! UIImageView
            
            view.transform = CGAffineTransformScale(CGAffineTransformIdentity, CGFloat(value-1.5), CGFloat(value-1.5))
            moveLabelDown(501)
            
        }else {
            UIView.animateWithDuration(0.1) {
                let view = self.viewWithTag(401) as! UIImageView
                view.transform = CGAffineTransformScale(CGAffineTransformIdentity, CGFloat(1.0), CGFloat(1.0))
            }
            moveLabelUp(501)
            
        }
        if value > 2.5 && value < 3.0 {
            let view = self.viewWithTag(402) as! UIImageView
            
            view.transform = CGAffineTransformScale(CGAffineTransformIdentity, CGFloat(1.0-(value-2.5)), CGFloat(1.0-(value-2.5)))
            moveLabelDown(502)
            
            
        }else if value >= 3.0 && value < 3.5 {
            let view = self.viewWithTag(402) as! UIImageView
            
            view.transform = CGAffineTransformScale(CGAffineTransformIdentity, CGFloat(value-2.5), CGFloat(value-2.5))
            moveLabelDown(502)
            
        }else {
            UIView.animateWithDuration(0.1) {
                let view = self.viewWithTag(402) as! UIImageView
                view.transform = CGAffineTransformScale(CGAffineTransformIdentity, CGFloat(1.0), CGFloat(1.0))
            }
            moveLabelUp(502)
            
        }
        
        if value > 3.5 && value < 4.0 {
            let view = self.viewWithTag(403) as! UIImageView
            
            view.transform = CGAffineTransformScale(CGAffineTransformIdentity, CGFloat(1.0-(value-3.5)), CGFloat(1.0-(value-3.5)))
            
            moveLabelDown(503)
            
        }else if value >= 4.0 && value < 4.5 {
            let view = self.viewWithTag(403) as! UIImageView
            
            view.transform = CGAffineTransformScale(CGAffineTransformIdentity, CGFloat(value-3.5), CGFloat(value-3.5))
            moveLabelDown(503)
            
            
        }else {
            UIView.animateWithDuration(0.1) {
                let view = self.viewWithTag(403) as! UIImageView
                view.transform = CGAffineTransformScale(CGAffineTransformIdentity, CGFloat(1.0), CGFloat(1.0))
            }
            moveLabelUp(503)
            
        }
        if value > 4.5 && value <= 5.0 {
            let view = self.viewWithTag(404) as! UIImageView
            
            view.transform = CGAffineTransformScale(CGAffineTransformIdentity, CGFloat(1.0-(value-4.5)), CGFloat(1.0-(value-4.5)))
            
            moveLabelDown(504)
            
        }else {
            UIView.animateWithDuration(0.1) {
                let view = self.viewWithTag(404) as! UIImageView
                view.transform = CGAffineTransformScale(CGAffineTransformIdentity, CGFloat(1.0), CGFloat(1.0))
            }
            moveLabelUp(504)
            
        }
        print(value)
        
    }
    private func adjustAll(){
        UIView.animateWithDuration(0.1) {
            for i in 0...4{
                let view = self.viewWithTag(400+i) as! UIImageView
                view.transform = CGAffineTransformScale(CGAffineTransformIdentity, CGFloat(1.0), CGFloat(1.0))
            }
        }
        
    }
    
    private func setImageForValue(value: Float) {
        if let selectionImage = imageForSliderValue(value) {
            self.setThumbImage(selectionImage, forState: UIControlState.Normal)
            self.setThumbImage(selectionImage, forState: UIControlState.Selected)
            self.setThumbImage(selectionImage, forState: UIControlState.Highlighted)
            
        }
    }
    
    private func imageForSliderValue(value: Float) -> UIImage? {
        let intValue = Int(round(value))
        let imageIndex = intValue - Int(minimumValue)
        
        if imageIndex >= 0 && activeImages?.count > imageIndex {
            return activeImages?[imageIndex]
        }
        
        return nil
    }
    
    private func rectForValue(value: Float) -> CGRect {
        let trackRect = trackRectForBounds(bounds)
        let rect = thumbRectForBounds(bounds, trackRect: trackRect, value: value)
        return rect
    }
    
    override func drawRect(rect: CGRect) {
        guard minimumValue >= 0 && maximumValue > minimumValue else {
            return
        }
        
        guard Float(Int(self.value)) == self.value else {
            return
        }
        
        guard Float(Int(minimumValue)) == minimumValue && Float(Int(maximumValue)) == maximumValue else {
            return
        }
        
        guard let images = activeImages where images.count == Int((maximumValue - minimumValue + 1)) else {
            return
        }
        
        guard titleLabels == nil || images.count == titleLabels?.count else {
            return
        }
        
        guard bottomImages == nil || bottomImages?.count == images.count else {
            return
        }
        
        guard images.count == (Int(maximumValue) - Int(minimumValue) + 1) else {
            return
        }
        
        setImageForValue(self.value)
        drawLabels()
        drawLine()
        drawBottomImages()
        if let label = self.viewWithTag(500) as? UILabel {
            minLabelOffset = label.frame.origin.y
        }
    }
    
    private func drawLabels() {
        guard let ti = titleLabels else {
            return
        }
        
        if stepTitleLabels == nil {
            stepTitleLabels = []
        }
        
        if let sl = stepTitleLabels {
            for l in sl {
                l.removeFromSuperview()
            }
            stepTitleLabels?.removeAll()
            
            for index in 0..<ti.count {
                let title = ti[index]
                let label = UILabel()
                label.font = unselectedFont
                label.text = title
                label.textAlignment = .Center
                label.sizeToFit()
                label.tag = 500+index
                let n = CGFloat(ti.count)
                let x =  (sliderLineWidth - (n * activeImageSize.width)) / (n - 1)
                var frame = label.frame
                frame.origin.x = (CGFloat(index) * (x + activeImageSize.width)) + ((activeImageSize.width/2) - (frame.size.width/2))
                frame.origin.y = bounds.midY + (bounds.size.height / 2)
                label.frame = frame
                self.addSubview(label)
                stepTitleLabels?.append(label)
            }
        }
    }
    
    private func drawBottomImages() {
        guard let tempImage = bottomImages else {
            return
        }
        
        if stepbottomImages == nil {
            stepbottomImages = []
        }
        
        if let sl = stepbottomImages {
            for l in sl {
                l.removeFromSuperview()
            }
            stepbottomImages?.removeAll()
            for index in 0..<tempImage.count {
                let img = tempImage[index]
                let imageView = UIImageView(image: img)
                imageView.contentMode = .ScaleAspectFit
                imageView.sizeToFit()
                imageView.tag = 400 + index
                let n = CGFloat(tempImage.count)
                let x =  ((sliderLineWidth) - ((n * size.width)+(activeImageSize.width - size.width))) / (n - 1)
                var frame = imageView.frame
                frame.origin.x = ((activeImageSize.width - size.width)/2) + (CGFloat(index) * (x + size.width))
                frame.origin.y = bounds.midY - (size.height / 2)
                frame.size = size
                imageView.frame = frame
                self.insertSubview(imageView, atIndex: 2)
                stepbottomImages?.append(imageView)
            }
        }
    }
    
    private func drawLine() {
        
        let ctx = UIGraphicsGetCurrentContext()
        CGContextSaveGState(ctx)
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(1, 1), false, 0.0)
        let transparentImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        setMaximumTrackImage(transparentImage, forState: .Normal)
        setMinimumTrackImage(transparentImage, forState: .Normal)
        
        CGContextSetFillColorWithColor(ctx, sliderLineColor.CGColor)
        let x = slideLineLeftOffset
        let y = bounds.midY - CGFloat(sliderLineHeight / 2)
        let rect = CGRect(x: x, y: y, width: bounds.width - slideLineLeftOffset - slideLineRightOffset, height: CGFloat(sliderLineHeight))
        let trackPath = UIBezierPath(rect: rect)
        
        CGContextAddPath(ctx, trackPath.CGPath)
        CGContextFillPath(ctx)
        CGContextRestoreGState(ctx)
    }
    
    
    
}
