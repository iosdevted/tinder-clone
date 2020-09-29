//
//  UserCard.swift
//  EasyMeet
//
//  Created by Ted Hyeong on 29/09/2020.
//

import Foundation
import Shuffle_iOS

class UserCard: SwipeCard {
    
    func configure(withModel model: UserCardModel) {
        content = UserCardContentView(withImage: model.image)
        footer = UserCardFooterView(withTitle: "\(model.name)", subTitle: model.occupation)
    }
}
