//
//  ViewController.swift
//  WorldApp
//
//  Created by Alex on 1.03.21.
//

import UIKit

class WAInitViewController: UIViewController {

    private lazy var topLabelConstraint: NSLayoutConstraint = self.appLabel
        .topAnchor
        .constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,
                    constant: 35)

    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "splashImage")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    private lazy var appLabel: UILabel = {
        let label = UILabel()
        label.text = "WorldApp"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 50)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var continueButton: UIButton = {
        let button = UIButton()
        button.setTitle("Continue", for: UIControl.State())
        button.setTitleColor(.systemOrange, for: UIControl.State())
        button.backgroundColor = UIColor.blue.withAlphaComponent(0.3)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 50)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 15

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Init controller"

        let addButton = UIBarButtonItem(systemItem: .add)
        self.navigationItem.setRightBarButton(addButton, animated: false)

        let doneButton = UIBarButtonItem(systemItem: .done)
        self.navigationItem.setLeftBarButton(doneButton, animated: false)

        self.view.addSubview(backgroundImageView)
        self.view.addSubview(appLabel)
        self.view.addSubview(continueButton)

//        self.setUpConstraints()
//        self.setUpConstraintsWithActivation()

        self.setUpConstraintsWithFunction()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        guard self.topLabelConstraint.constant < 250 else { return }

        self.topLabelConstraint.constant = 450
        self.view.setNeedsUpdateConstraints()

        UIView.animate(withDuration: 1.5) {
            self.backgroundImageView.alpha = 0.8
            self.view.layoutIfNeeded()
        }
    }

    func setUpConstraints() {
        NSLayoutConstraint.activate([
            self.backgroundImageView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.backgroundImageView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.backgroundImageView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.backgroundImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            self.appLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 35),
            self.appLabel.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 25),
            self.appLabel.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -25)

        ])
    }

    func setUpConstraintsWithActivation() {
        self.backgroundImageView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.backgroundImageView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.backgroundImageView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.backgroundImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true

        self.appLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 35).isActive = true
        self.appLabel.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 25).isActive = true
        self.appLabel.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -25).isActive = true

    }

    func setUpConstraintsWithFunction() {
        self.view.addConstraints([
            NSLayoutConstraint(item: self.backgroundImageView,
                               attribute: .top,
                               relatedBy: .equal,
                               toItem: self.view,
                               attribute: .top,
                               multiplier: 1,
                               constant: 0),
            NSLayoutConstraint(item: self.backgroundImageView,
                               attribute: .left,
                               relatedBy: .equal,
                               toItem: self.view,
                               attribute: .left,
                               multiplier: 1,
                               constant: 0),
            NSLayoutConstraint(item: self.backgroundImageView,
                               attribute: .right,
                               relatedBy: .equal,
                               toItem: self.view,
                               attribute: .right,
                               multiplier: 1,
                               constant: 0),
            NSLayoutConstraint(item: self.backgroundImageView,
                               attribute: .bottom,
                               relatedBy: .equal,
                               toItem: self.view,
                               attribute: .bottom,
                               multiplier: 1,
                               constant: 0)

        ])

        self.view.addConstraints([
//            NSLayoutConstraint(item: self.appLabel,
//                               attribute: .top,
//                               relatedBy: .equal,
//                               toItem: self.view.safeAreaLayoutGuide,
//                               attribute: .top,
//                               multiplier: 1,
//                               constant: 35),
            self.topLabelConstraint,
            NSLayoutConstraint(item: self.appLabel,
                               attribute: .left,
                               relatedBy: .equal,
                               toItem: self.view.safeAreaLayoutGuide,
                               attribute: .left,
                               multiplier: 1,
                               constant: 25),
            NSLayoutConstraint(item: self.appLabel,
                               attribute: .right,
                               relatedBy: .equal,
                               toItem: self.view.safeAreaLayoutGuide,
                               attribute: .right,
                               multiplier: 1,
                               constant: -25)
        ])

        self.view.addConstraints([
            NSLayoutConstraint(item: self.continueButton,
                               attribute: .top,
                               relatedBy: .equal,
                               toItem: self.view,
                               attribute: .centerY,
                               multiplier: 1,
                               constant: 170),
            NSLayoutConstraint(item: self.continueButton,
                               attribute: .left,
                               relatedBy: .equal,
                               toItem: self.view,
                               attribute: .left,
                               multiplier: 1,
                               constant: 25),
            NSLayoutConstraint(item: self.continueButton,
                               attribute: .right,
                               relatedBy: .equal,
                               toItem: self.view,
                               attribute: .right,
                               multiplier: 1,
                               constant: -25),
            NSLayoutConstraint(item: self.continueButton,
                               attribute: .height,
                               relatedBy: .equal,
                               toItem: nil,
                               attribute: .notAnAttribute,
                               multiplier: 1,
                               constant: 70)
        ])
    }

    @objc private func continueButtonTapped() {

        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            sceneDelegate.changeRootViewController(WATabBarViewController())
        }
    }

//    @objc private func continueButtonTapped() {
//        let tabBarController = UITabBarController()
//        tabBarController.setViewControllers([
//            WAFavouriteController(),
//            WAPlacesViewController()],
//            animated: true)
// //       (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)

//        let alertController = UIAlertController(title: "Continue tapped", message: "What do you want to do?", preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
//            print("OK action tapped")
//        }
//        alertController.addAction(okAction)
//
//        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
//            print("Delete action tapped")
//        }
//        alertController.addAction(deleteAction)
//
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
//        alertController.addAction(cancelAction)
//
//        self.present(alertController, animated: true)
//    }
}
