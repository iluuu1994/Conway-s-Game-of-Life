//
//  TwoWayBinding.swift
//  Conway's Game of Life
//
//  Created by Ilija Tovilo on 26/08/14.
//  Copyright (c) 2014 Ilija Tovilo. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import Foundation

public class TwoWayBinding: NSObject {
    public let leadingElement: NSObject
    public let leadingKeyPath: String
    public let followingElement: NSObject
    public let followingKeyPath: String
    
    private enum Modifier: NSString {
        case Leading = "Leading", Following = "Following"
    }
    
    public init(leadingElement: NSObject, leadingKeyPath: String, followingElement: NSObject, followingKeyPath: String) {
        self.leadingElement = leadingElement
        self.leadingKeyPath = leadingKeyPath
        self.followingElement = followingElement
        self.followingKeyPath = followingKeyPath
        
        super.init()
        
        bind()
    }
    
    deinit {
        unbind()
    }
    
    public func bind() {
        leadingElement.addObserver(
            self,
            forKeyPath: leadingKeyPath,
            options: NSKeyValueObservingOptions.New,
            context: nil
        )
        
        followingElement.addObserver(
            self,
            forKeyPath: followingKeyPath,
            options: NSKeyValueObservingOptions.New,
            context: nil
        )
    }
    
    public func unbind() {
        leadingElement.removeObserver(followingKeyPath, forKeyPath: leadingKeyPath)
        followingElement.removeObserver(leadingKeyPath, forKeyPath: followingKeyPath)
    }
    
    override public func observeValueForKeyPath(
        keyPath: String!,
        ofObject object: AnyObject!,
        change: [NSObject : AnyObject]!,
        context: UnsafeMutablePointer<Void>)
    {
        let (from, fromKP, to, toKP) = object === leadingElement ?
            (leadingElement, leadingKeyPath, followingElement, followingKeyPath) :
            (followingElement, followingKeyPath, leadingElement, leadingKeyPath)
        
        let oldValue = to.valueForKeyPath(toKP) as NSNumber
        let newValue = from.valueForKeyPath(fromKP) as NSNumber
        
        if oldValue !== newValue {
            to.setValue(newValue, forKeyPath: toKP)
        }
    }
}
