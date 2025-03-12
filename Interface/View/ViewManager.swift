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
        let tiktokCard = createLongCardContent(for: viewService.createCardView(gradientColor: "#58CFEFFF", width: width),
                                               image: .tiktok,
                                               title: "Tiktok /nads",
                                               rate: 4.9,
                                               views: 5435)
        
        let clockCard = createShortCardContent(for: viewService.createCardView(gradientColor: "#5BD6B9FF",
                                                                               width: width),
                                               image: .clock,
                                               title: "Art & Draw")
        
        view.addSubview(clockCard)
        NSLayoutConstraint.activate([
            clockCard.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 40),
            clockCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30)
        ])
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
        
        let mainStackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.alignment = .leading
            stackView.spacing = 21
            stackView.translatesAutoresizingMaskIntoConstraints = false
            
            stackView.addArrangedSubview(topStack)
            stackView.addArrangedSubview(bottomStack)
            return stackView
        }()
        item.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: item.topAnchor, constant: 25),
            mainStackView.leadingAnchor.constraint(equalTo: item.leadingAnchor, constant: 25),
            mainStackView.trailingAnchor.constraint(equalTo: item.trailingAnchor, constant: -25),
            mainStackView.bottomAnchor.constraint(equalTo: item.bottomAnchor, constant: -30)
        ])
        
        return item
    }
    
    private func createShortCardContent(for item: UIView, image: UIImage, title: String) -> UIView{
        let cardImageView = viewService.createCardImage(image: image)
        let cardTitle = viewService.creareCardTitle(title: title)
        
        let nextButton = {
            let button = UIButton(primaryAction: nil)
            button.setImage(UIImage(systemName: "arrow.right"), for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.widthAnchor.constraint(equalToConstant: 18).isActive = true
            button.heightAnchor.constraint(equalToConstant: 14).isActive = true
            button.tintColor = .white
            return button
        }()
        
        let hStackView = {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.distribution = .equalSpacing
            stack.alignment = .center
            stack.addArrangedSubview(cardImageView)
            stack.addArrangedSubview(nextButton)
            return stack
        }()
        
        let vStack = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.spacing = 13
           // stack.alignment = .leading //buton resmin hemen yanına geliyor
            
            stack.addArrangedSubview(hStackView)
            stack.addArrangedSubview(cardTitle)
            
            return stack
        }()
        
        item.addSubview(vStack)
        
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: item.topAnchor, constant: 25),
            vStack.leadingAnchor.constraint(equalTo: item.leadingAnchor, constant: 25),
            vStack.trailingAnchor.constraint(equalTo: item.trailingAnchor, constant: -25),
            vStack.bottomAnchor.constraint(equalTo: item.bottomAnchor, constant: -30)
        ])
        
        
        return item
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
