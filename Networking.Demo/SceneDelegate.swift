//
//  SceneDelegate.swift
//  Networking.Demo
//
//  Created by Art Arriaga on 2/13/20.
//  Copyright © 2020 ArturoArriaga.IO. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let controller = RootCollectionViewController()
        let navigationController = UINavigationController(rootViewController: controller)
        guard let _ = (scene as? UIWindowScene) else { return }
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

