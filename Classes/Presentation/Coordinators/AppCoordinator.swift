//
//  Created by Dmitriy Verennik on 05/06/2019
//  Copyright © 2019 dverennik. All rights reserved.
//

import UIKit
import VKSdkFramework

final class AppCoordinator: Coordinator<UINavigationController> {

    // MARK: - Lifecycle

    override init(rootViewController: UINavigationController? = nil) {
        let rootViewController = rootViewController ?? UINavigationController()
        super.init(rootViewController: rootViewController)
    }

    func start(launchOptions: LaunchOptions?) {
        VKSdk.wakeUpSession(["wall"]) { state, error in
            switch state {
            case .authorized:
                self.startWallModule()
                print("😇authorized")
            case .initialized:
                self.startAuthorizationModule()
                print("😇initialized")
            default:
                break
            }
        }
    }

    private func startAuthorizationModule() {
        let module = AuthorizationModule()
        module.output = self
        rootViewController.setViewControllers([module.viewController], animated: true)
    }

    private func startWallModule() {
        let state = VkWallState()
        let module = VkWallModule(state: state)
        module.output = self
        rootViewController.setViewControllers([module.viewController], animated: true)
    }
}

//MARK: -  AuthorizationModuleOutput

extension AppCoordinator: AuthorizationModuleOutput {

    func authorizationModuleDidClose(_ moduleInput: AuthorizationModuleInput) {

    }

    func authorizationModuleDidAuthorize(_ moduleInput: AuthorizationModuleInput) {
        startWallModule()
    }
}

//MARK: -  VkWallModuleOutput

extension AppCoordinator: VkWallModuleOutput {
    
    func vkWallModuleDidClose(_ moduleInput: VkWallModuleInput) {

    }
}
