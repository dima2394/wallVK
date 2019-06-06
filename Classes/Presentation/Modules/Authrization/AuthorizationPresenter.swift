//
//  Created by Dmitriy Verennik on 05/06/2019
//  Copyright © 2019 dverennik. All rights reserved.
//

import VKSdkFramework

final class AuthorizationPresenter {

    enum Constants {
        static let scope = ["wall"]
    }

    weak var view: AuthorizationViewInput?
    weak var output: AuthorizationModuleOutput?

    var state: AuthorizationState

    init(state: AuthorizationState) {
        self.state = state
    }
}

// MARK: - AuthorizationViewOutput

extension AuthorizationPresenter: AuthorizationViewOutput {

    func viewDidLoad() {
        update(animated: false)
    }

    func didAuthorize(withUser user: VKUser) {
        output?.authorizationModuleDidAuthorize(withUser: user, self)
    }
}

// MARK: - AuthorizationModuleInput

extension AuthorizationPresenter: AuthorizationModuleInput {

    func update(animated: Bool) {
        let viewModel = AuthorizationViewModel(state: state)
        view?.update(with: viewModel, animated: animated)
    }
}
