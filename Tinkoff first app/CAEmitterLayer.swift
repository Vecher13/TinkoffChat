//
//  CAEmitterLayer.swift
//  Tinkoff first app
//
//  Created by Ash on 29.04.2021.
//

import Foundation
import UIKit

class EmitterLayer: CAEmitterCell {
    public override init() {
         super.init()
         self.birthRate = 50
         self.lifetime = 1.0
         self.velocity = 100
         self.velocityRange = 50
         self.emissionLongitude = 90
         self.emissionRange = .pi
         self.spinRange = 5
         self.scale = 0.5
         self.scaleRange = 0.7
         self.alphaSpeed = -1
        self.contents = UIImage(named: "gerb")?.cgImage
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
}
