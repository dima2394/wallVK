//
//  Created by Dmitriy Verennik on 05/06/2019
//  Copyright © 2019 dverennik. All rights reserved.
//

import UIKit
import Framezilla
import VKSdkFramework

protocol AuthorizationViewInput: class {
    @discardableResult
    func update(with viewModel: AuthorizationViewModel, animated: Bool) -> Bool
    func setNeedsUpdate()
}

protocol AuthorizationViewOutput: class {
    func viewDidLoad()
    func didAuthorize(withUser user: VKUser)
}

final class AuthorizationViewController: UIViewController {

    private enum Constants {
        static let buttonSize: CGSize = .init(width: 228, height: 46)
        static let scope = ["wall"]
    }

    private(set) var viewModel: AuthorizationViewModel
    let output: AuthorizationViewOutput

    var needsUpdate: Bool = true

    private(set) lazy var authorizationButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "vk_enter_button"), for: .normal)
        button.addTarget(self, action: #selector(authorizationButtonPressed), for: .touchUpInside)
        return button
    }()

    // MARK: - Lifecycle

    init(viewModel: AuthorizationViewModel, output: AuthorizationViewOutput) {
        self.viewModel = viewModel
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(authorizationButton)
        title = NSLocalizedString("Authorization.Title", comment: "")
        VKSdk.instance()?.register(self)
        VKSdk.instance()?.uiDelegate = self
        output.viewDidLoad()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        authorizationButton.configureFrame { maker in
            maker.center()
            maker.size(width: Constants.buttonSize.width, height: Constants.buttonSize.height)
        }
    }

    // MARK: - Actions

    @objc private func authorizationButtonPressed() {

        VKSdk.wakeUpSession(Constants.scope) { state, error in
            switch state {
            case .authorized:
                if let user = VKSdk.accessToken()?.localUser {
                    self.output.didAuthorize(withUser: user)
                }
            case .error:
                VKSdk.authorize(Constants.scope)
            default:
                VKSdk.authorize(Constants.scope)
            }
        }
    }
}

// MARK: - AuthorizationViewInput

extension AuthorizationViewController: AuthorizationViewInput, ViewUpdatable {

    func setNeedsUpdate() {
        needsUpdate = true
    }

    @discardableResult
    func update(with viewModel: AuthorizationViewModel, animated: Bool) -> Bool {
        let oldViewModel = self.viewModel
        guard needsUpdate || viewModel != oldViewModel else {
            return false
        }
        self.viewModel = viewModel

        // update view

        needsUpdate = false

        return true
    }
}

//MARK: -  VKSdkDelegate

extension AuthorizationViewController: VKSdkDelegate {

    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        if let user = VKSdk.accessToken()?.localUser {
            self.output.didAuthorize(withUser: user)
        }
    }

    func vkSdkUserAuthorizationFailed() {
        
    }
}

//MARK: -  VKSdkUIDelegate

extension AuthorizationViewController: VKSdkUIDelegate {

    func vkSdkShouldPresent(_ controller: UIViewController!) {
        present(controller, animated: true, completion: nil)
    }

    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        
    }
}
