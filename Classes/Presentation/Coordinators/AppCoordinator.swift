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
                if let user = VKSdk.accessToken()?.localUser {
                    self.startWallModule(withUser: user)
                }
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

    private func startWallModule(withUser user: VKUser) {
        let state = VkWallState(user: user)
        let module = VkWallModule(state: state)
        module.output = self
        rootViewController.setViewControllers([module.viewController], animated: true)
    }
}

//MARK: -  AuthorizationModuleOutput

extension AppCoordinator: AuthorizationModuleOutput {

    func authorizationModuleDidClose(_ moduleInput: AuthorizationModuleInput) {

    }

    func authorizationModuleDidAuthorize(withUser user: VKUser, _ moduleInput: AuthorizationModuleInput) {
        startWallModule(withUser: user)
    }
}

//MARK: -  VkWallModuleOutput

extension AppCoordinator: VkWallModuleOutput {
    
    func vkWallModuleDidClose(_ moduleInput: VkWallModuleInput) {

    }
}
