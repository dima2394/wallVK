//
//  Created by Dmitriy Verennik on 05/06/2019
//  Copyright © 2019 dverennik. All rights reserved.
//

import UIKit

final class AppCoordinator: Coordinator<UINavigationController> {

    typealias Dependencies = Any

    private let dependencies: Dependencies

    // MARK: - Lifecycle

    init(rootViewController: UINavigationController? = nil, dependencies: Dependencies = [Any]()) {
        let rootViewController = rootViewController ?? UINavigationController()
        self.dependencies = dependencies
        super.init(rootViewController: rootViewController)
    }

    func start(launchOptions: LaunchOptions?) {
        let viewController = ViewController()
        rootViewController.setViewControllers([viewController], animated: false)
    }
}
