//
//  MainViewController.swift
//  WarStat
//
//  Created by a.antoniak on 26.09.2023.
//

import UIKit
import SwiftUI

final class MainViewController: UIViewController {
    private lazy var embedController: UIHostingController<some View> = {
        let mainRootViewModel = MainRootViewModel()
        let controller = UIHostingController(
            rootView: MainRootView(
                viewModel: mainRootViewModel
            )
            .environmentObject(Theme())
        )
        return controller
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        add(child: embedController, to: view)
    }
}

extension UIViewController {
    func add(
        child viewController: UIViewController,
        to contentView: UIView,
        shouldIgnoreSafeArea: Bool = true
    ) {
        addChild(viewController)
        
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(viewController.view)
        NSLayoutConstraint.activate(
            [
                viewController.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                viewController.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                viewController.view.topAnchor.constraint(
                    equalTo: shouldIgnoreSafeArea
                    ? contentView.topAnchor
                    : contentView.safeAreaLayoutGuide.topAnchor
                ),
                viewController.view.bottomAnchor.constraint(
                    equalTo: shouldIgnoreSafeArea
                    ? contentView.bottomAnchor
                    : contentView.safeAreaLayoutGuide.bottomAnchor
                )
            ]
        )
        
        viewController.didMove(toParent: self)
    }
}
