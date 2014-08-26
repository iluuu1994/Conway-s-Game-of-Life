//
//  CGOLView.swift
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

public class CGOLView: UIView {
    
    // --------------------
    // MARK: - Properties -
    // --------------------
    
    private var _gridWidth = 10
    private var _gridHeight = 10
    private var _gameModel: CGOLModel!
    private var _tileViews: Matrix<TileView!>!
    
    
    // --------------
    // MARK: - Init -
    // --------------
    
    public init(gridWidth: Int, gridHeight: Int) {
        super.init(frame: CGRect(x: 0, y: 0, width:500 , height: 500))
        _init(gridWidth: gridWidth, gridHeight: gridHeight)
    }
    
    required public init(coder: NSCoder) {
        super.init(coder: coder)
        _init(gridWidth: _gridWidth, gridHeight: _gridHeight)
    }

    private func _init(#gridWidth: Int, gridHeight: Int) {
        // Init values
        _gridWidth = gridWidth
        _gridHeight = gridHeight
        _gameModel = CGOLModel(gridWidth: _gridWidth, gridHeight: _gridHeight)
        _tileViews = Matrix<TileView!>(width: _gridWidth, height: _gridHeight, repeatedValue: nil)
        
        // Fill the matrix with views
        for (x, y, _) in _tileViews {
            let tileView = TileView(frame: CGRectZero)
            tileView.coordinates = (x: x, y: y)
            
            let tileModel = _gameModel.getTile(x: x, y: y)

            // Two way binding
            tileView.twoWayBinding = TwoWayBinding(
                leadingElement: tileModel,
                leadingKeyPath: "alive",
                followingElement: tileView,
                followingKeyPath: "alive"
            )
            
            addSubview(tileView)
            _tileViews[x, y] = tileView
        }
    }
    
    
    // -----------------
    // MARK: - Methods -
    // -----------------
    
    public func step() {
        _gameModel.step()
    }
    
    public func clear() {
        _gameModel.clear()
    }
    
    
    // ----------------
    // MARK: - Layout -
    // ----------------
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        _layoutTiles()
    }
    
    private func _layoutTiles() {
        for (x, y, tileView) in _tileViews {
            tileView.frame = tileFrame(x: x, y: y)
        }
    }
    
    private var tileSize: CGSize {
        return CGSize(
            width: bounds.width / CGFloat(_gridWidth),
            height: bounds.height / CGFloat(_gridHeight)
        )
    }
    
    private func tileOrigin(coordinates: TileCoordinates) -> CGPoint {
        return CGPoint(
            x: CGFloat(coordinates.x) * tileSize.width,
            y: CGFloat(coordinates.y) * tileSize.height
        )
    }
    
    private func tileFrame(coordinates: TileCoordinates) -> CGRect {
        return CGRect(
            origin: tileOrigin(coordinates),
            size: tileSize
        )
    }
    
}
