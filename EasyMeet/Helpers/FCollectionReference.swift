//
//  FCollectionReference.swift
//  EasyMeet
//
//  Created by Ted Hyeong on 19/09/2020.
//

import Foundation
import FirebaseFirestore

enum FCollectionReference: String {
    case User
}


func FirebaseReference(_ collectionReference: FCollectionReference) -> CollectionReference {
 
    return Firestore.firestore().collection(collectionReference.rawValue)
}
