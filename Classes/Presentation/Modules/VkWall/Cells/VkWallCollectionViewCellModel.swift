//
//  Created by Dmitriy Verennik on 06/06/2019
//  Copyright © 2019 dverennik. All rights reserved.
//

import UIKit

final class VkWallCollectionViewCellModel {

    let username: String
    let postDateString: String
    let text: String?
    let avatarImageURL: URL?
    let contentPhotoURL: URL?
    let likesNumberString: String
    let photoWidth: Int
    let photoHeight: Int

    init(username: String,
         postDateString: String,
         text: String?,
         contentPhotoURL: URL?,
         likesNumberString: String,
         photoWidth: Int,
         photoHeight: Int,
         avatarImageURL: URL?) {
        
        self.username = username
        self.postDateString = postDateString
        self.text = text
        self.contentPhotoURL = contentPhotoURL
        self.likesNumberString = likesNumberString
        self.photoWidth = photoWidth
        self.photoHeight = photoHeight
        self.avatarImageURL = avatarImageURL
    }
}

//MARK: -  Equatable

extension VkWallCollectionViewCellModel: Equatable {

    static func == (lhs: VkWallCollectionViewCellModel, rhs: VkWallCollectionViewCellModel) -> Bool {
        return lhs.username == rhs.username &&
            lhs.postDateString == rhs.postDateString &&
            lhs.text == rhs.text &&
            lhs.contentPhotoURL == rhs.contentPhotoURL &&
            lhs.likesNumberString == rhs.likesNumberString &&
            lhs.photoWidth == rhs.photoWidth &&
            lhs.photoHeight == rhs.photoHeight &&
            lhs.avatarImageURL == rhs.avatarImageURL
    }
}
