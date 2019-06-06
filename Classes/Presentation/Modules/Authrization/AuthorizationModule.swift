//
//  Created by Dmitriy Verennik on 05/06/2019
//  Copyright © 2019 dverennik. All rights reserved.
//

import UIKit
import VKSdkFramework

protocol AuthorizationModuleInput: class {
    var state: AuthorizationState { get }
    func update(animated: Bool)
}

protocol AuthorizationModuleOutput: class {
    func authorizationModuleDidClose(_ moduleInput: AuthorizationModuleInput)
    func authorizationModuleDidAuthorize(withUser user: VKUser, _ moduleInput: AuthorizationModuleInput)
}

final class AuthorizationModule {

    var input: AuthorizationModuleInput {
        return presenter
    }
    weak var output: AuthorizationModuleOutput? {
        get {
            return presenter.output
        }
        set {
            presenter.output = newValue
        }
    }
    let viewController: AuthorizationViewController
    private let presenter: AuthorizationPresenter

    init() {
        let state = AuthorizationState()
        let viewModel = AuthorizationViewModel(state: state)
        let presenter = AuthorizationPresenter(state: state)
        let viewController = AuthorizationViewController(viewModel: viewModel, output: presenter)
        
        presenter.view = viewController
        self.viewController = viewController
        self.presenter = presenter
    }
}
