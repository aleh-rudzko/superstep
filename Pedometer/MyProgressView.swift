//
//  MyProgressView.swift
//  CoreMotionPost
//
//  Created by Oleg Rudko on 6/9/19.
//  Copyright © 2019 kamwysoc. All rights reserved.
//

import UIKit

class MyProgressView: UIProgressView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let maskLayerPath = UIBezierPath(roundedRect: bounds, cornerRadius: 4.0)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskLayerPath.cgPath
        layer.mask = maskLayer
    }
}
