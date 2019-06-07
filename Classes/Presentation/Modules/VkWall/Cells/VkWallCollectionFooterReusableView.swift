//
//  Created by Dmitriy Verennik on 07/06/2019
//  Copyright © 2019 dverennik. All rights reserved.
//

import UIKit


final class VkWallCollectionFooterReusableView: UICollectionReusableView {

    private enum Constants {
        static let insets: UIEdgeInsets = .init(top: 20, left: 5, bottom: 20, right: 5)
    }

    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(titleLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        titleLabel.configureFrame { maker in
            maker.top(inset: Constants.insets.top).centerX()
            maker.widthThatFits(maxWidth: frame.size.width - (Constants.insets.right * 2)).heightToFit()
        }
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var fittingSize: CGSize = .zero
        fittingSize.width = size.width
        fittingSize.height += Constants.insets.top
        fittingSize.height += titleLabel.sizeThatFits(size).height
        fittingSize.height += Constants.insets.bottom
        return fittingSize
    }
}
