//
//  SpriteElementObjectDeconstructor.swift
//  SpriteKitElements
//
//  Created by Nicholas Cross on 12/04/2015.
//  Copyright (c) 2015 nacross web. All rights reserved.
//

import Foundation

var kObjectDeconstructorKey = "ObjectDeconstructorKey"

@objc class SpriteElementObjectDeconstructor : NSObject {
    
    private var callbacks: [()->()]
    
    init(callback: ()->()) {
        self.callbacks = [callback]
    }
    
    deinit {
        for callback in self.callbacks {
            callback()
        }
    }
    
    class func registerDeconstructor(object:AnyObject, callback: ()->()) {
        let existingDecon = objc_getAssociatedObject(object,  &kObjectDeconstructorKey) as! SpriteElementObjectDeconstructor?
        
        if let decon = existingDecon {
            decon.callbacks.append(callback)
        }
        else {
            let decon = SpriteElementObjectDeconstructor(callback: callback)
            objc_setAssociatedObject(object, &kObjectDeconstructorKey, decon, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
}