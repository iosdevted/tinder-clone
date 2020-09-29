//
//  CardViewController.swift
//  EasyMeet
//
//  Created by Ted Hyeong on 29/09/2020.
//

import UIKit
import Shuffle_iOS
import Firebase

class CardViewController: UIViewController {
    
    //MARK: - Vars
    private let cardStack = SwipeCardStack()
    private var initialCardModels: [UserCardModel] = []
    
    
    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        createUsers()
        
        
        
//        let user = FUser.currentUser()!
//        
//        let cardModel = UserCardModel(id: user.objectId, name: user.username, age: abs(user.dateOfBirth.interval(ofComponent: .year, fromDate: Date())), occupation: user.profession, image: user.avatar)
//        
//        initialCardModels.append(cardModel)
//        layoutCardStackView()
    }

    //MARK: - Layout cards
    private func layoutCardStackView() {
        
        cardStack.delegate = self
        cardStack.dataSource = self
        
        view.addSubview(cardStack)
        
        cardStack.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         left: view.safeAreaLayoutGuide.leftAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         right: view.safeAreaLayoutGuide.rightAnchor)
    }
    
}

extension CardViewController: SwipeCardStackDelegate, SwipeCardStackDataSource {
    func cardStack(_ cardStack: SwipeCardStack, cardForIndexAt index: Int) -> SwipeCard {
        
        let card = UserCard()
        card.footerHeight = 80
        card.swipeDirections = [.left, .right]
        
        for direction in card.swipeDirections {
            
            card.setOverlay(UserCardOverlay(direction: direction), forDirection: direction)
        }
        
        card.configure(withModel: initialCardModels[index])
        
        return card
    }
    
    func numberOfCards(in cardStack: SwipeCardStack) -> Int {
        return initialCardModels.count
    }
    
    //MARK: - Delegates
    
    func didSwipeAllCards(_ cardStack: SwipeCardStack) {
        print("finished ")
    }
    
    func cardStack(_ cardStack: SwipeCardStack, didSwipeCardAt index: Int, with direction: SwipeDirection) {
        print("swipe to", direction)
    }
    
    func cardStack(_ cardStack: SwipeCardStack, didSelectCardAt index: Int) {
        print("a")
    }
    
}
