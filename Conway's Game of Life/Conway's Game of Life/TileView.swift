//
//  CGOLTileView.swift
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

import UIKit

public class TileView: UIView {
    
    // --------------------
    // MARK: - Properties -
    // --------------------
    
    public var coordinates: TileCoordinates!
    public var twoWayBinding: TwoWayBinding?
    
    
    // -----------------
    // MARK: - Touches -
    // -----------------
    
    override public func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override public func touchesEnded(touches: NSSet!, withEvent event: UIEvent!) {
        alive = !alive
    }

    public dynamic var alive: Bool = false {
        didSet {
            layer.backgroundColor = !alive ?
                UIColor.whiteColor().CGColor :
                UIColor(white: 0.3, alpha: 1.0).CGColor
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        // Init design
        layer.borderWidth = 1.0
        layer.borderColor = UIColor(white: 0.0, alpha: 0.03).CGColor
        layer.backgroundColor = UIColor.whiteColor().CGColor
    }
    
    required public init(coder: NSCoder) {
        super.init(coder: coder)
    }

}
