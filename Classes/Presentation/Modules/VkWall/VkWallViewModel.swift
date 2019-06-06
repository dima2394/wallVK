//
//  Created by Dmitriy Verennik on 05/06/2019
//  Copyright © 2019 dverennik. All rights reserved.
//

import Foundation

final class VkWallViewModel {

    let cellModels: [VkWallCollectionViewCellModel]
    let title: String
    
    init(state: VkWallState) {
        cellModels = state.wallItems.map { wallRealmModel -> VkWallCollectionViewCellModel in
            return VkWallCollectionViewCellModel(username: wallRealmModel.username,
                                                 postDateString: wallRealmModel.date.stringDate,
                                                 text: wallRealmModel.text,
                                                 contentPhotoURL: URL(string: wallRealmModel.photoStringURL),
                                                 likesNumberString: "\(wallRealmModel.likesNumber)",
                                                 photoWidth: wallRealmModel.photoWidth,
                                                 photoHeight: wallRealmModel.photoHeight,
                                                 avatarImageURL: URL(string: wallRealmModel.userAvatarStringURL),
                                                 isLikedIt: wallRealmModel.isLikeIt,
                                                 repostNumberString: "\(wallRealmModel.repostsNumber)")
        }

        var firstname = ""
        var lastname = ""
        if let firstName = state.user.first_name {
            firstname = firstName
        }
        if let lastName = state.user.last_name {
            lastname = lastName
        }
        self.title = "\(firstname) \(lastname)"
    }
}

//MARK: -  Equatable

extension VkWallViewModel: Equatable {

    static func == (lhs: VkWallViewModel, rhs: VkWallViewModel) -> Bool {
        return lhs.cellModels == rhs.cellModels
    }
}
