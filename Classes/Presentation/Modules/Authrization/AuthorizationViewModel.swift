//
//  Created by Dmitriy Verennik on 05/06/2019
//  Copyright © 2019 dverennik. All rights reserved.
//

struct AuthorizationViewModel: Equatable {

    init(state: AuthorizationState) {
    }

    static func == (lhs: AuthorizationViewModel, rhs: AuthorizationViewModel) -> Bool {
        return false
    }
}
