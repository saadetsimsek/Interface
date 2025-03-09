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
    lazy private var width: CGFloat = {
        return (view.frame.width/2) - 40
    }()
    
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
            let button = UIButton(primaryAction: nil // UIAction(handler: { _ in
                                  //     print(1)          })
            )
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
    
    func createCards(){
        
    }
    
    private func createLongCardContent(for item: UIView, image: UIImage, title: String, rate: Float, views: Int) -> UIView{
        
        let cardImage = viewService.createCardImage(image: image)
        let cardTitle = viewService.creareCardTitle(title: title)
        let rateStack = viewService.createRateStackView(reate: rate)
        let views = viewService.getViewLabel(views: views)
        
        lazy var topStack = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.spacing = 12
            stack.alignment = .leading
            stack.addArrangedSubview(cardImage)
            stack.addArrangedSubview(cardTitle)
            return stack
        }()
        
        lazy var bottomStack = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.spacing = 2
            stack.alignment = .leading
            stack.addArrangedSubview(rateStack)
            stack.addArrangedSubview(views)
            return stack
        }()
        
        var mainStackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.alignment = .leading
            stackView.spacing = 21
            stackView.translatesAutoresizingMaskIntoConstraints = false
            
            stackView.addArrangedSubview(topStack)
            stackView.addArrangedSubview(bottomStack)
            return stackView
        }()
        view.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: views.topAnchor, constant: 25),
            mainStackView.leadingAnchor.constraint(equalTo: views.leadingAnchor, constant: 25),
            mainStackView.trailingAnchor.constraint(equalTo: views.trailingAnchor, constant: -25),
            mainStackView.bottomAnchor.constraint(equalTo: views.bottomAnchor, constant: -27)
        ])
        
        return item
    }
    
    private func createShortCardContent(){
        
    }
}
