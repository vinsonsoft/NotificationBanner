//
//  SceneDelegate.swift
//  NotificationBanner
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }

        let navigationController = UINavigationController(rootViewController: ExampleViewController())
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [navigationController]

        if let tab = tabBarController.tabBar.items?.first {
            tab.image = UIImage(named: "tab_bar_icon")?.withRenderingMode(.alwaysOriginal)
            tab.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
            tab.title = nil
        }

        let window = UIWindow(windowScene: windowScene)
        window.backgroundColor = .white
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        self.window = window
    }
}
