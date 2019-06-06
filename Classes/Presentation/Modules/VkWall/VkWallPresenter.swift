//
//  Created by Dmitriy Verennik on 05/06/2019
//  Copyright © 2019 dverennik. All rights reserved.
//

import VKSdkFramework
import RealmSwift

final class VkWallPresenter {

    typealias Dependencies = HasVKService

    weak var view: VkWallViewInput?
    weak var output: VkWallModuleOutput?

    var state: VkWallState

    private let dependencies: Dependencies
    private var notificationToken: NotificationToken?

    init(state: VkWallState, dependencies: Dependencies) {
        self.state = state
        self.dependencies = dependencies
    }

    deinit {
        notificationToken?.invalidate()
        notificationToken = nil
    }
}

//MARK: -  VkWallViewOutput

extension VkWallPresenter: VkWallViewOutput {

    func viewDidLoad() {
        dependencies.vkService.fetchWall()
        notificationToken = dependencies.vkService.observeWallItems { changes in
            switch changes {
            case .initial(let items):
                self.state.wallItems = items.array
                self.update(animated: true)
            case .update(let items, _, _, _):
                self.state.wallItems = items.array
                self.update(animated: true)
            case .error(let error):
                print(error.localizedDescription)
            }
        }
    }
}

//MARK: -  VkWallModuleInput

extension VkWallPresenter: VkWallModuleInput {

    func update(animated: Bool) {
        let viewModel = VkWallViewModel(state: state)
        view?.update(with: viewModel, animated: animated)
    }
}
