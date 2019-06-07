//
//  Created by Dmitriy Verennik on 05/06/2019
//  Copyright © 2019 dverennik. All rights reserved.
//

import VKSdkFramework

final class VkWallViewModel {

    let title: String
    let cellModels: [VkWallCollectionViewCellModel]
    let footerModel: VkWallCollectionFooterReusableViewModel
    
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
        if let firstName = VKSdk.accessToken()?.localUser?.first_name {
            firstname = firstName
        }
        if let lastName = VKSdk.accessToken()?.localUser?.last_name {
            lastname = lastName
        }
        title = "\(firstname) \(lastname)"

        var footerText = "posts"
        if cellModels.count == 1 {
            footerText = "post"
        }
        footerModel = VkWallCollectionFooterReusableViewModel(title: "\(cellModels.count) \(footerText)")
    }
}

//MARK: -  Equatable

extension VkWallViewModel: Equatable {

    static func == (lhs: VkWallViewModel, rhs: VkWallViewModel) -> Bool {
        return lhs.cellModels == rhs.cellModels &&
            lhs.title == rhs.title &&
            lhs.title == rhs.title
    }
}
