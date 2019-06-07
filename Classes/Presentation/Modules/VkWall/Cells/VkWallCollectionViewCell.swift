//
//  Created by Dmitriy Verennik on 05/06/2019
//  Copyright © 2019 dverennik. All rights reserved.
//

import UIKit

class VkWallCollectionViewCell: UICollectionViewCell {

    private enum Constants {
        static let insets: UIEdgeInsets = .init(top: 5, left: 10, bottom: 10, right: 10)
        static let avatarImageViewSide: CGFloat = 46
        static let likeImageViewSide: CGFloat = 30
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
        label.font = .systemFont(ofSize: 14)
        return label
    }()

    private(set) lazy var postDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 13)
        return label
    }()

    private(set) lazy var likeIndicatorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "no_like_icon")
        imageView.highlightedImage = UIImage(named: "like_icon")
        return imageView
    }()

    private(set) lazy var likeNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    private(set) lazy var repostImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "forward_icon")
        return imageView
    }()

    private(set) lazy var repostNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 14)
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

    private(set) lazy var errorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(white: 0.9, alpha: 0.6)
        return view
    }()

    private(set) lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 15)
        label.text = "😩\(NSLocalizedString("Unsupported.Attachment", comment: ""))"
        return label
    }()

    var orientationDifference: CGFloat = 0

    override init(frame: CGRect) {
        super.init(frame: frame)

        errorView.addSubview(errorLabel)
        contentView.addSubviews(avatarImageView,
                                likeIndicatorImageView,
                                likeNumberLabel,
                                repostImageView,
                                repostNumberLabel,
                                textContentLabel,
                                contentImageView,
                                errorView)
        backgroundColor = .init(white: 0.9, alpha: 1)
        contentView.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let isOrientationDifferenceValid = !orientationDifference.isNaN && orientationDifference != 0
        avatarImageView.configureFrame { maker in
            maker.left(inset: Constants.insets.left).top(inset: Constants.insets.top * 2)
            maker.size(width: Constants.avatarImageViewSide, height: Constants.avatarImageViewSide)
            maker.cornerRadius(Constants.avatarImageViewSide / 2)
        }

        let labeslWidth: CGFloat = frame.size.width - (Constants.insets.left * 2) - Constants.avatarImageViewSide - 5
        let labelsContainer = [usernameLabel, postDateLabel].container(in: contentView) {
            usernameLabel.configureFrame { maker in
                maker.left().top()
                maker.width(labeslWidth).heightToFit()
            }
            postDateLabel.configureFrame { maker in
                maker.left().top(to: usernameLabel.nui_bottom)
                maker.width(labeslWidth).heightToFit()
            }
        }
        labelsContainer.configureFrame { maker in
            maker.centerY(to: avatarImageView.nui_centerY).left(to: avatarImageView.nui_right, inset: 5)
        }

        let textContentLabelWidth: CGFloat = frame.size.width - (Constants.insets.left * 2)
        textContentLabel.configureFrame { maker in
            maker.top(to: avatarImageView.nui_bottom, inset: Constants.insets.top * 2)
            maker.left(to: avatarImageView.nui_left).width(textContentLabelWidth).heightToFit()
        }
        contentImageView.configureFrame { maker in
            maker.top(to: textContentLabel.nui_bottom)
            if isOrientationDifferenceValid {
                maker.width(bounds.size.width).height(bounds.size.width / orientationDifference)
            } else {
                maker.size(width: bounds.size.width, height: 0)
            }
        }
        likeIndicatorImageView.configureFrame { maker in
            maker.left(to: avatarImageView.nui_left).top(to: contentImageView.nui_bottom, inset: Constants.insets.top)
            maker.size(width: Constants.likeImageViewSide, height: Constants.likeImageViewSide)
        }
        likeNumberLabel.configureFrame { maker in
            maker.left(to: likeIndicatorImageView.nui_right).centerY(to: likeIndicatorImageView.nui_centerY)
            maker.widthThatFits(maxWidth: 150).heightToFit()
        }
        repostImageView.configureFrame { maker in
            maker.left(to: likeNumberLabel.nui_right, inset: 50).centerY(to: likeIndicatorImageView.nui_centerY)
            maker.size(width: Constants.likeImageViewSide, height: Constants.likeImageViewSide)
        }
        repostNumberLabel.configureFrame { maker in
            maker.left(to: repostImageView.nui_right).centerY(to: likeIndicatorImageView.nui_centerY)
            maker.widthThatFits(maxWidth: 150).heightToFit()
        }

        if isOrientationDifferenceValid {
            errorView.isHidden = true
        } else {
            errorView.isHidden = false
            errorLabel.configureFrame { maker in
                maker.centerY(to: contentView.nui_centerY)
                maker.centerX(to: contentView.nui_centerX)
                maker.sizeToFit()
            }
            errorView.configureFrame { maker in
                maker.edges(insets: .zero)
            }
        }
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var fittingSize: CGSize = .zero
        fittingSize.width = size.width
        fittingSize.height += (Constants.insets.top * 2)
        fittingSize.height += Constants.avatarImageViewSide
        fittingSize.height += Constants.insets.top
        fittingSize.height += textContentLabel.sizeThatFits(bounds.size).height
        fittingSize.height += Constants.likeImageViewSide
        if !orientationDifference.isNaN && orientationDifference != 0 {
            fittingSize.height += size.width / orientationDifference
        }

        fittingSize.height += (Constants.insets.bottom * 2)
        return fittingSize
    }
}
