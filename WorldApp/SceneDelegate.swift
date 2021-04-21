//
//  SceneDelegate.swift
//  WorldApp
//
//  Created by Alex on 1.03.21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let scene = scene as? UIWindowScene else { return }
        let window = UIWindow(frame: scene.coordinateSpace.bounds)
        window.windowScene = scene

        window.rootViewController = UINavigationController(rootViewController: WAInitViewController())

        self.window = window

        self.setUpNavbarAppereance()

        window.makeKeyAndVisible()
    }

    func setUpNavbarAppereance() {
        let navBarAppereance = UINavigationBarAppearance()
        navBarAppereance.configureWithTransparentBackground()
        navBarAppereance.backgroundColor = .darkGray
        navBarAppereance.titleTextAttributes = [.foregroundColor: UIColor.black]

        let buttonStyle = UIBarButtonItemAppearance(style: .plain)
        buttonStyle.normal.titleTextAttributes = [.foregroundColor: UIColor.gray]
        navBarAppereance.buttonAppearance = buttonStyle

        UINavigationBar.appearance().standardAppearance = navBarAppereance
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().tintColor = .black
        UINavigationBar.appearance().barStyle = .default
    }

    func changeRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard let window = self.window else { return }

        window.rootViewController = vc

        if animated {
            UIView.transition(with: window,
                              duration: 0.5,
                              options: .transitionFlipFromLeft,
                              animations: nil)
        }
    }
}
