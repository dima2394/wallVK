//
//  Created by Dmitriy Verennik on 07/06/2019
//  Copyright © 2019 dverennik. All rights reserved.
//

import Foundation


final class VkWallCollectionFooterReusableViewModel {

    let title: String

    init(title: String) {
        self.title = title
    }
}

//MARK: -  Equatable

extension VkWallCollectionFooterReusableViewModel: Equatable {

    static func == (lhs: VkWallCollectionFooterReusableViewModel, rhs: VkWallCollectionFooterReusableViewModel) -> Bool {
        return lhs.title == rhs.title
    }
}
