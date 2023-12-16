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
    }
    
    @objc
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Task {
            async let info = WarInfoNetworking.loadInfo()
            print("🛠️ Info - \(await info)")
        }
        
        loadInfo()
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

// SSL pinning
extension DemoViewController: URLSessionDelegate {
    func loadInfo() {
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        
        guard let infoURL = WarInfoURL.info.url else {
            return
        }
        
        let request = URLRequest(url: infoURL)
        
        session.dataTask(with: request) { data, response, error in
            if let error {
                print("🛠️ Request error: \(error.localizedDescription)")
                return
            }
            
            if let data {
                print("🛠️ Data: \(data)")
            }
        }
        .resume()
    }
    
    private var certificates: [Data] {
        let url = Bundle.main.url(forResource: "wstat", withExtension: "cer")!
        let data = try! Data(contentsOf: url)
        return [data]
    }
    
    func urlSession(
        _ session: URLSession,
        didReceive challenge: URLAuthenticationChallenge,
        completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void
    ) {
        if let trust = challenge.protectionSpace.serverTrust,
           SecTrustGetCertificateCount(trust) > 0 {
            if let certificate = SecTrustGetCertificateAtIndex(trust, 0) {
                let data = SecCertificateCopyData(certificate) as Data
                if certificates.contains(data) {
                    completionHandler(.useCredential, URLCredential(trust: trust))
                    print("🛠️ We have a certificate.")
                    return
                } else {
                    print("🛠️ Certificates mismatch")
                    completionHandler(.cancelAuthenticationChallenge, nil)
                }
            }
            
        }
        completionHandler(.cancelAuthenticationChallenge, nil)
    }
}
