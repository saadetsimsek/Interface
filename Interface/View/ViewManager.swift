//
//  ViewManager.swift
//  Interface
//
//  Created by Saadet Şimşek on 07/03/2025.
//

import UIKit

class ViewManager {
    
    var controller: UIViewController
    var view = UIView()
    private let viewService = ViewService.shared
    private var headerStackView = UIStackView()
    
    init(controller: UIViewController, view: UIView = UIView()) {
        self.controller = controller
        self.view = controller.view
    }
    
    func createAppHeader(title: String){
        headerStackView = {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.distribution = .equalSpacing
            stack.alignment = .center
            stack.translatesAutoresizingMaskIntoConstraints = false
            return stack
        }()
        
        var headerLabel: UILabel {
            let label = UILabel()
            label.text = title
            label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            label.textColor = .white
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0
            return label
        }
        
        let headerButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.widthAnchor.constraint(equalToConstant: 31).isActive = true
            button.heightAnchor.constraint(equalToConstant: 31).isActive = true
            button.layer.cornerRadius = 16
            button.clipsToBounds = true
            button.tintColor = .white
          //  button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
            let gradient = viewService.gradientLayer(startColor: UIColor(hex: "#B2A1F7FF"), frame: CGRect(x: 0,
                                                                                                          y: 0,
                                                                                                          width: 31,
                                                                                                          height: 31))
            button.layer.addSublayer(gradient)
           
            let buttonImage : UIImageView = {
                let image = UIImageView()
                image.image = UIImage(systemName: "magnifyingglass")
                image.translatesAutoresizingMaskIntoConstraints = false
                image.widthAnchor.constraint(equalToConstant: 18).isActive = true
                image.heightAnchor.constraint(equalToConstant: 18).isActive = true
                return image
            }()
            button.addSubview(buttonImage)
            
            NSLayoutConstraint.activate([
                buttonImage.centerYAnchor.constraint(equalTo: button.centerYAnchor),
                buttonImage.centerXAnchor.constraint(equalTo: button.centerXAnchor)
            ])
            
            return button
        }()
        
        headerStackView.addArrangedSubview(headerLabel)
        headerStackView.addArrangedSubview(headerButton)
        
        view.addSubview(headerStackView)
        
        NSLayoutConstraint.activate([
            headerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            headerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
        ])
    }
    
}
