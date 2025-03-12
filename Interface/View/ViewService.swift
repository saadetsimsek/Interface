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
        
        gradient.locations = [-0.3, 0.4] // gradiend show ratio
        
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
        
        card.clipsToBounds = true
        return card
    }
    
    func createCardImage(image: UIImage) -> UIImageView {
        let images = UIImageView()
        images.image = image
        images.translatesAutoresizingMaskIntoConstraints = false
        images.widthAnchor.constraint(equalToConstant: 27).isActive = true
        images.heightAnchor.constraint(equalToConstant: 27).isActive = true
        return images
    }
    
    func creareCardTitle(title: String) -> UILabel{
        let label = UILabel()
        label.text = title
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }
    
    func createRateStackView(reate: Float) -> UIStackView {
        let rateStackView = {
            let stack = UIStackView()
            stack.alignment = .center
            stack.axis = .horizontal
            stack.distribution = .fillEqually
            stack.alignment = .leading
            stack.spacing = 2
            return stack
        }()
        //STAR
        let rateImage = UIImageView()
        rateImage.image = UIImage(named: "star.fill")
        rateImage.translatesAutoresizingMaskIntoConstraints = false
        rateImage.tintColor = .white
    //    rateImage.contentMode = .scaleAspectFill ?
     //   rateImage.clipsToBounds = true ?
        
        rateImage.widthAnchor.constraint(equalToConstant: 10).isActive = true
        rateImage.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
        //RATE
        let rateLabel = UILabel()
        rateLabel.text = "\(reate)"
        rateLabel.textColor = .white
        rateLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        
        rateStackView.addArrangedSubview(rateImage)
        rateStackView.addArrangedSubview(rateLabel)
        return rateStackView
    }
    
    func getViewLabel(views: Int) -> UILabel {
        let label = UILabel()
        label.text = "\(views) views"
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textColor = .white
        return label
    }
    
    func getSideStack(items: [UIView]) -> UIStackView {
        
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 17
        stack.alignment = .fill
        
        items.forEach{ // sıranın her elemanını al bunu uygula
            stack.addArrangedSubview($0)
        }
        
        return stack
    }
}
