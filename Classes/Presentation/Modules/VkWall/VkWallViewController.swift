//
//  Created by Dmitriy Verennik on 05/06/2019
//  Copyright © 2019 dverennik. All rights reserved.
//

import UIKit

protocol VkWallViewInput: class {
    @discardableResult
    func update(with viewModel: VkWallViewModel, animated: Bool) -> Bool
    func setNeedsUpdate()
}

protocol VkWallViewOutput: class {
    func viewDidLoad()
}

final class VkWallViewController: UIViewController {

    private(set) var viewModel: VkWallViewModel
    let output: VkWallViewOutput

    var needsUpdate: Bool = true

    private(set) lazy var wallCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCellClass(VkWallCollectionViewCell.self)
        return collectionView
    }()

    static let sizingCell: VkWallCollectionViewCell = .init()

    //MARK: -  Lifecycle

    init(viewModel: VkWallViewModel, output: VkWallViewOutput) {
        self.viewModel = viewModel
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(wallCollectionView)
        view.backgroundColor = .white
        title = viewModel.title
        output.viewDidLoad()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        wallCollectionView.configureFrame { maker in
            maker.edges(insets: .zero)
        }
    }

    //MARK: -  Actions
}

//MARK: -  VkWallViewInput

extension VkWallViewController: VkWallViewInput, ViewUpdatable {

    func setNeedsUpdate() {
        needsUpdate = true
    }

    @discardableResult
    func update(with viewModel: VkWallViewModel, animated: Bool) -> Bool {
        let oldViewModel = self.viewModel
        guard needsUpdate || viewModel != oldViewModel else {
            return false
        }
        self.viewModel = viewModel

        // update view

        needsUpdate = false

        update(new: viewModel, old: oldViewModel, keyPath: \.cellModels) { _ in
            wallCollectionView.reloadData()
        }

        return true
    }
}

//MARK: -  UICollectionViewDataSource

extension VkWallViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.cellModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellModel = viewModel.cellModels[indexPath.row]
        let cell: VkWallCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.usernameLabel.text = cellModel.username
        cell.postDateLabel.text = cellModel.postDateString
        cell.textContentLabel.text = cellModel.text
        let orientationDifference = CGFloat(cellModel.photoWidth) / CGFloat(cellModel.photoHeight)
        cell.orientationDifference = orientationDifference
        if let imageUrl = cellModel.contentPhotoURL {
            cell.contentImageView.nuke_setImage(withURL: imageUrl)
        }
        if let avatarURL = cellModel.avatarImageURL {
            cell.avatarImageView.nuke_setImage(withURL: avatarURL)
        }

        return cell
    }
}

//MARK: -  UICollectionViewDelegateFlowLayout

extension VkWallViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sizingCell = type(of: self).sizingCell
        let cellModel = viewModel.cellModels[indexPath.row]
        sizingCell.textContentLabel.text = cellModel.text

        guard cellModel.photoWidth != 0, cellModel.photoHeight != 0 else {
            type(of: self).sizingCell.orientationDifference = 0
            return sizingCell.sizeThatFits(collectionView.bounds.size)
        }

        sizingCell.orientationDifference = CGFloat(cellModel.photoWidth) / CGFloat(cellModel.photoHeight)
        return sizingCell.sizeThatFits(collectionView.bounds.size)
    }
}
