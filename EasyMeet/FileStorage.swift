//
//  FileStorage.swift
//  EasyMeet
//
//  Created by Ted Hyeong on 28/09/2020.
//

import Foundation
import FirebaseStorage

let storage = Storage.storage()

class FileStorage {

    class func uploadImage(_ image: UIImage, directory: String, completion: @escaping (_ documentLink: String?) -> Void) {
        
        let storageRef = storage.reference(forURL: kFILEREFERENCE).child(directory)
        
        let imageData = image.jpegData(compressionQuality: 0.6)
        
        var task: StorageUploadTask!
        
        task = storageRef.putData(imageData!, metadata: nil, completion: { (metaData, error) in
            
            task.removeAllObservers()
            
            if error != nil {
                print("error uploading image", error!.localizedDescription)
                return
            }
            
            storageRef.downloadURL { (url, error) in
                
                guard let downloadUrl = url else {
                    completion(nil)
                    return
                }
                print("We have uploaded image to", downloadUrl.absoluteString)
                completion(downloadUrl.absoluteString)
            }
        })
    }
    
    
    class func saveImageLocally(imageData: NSData, fileName: String) {
        
        var docURL = getDocumentsURL()
        
        docURL = docURL.appendingPathComponent(fileName, isDirectory: false)
        
        imageData.write(to: docURL, atomically: true)
    }
}

func getDocumentsURL() -> URL {
    
    let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last
    
    return documentURL!
}

func fileInDocumentsDirectory(filename: String) -> String {
    let fileURL = getDocumentsURL().appendingPathComponent(filename)
    
    return fileURL.path
}
