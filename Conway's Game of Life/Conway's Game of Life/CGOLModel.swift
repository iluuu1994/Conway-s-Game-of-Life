//
//  CGOLModel.swift
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

public class CGOLModel: NSObject {
    
    // --------------------
    // MARK: - Properties -
    // --------------------
    
    /// Holds the tile models
    private let _tiles: Matrix<TileModel!>
    
    
    // --------------
    // MARK: - Init -
    // --------------
    
    public init(gridWidth: Int, gridHeight: Int) {
        _tiles = Matrix<TileModel!>(
            width: gridWidth,
            height: gridHeight,
            repeatedValue: nil
        )
        
        for (x, y, _) in _tiles {
            _tiles[x, y] = TileModel()
        }
    }
    
    
    // -----------------
    // MARK: - Methods -
    // -----------------
    
    public func getTile(at: TileCoordinates) -> TileModel {
        return _tiles[at.x, at.y]
    }
    
    public func toggleTile(at: TileCoordinates) {
        // Toggle the state of the model
        var tile = _tiles[at.x, at.y]
        tile.alive = !tile.alive
    }
    
    public func clear() {
        for (_, _, tile) in _tiles {
            tile.alive = false
        }
    }
    
    
    // --------------------
    // MARK: - Game Logic -
    // --------------------
    
    /// http://en.wikipedia.org/wiki/Conway's_Game_of_Life#Rules
    /// 1. Any live cell with fewer than two live neighbours dies, as if caused by under-population.
    /// 2. Any live cell with two or three live neighbours lives on to the next generation.
    /// 3. Any live cell with more than three live neighbours dies, as if by overcrowding.
    /// 4. Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
    public func step() {
        // Find the tiles that must be toggled and mark them
        for (x, y, tile) in _tiles {
            let neighbours = getNeighbours(x: x, y: y).filter { $0.alive }
            
            if tile.alive {
                if neighbours.count < 2 || neighbours.count > 3 {
                    tile.shouldToggleState = true
                    
                }
            } else {
                if neighbours.count == 3 { tile.shouldToggleState = true }
            }
        }
        
        // Finally, toggle the fields that must be toggled
        for (x, y, tile) in _tiles {
            if tile.shouldToggleState {
                tile.alive = !tile.alive
                tile.shouldToggleState = false
            }
        }
    }
    
    public func getNeighbours(coordinates: TileCoordinates) -> [TileModel] {
        var neighbours = [TileModel]()
        let neighboursDelta = [(1, 0), (0, 1), (-1, 0), (0, -1),
                               (1, 1), (-1, 1), (-1, -1), (1, -1)]
        
        for (deltaX, deltaY) in neighboursDelta {
            let x = coordinates.x + deltaX
            let y = coordinates.y + deltaY
            
            if x < 0 || x >= _tiles.width { continue }
            if y < 0 || y >= _tiles.height { continue }
            
            neighbours.append(_tiles[x, y])
        }
        
        return neighbours
    }
    
}
