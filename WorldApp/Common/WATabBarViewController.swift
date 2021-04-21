//
//  WATabBarViewController.swift
//  WorldApp
//
//  Created by Alex on 6.03.21.
//

import UIKit

class WATabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let photoController = WAFavouriteController()
        photoController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites,
                                                  tag: 0)

        let placesController = WAPlacesViewController()
        placesController.tabBarItem = UITabBarItem(title: "Places",
                                                   image: UIImage(systemName: "globe"),
                                                   selectedImage: nil)

        let settingsController = WASettigsViewController()
        settingsController.tabBarItem = UITabBarItem(title: "Settings",
                                                     image: UIImage(named: "tabBarSettingsIcon"),
                                                     tag: 2)

        self.setViewControllers([
        UINavigationController(rootViewController: photoController),
        UINavigationController(rootViewController: placesController),
        UINavigationController(rootViewController: settingsController)],
            animated: true)

        self.setTabBarAppereance()
    }

//    ОФОРМЛЕНИЕ ТАББАРА

    func setTabBarAppereance() {

        self.tabBar.barTintColor = .darkGray
        self.tabBar.tintColor = .systemOrange
        self.tabBar.unselectedItemTintColor = .lightGray

        self.tabBar.layer.shadowOffset = CGSize(width: 0, height: -5)
        self.tabBar.layer.shadowRadius = 5
        self.tabBar.layer.shadowOpacity = 0.5
        self.tabBar.layer.shadowColor = UIColor.black.cgColor
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let index = self.tabBar.items?.firstIndex(of: item),
              let imageView = tabBar.subviews[index + 1].subviews.first as? UIImageView else { return }
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0.5,
                       options: .curveEaseInOut) {
            //            animations
            imageView.transform = CGAffineTransform(scaleX: 2, y: 2)

            UIView.animate(withDuration: 0.5,
                           delay: 0.2,
                           usingSpringWithDamping: 0.5,
                           initialSpringVelocity: 0.5,
                           options: .curveEaseInOut) {
                imageView.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        }
    }
}
