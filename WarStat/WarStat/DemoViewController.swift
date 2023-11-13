//
//  DemoViewController.swift
//  WarStat
//
//  Created by a.antoniak on 14.09.2023.
//

import UIKit

final class DemoViewController: UIViewController {
    private lazy var mainAppButton: UIButton = {
        let button = UIButton()
        button.setTitle("Open app", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureMainAppButton()
        
        // swizzleViewWillAppear()
    }
    
    @objc
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        ObjectiveCRuntime.run()
        
        #warning("uncomment")
//        Task {
//            async let info = WarInfoNetworking.loadInfo()
//            print("🛠️ Info - \(await info)")
//        }
    }
    
    private func configureMainAppButton() {
        mainAppButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainAppButton)
        
        NSLayoutConstraint
            .activate(
                [
                    mainAppButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    mainAppButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                    mainAppButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75)
                ]
            )
        
        mainAppButton.addTarget(self, action: #selector(didTappedMainAppButton), for: .touchUpInside)
    }
    
    @objc
    private func didTappedMainAppButton() {
        printContent("Open Main App flow")
    }
}

extension DemoViewController {
    func swizzleViewWillAppear() {
        guard
            let originalMethod = class_getInstanceMethod(Self.self, #selector(viewWillAppear)),
            let swizzledMethod = class_getInstanceMethod(Self.self, #selector(swizzledViewWillAppear))
        else {
            return
        }
        method_exchangeImplementations(originalMethod, swizzledMethod)
    }
    
    @objc
    func swizzledViewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("This is a part of the Objective-C runtime")
    }
}
