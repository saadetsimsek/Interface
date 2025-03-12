//
//  ViewController.swift
//  Interface
//
//  Created by Saadet Şimşek on 05/03/2025.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var viewManager: ViewManager = {
        return ViewManager(controller: self)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(hex: "#464C75FF")
        viewManager.createAppHeader(title: "Lorem ipsum dolor \nsit amet, consectet")
        viewManager.createCards()
        viewManager.createService()
    }


}

