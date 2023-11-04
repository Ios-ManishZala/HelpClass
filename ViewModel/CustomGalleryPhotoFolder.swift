//
//  CustomGalleryPhoto.swift
//  VideoDownloaderForWeb
//
//  Created by DREAMWORLD on 20/09/23.
//

import Foundation
import Photos
import UIKit


class CustomPhotoAlbum: NSObject {
    
    static let sharedInstance = CustomPhotoAlbum()
    var assetCollection: PHAssetCollection!

    
    func fetchAssetCollectionForAlbum(albumName:String,completion:@escaping()->()) {
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "title = %@", albumName)
        let collection = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)
        
        if let album = collection.firstObject {
            self.assetCollection = album
            completion()
        }
        else {
            // The album doesn't exist, create it
            self.createAlbum(albumName: albumName, completion: completion)
        }
    }
    
    func createAlbum(albumName:String,completion:@escaping()->()) {
        PHPhotoLibrary.shared().performChanges({
            PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: albumName) // Create an asset collection with the album name
        }) { [weak self] success, error in
            if success {
                // Album created, fetch it
                self?.fetchAssetCollectionForAlbum(albumName: albumName, completion: completion)
            }
            else {
                print("Error creating album: \(String(describing: error))")
            }
        }
    }
    
    func save(image: UIImage,completion:@escaping(Bool)->()) {
        if assetCollection == nil {
            return // If there was an error upstream, skip the save
        }
        
        PHPhotoLibrary.shared().performChanges({
            let assetChangeRequest = PHAssetChangeRequest.creationRequestForAsset(from: image)
            let assetPlaceHolder = assetChangeRequest.placeholderForCreatedAsset
            let albumChangeRequest = PHAssetCollectionChangeRequest(for: self.assetCollection)
            albumChangeRequest?.addAssets([assetPlaceHolder] as NSFastEnumeration)
        }, completionHandler: { success, error in
            if success {
                print("Image saved successfully")
                completion(true)
            }
            else {
                print("Error saving image: \(String(describing: error))")
                completion(false)
            }
        })
    }
}
