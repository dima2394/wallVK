//
//  Created by Dmitriy Verennik on 05/06/2019
//  Copyright © 2019 dverennik. All rights reserved.
//

import UIKit

protocol VkWallModuleInput: class {
    var state: VkWallState { get }
    func update(animated: Bool)
}

protocol VkWallModuleOutput: class {
    func vkWallModuleDidClose(_ moduleInput: VkWallModuleInput)
}

final class VkWallModule {

    var input: VkWallModuleInput {
        return presenter
    }
    weak var output: VkWallModuleOutput? {
        get {
            return presenter.output
        }
        set {
            presenter.output = newValue
        }
    }
    let viewController: VkWallViewController
    private let presenter: VkWallPresenter

    init(state: VkWallState) {
        let viewModel = VkWallViewModel(state: state)
        let presenter = VkWallPresenter(state: state, dependencies: ServiceContainer())
        let viewController = VkWallViewController(viewModel: viewModel, output: presenter)
        
        presenter.view = viewController
        self.viewController = viewController
        self.presenter = presenter
    }
}
