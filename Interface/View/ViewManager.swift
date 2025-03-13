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
    private var cardStack = UIStackView()
    
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
                                               title: "Tiktok \nads",
                                               rate: 4.9,
                                               views: 5435)
        
        let clockCard = createShortCardContent(for: viewService.createCardView(gradientColor: "#5BD6B9FF",
                                                                               width: width),
                                               image: .clock,
                                               title: "Art & Draw")
        
        let instagramCard = createShortCardContent(for: viewService.createCardView(gradientColor: "#E79DA7FF", width: width),
                                                   image: .insta,
                                                   title: "Instagram")
        
        let youtubeCard = createLongCardContent(for: viewService.createCardView(gradientColor: "#B2A1F7FF", width: width),
                                                image: .youtube,
                                                title: "Youtube \nads",
                                                rate: 4.2,
                                                views: 3483)
        
        // intertwined stack - iç içe geçmiş stacklar
        let lStack = viewService.getSideStack(items: [tiktokCard,clockCard])
        let rStack = viewService.getSideStack(items: [instagramCard, youtubeCard])
        
        cardStack = {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.alignment = .fill
            stack.distribution = .equalSpacing
            stack.translatesAutoresizingMaskIntoConstraints = false
            
            stack.addArrangedSubview(lStack)
            stack.addArrangedSubview(rStack)
            return stack
        }()
        
        view.addSubview(cardStack)
        
        NSLayoutConstraint.activate([
            cardStack.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 30),
            cardStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            cardStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
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
            mainStackView.bottomAnchor.constraint(equalTo: item.bottomAnchor, constant: -27)
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
    
    func createService(){
        
        let headerTitle = {
            let label = UILabel()
            label.text = "Deevelopment"
            label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            label.textColor = .white
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        view.addSubview(headerTitle)
        
        
        let serviceCard = {
            let serviceCard = UIView()
            serviceCard.translatesAutoresizingMaskIntoConstraints = false
            serviceCard.layer.cornerRadius = 25
            serviceCard.layer.cornerCurve = .continuous
            
            let gradiemt = viewService.gradientLayer(startColor: UIColor(hex: "#949AC5FF"), frame: CGRect(x: 0, y: 0, width: 400, height: 200))
            serviceCard.layer.addSublayer(gradiemt)
            serviceCard.clipsToBounds = true
            return serviceCard
        }()
        
        view.addSubview(serviceCard)
        
        let serviceImage = {
            let image = UIImageView()
            image.image = .baner
            image.contentMode = .scaleAspectFit
            image.clipsToBounds = true
            
            image.widthAnchor.constraint(equalToConstant: 150).isActive = true
            image.heightAnchor.constraint(equalToConstant: 150).isActive = true
            return image
        }()
        
        //VStack
        let serviceCardTitle = viewService.creareCardTitle(title: "Desing & \nDevelopment")
        let rate = viewService.createRateStackView(reate: 4.5)
        
        let infoImage = {
            let image = UIImageView()
            image.translatesAutoresizingMaskIntoConstraints = false
            image.image = .comp
            image.widthAnchor.constraint(equalToConstant: 15).isActive = true
            image.heightAnchor.constraint(equalToConstant: 15).isActive = true
            return image
        }()
        
        let infoTitle = {
            let label = UILabel()
            label.text = "Complete Desing"
            label.font = UIFont.systemFont(ofSize: 12, weight: .light)
            label.textColor = .white
            return label
        }()
        
        let infoStack = {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.alignment = .leading
            stack.spacing = 5
            stack.addArrangedSubview(infoImage)
            stack.addArrangedSubview(infoTitle)
            return stack
        }()
        
        let priceLabel = {
            let label = UILabel()
            label.text = "$1000"
            label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            label.textColor = UIColor(hex: "#58CFEFFF")
            return label
        }()
        
        let vStack = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.alignment = .leading
            stack.spacing = 5
            
            stack.addArrangedSubview(serviceCardTitle)
            stack.addArrangedSubview(rate)
            stack.addArrangedSubview(infoStack)
            
            stack.addArrangedSubview(UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 5)))
            
            stack.addArrangedSubview(priceLabel)
            return stack
        }()
        
        //HStack
        
        let hStack = {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.distribution = .equalSpacing
            stack.alignment = .center
            stack.translatesAutoresizingMaskIntoConstraints = false
            
            stack.addArrangedSubview(serviceImage)
            stack.addArrangedSubview(vStack)
            return stack
        }()
        
        view.addSubview(hStack)
        
        NSLayoutConstraint.activate([
            headerTitle.topAnchor.constraint(equalTo: cardStack.bottomAnchor, constant: 40),
            headerTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            headerTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            serviceCard.topAnchor.constraint(equalTo: headerTitle.bottomAnchor, constant: 20),
            serviceCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            serviceCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            serviceCard.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25),
            
            hStack.topAnchor.constraint(equalTo: serviceCard.topAnchor, constant: 25),
            hStack.leadingAnchor.constraint(equalTo: serviceCard.leadingAnchor, constant: 25),
            hStack.trailingAnchor.constraint(equalTo: serviceCard.trailingAnchor, constant: -25),
            hStack.bottomAnchor.constraint(equalTo: serviceCard.bottomAnchor, constant: -25)
        ])
    }
    
}
