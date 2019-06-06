//
//  Created by Dmitriy Verennik on 06/06/2019
//  Copyright © 2019 dverennik. All rights reserved.
//

import UIKit
import Nuke

extension UIImageView {

    func nuke_setImage(withURL url: URL) {
        Nuke.loadImage(with: url, into: self)
    }
}
