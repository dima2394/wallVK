//
//  Created by Dmitriy Verennik on 05/06/2019
//  Copyright © 2019 dverennik. All rights reserved.
//

import UIKit

class VkWallCollectionViewCell: UICollectionViewCell {

    private enum Constants {
        static let insets: UIEdgeInsets = .init(top: 10, left: 10, bottom: 10, right: 10)
        static let avatarImageViewSide: CGFloat = 50
    }

    private(set) lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        return imageView
    }()

    private(set) lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 13)
        return label
    }()

    private(set) lazy var postDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 11)
        return label
    }()

    private(set) lazy var likeIndicatorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private(set) lazy var viewNumberLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private(set) lazy var repostNumberLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private(set) lazy var textContentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 13)
        return label
    }()

    private(set) lazy var contentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()

    private(set) lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 15)
        label.text = "😩\(NSLocalizedString("Unsupported.Attachment", comment: ""))"
        return label
    }()

    var orientationDifference: CGFloat = 0

    override func prepareForReuse() {
        super.prepareForReuse()

        orientationDifference = 0
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubviews(avatarImageView,
                                usernameLabel,
                                postDateLabel,
//                                likeIndicatorImageView,
//                                viewNumberLabel,
//                                repostNumberLabel,
                                textContentLabel,
                                contentImageView,
                                errorLabel)
        backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let isOrientationDifferenceValid = !orientationDifference.isNaN && orientationDifference != 0
        avatarImageView.configureFrame { maker in
            maker.left(inset: Constants.insets.left).top(inset: Constants.insets.top)
            maker.size(width: Constants.avatarImageViewSide, height: Constants.avatarImageViewSide)
            maker.cornerRadius(Constants.avatarImageViewSide / 2)
        }

        let labeslWidth: CGFloat = frame.size.width - (Constants.insets.left * 2) - Constants.avatarImageViewSide - 5
        usernameLabel.configureFrame { maker in
            maker.left(to: avatarImageView.nui_right, inset: 5).top(to: avatarImageView.nui_top, inset: 5)
            maker.width(labeslWidth).heightToFit()
        }
        postDateLabel.configureFrame { maker in
            maker.left(to: usernameLabel.nui_left).top(to: usernameLabel.nui_bottom)
            maker.width(labeslWidth).heightToFit()
        }
        let textContentLabelWidth: CGFloat = frame.size.width - (Constants.insets.left * 2)
        textContentLabel.configureFrame { maker in
            maker.top(to: avatarImageView.nui_bottom, inset: Constants.insets.top)
            maker.left(to: avatarImageView.nui_left).width(textContentLabelWidth).heightToFit()
        }
        contentImageView.configureFrame { maker in
            maker.top(to: textContentLabel.nui_bottom, inset: Constants.insets.top)
            if isOrientationDifferenceValid {
                maker.width(bounds.size.width).height(bounds.size.width / orientationDifference)
            } else {
                maker.size(width: bounds.size.width, height: 0)
            }
        }
        errorLabel.configureFrame { maker in
            if isOrientationDifferenceValid {
                errorLabel.isHidden = true
            } else {
                errorLabel.isHidden = false
                maker.centerX().top(to: textContentLabel.nui_bottom, inset: Constants.insets.top)
                maker.sizeToFit()
            }
        }
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var fittingSize: CGSize = .zero
        fittingSize.width = size.width
        fittingSize.height += Constants.insets.top
        fittingSize.height += Constants.avatarImageViewSide
        fittingSize.height += Constants.insets.top
        fittingSize.height += textContentLabel.sizeThatFits(bounds.size).height
        if !orientationDifference.isNaN && orientationDifference != 0 {
            fittingSize.height += size.width / orientationDifference
        } else {
            fittingSize.height += errorLabel.sizeThatFits(bounds.size).height
        }
        fittingSize.height += Constants.insets.bottom
        return fittingSize
    }
}
