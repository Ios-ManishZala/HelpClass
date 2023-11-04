//
//  PermissionManager.swift
//  InstaDpDownLoader
//
//  Created by DREAMWORLD on 18/10/23.
//

import Foundation
import Photos
import UIKit
import MediaPlayer



extension UIViewController {
    
    func checkPhotosPermission(completion:@escaping(Bool) -> ()){
        // Request access to PhotosApp
        if #available(iOS 14, *) {
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                
                // Handle restricted or denied state
                if status == .restricted || status == .denied
                {
                    JSN.log("Photo Permission denied or restricted")
                    completion(false)
                }
                
                // Handle limited state
                if status == .notDetermined
                {
                    JSN.log("User hasn't made a decision yet")
                    completion(false)
                }
                
                // Handle authorized state
                if status == .authorized
                {
                    JSN.log("Photo authorization granted")
                    completion(true)
                }
            }
        }
        else {
            // Fallback on earlier versions
        }
    }
    
    
    func checkMediaLibraryPermission(completion: @escaping (Bool) -> Void) {
        MPMediaLibrary.requestAuthorization { status in
            
            // Handle restricted or denied state
            if status == .restricted || status == .denied
            {
                JSN.log("Music Permission denied or restricted")
                completion(false)
            }
            
            // Handle limited state
            if status == .notDetermined
            {
                JSN.log("User hasn't made a decision yet")
                completion(false)
            }
            
            // Handle authorized state
            if status == .authorized
            {
                JSN.log("Music authorization granted")
                completion(true)
            }
        }
    }
}
