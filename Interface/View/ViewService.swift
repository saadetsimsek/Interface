//
//  ViewService.swift
//  Interface
//
//  Created by Saadet Şimşek on 07/03/2025.
//

import UIKit

class ViewService {
    static let shared = ViewService()
    
    private init(){ }
    
    func gradientLayer(startColor: UIColor?, endColor: UIColor? = UIColor(hex: "#565C87FF"), frame: CGRect = CGRect(x: 0, y: 0, width: 200, height: 200)) -> CAGradientLayer {
        
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = [
            startColor?.cgColor ?? UIColor.white.cgColor,
            endColor?.cgColor ?? UIColor.white.cgColor
        ]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        
        gradient.locations = [-0.3, 0.3]
        
        return gradient
    }
    
    func createCardView(gradientColor: String, width w: CGFloat) -> UIView{
        let card = UIView()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.widthAnchor.constraint(equalToConstant: w).isActive = true
        card.layer.cornerRadius = 25
        card.layer.cornerCurve = .continuous
        
        let gradient = gradientLayer(startColor: UIColor(hex: gradientColor))
        card.layer.addSublayer(gradient)
        return card
    }
    
    
}
