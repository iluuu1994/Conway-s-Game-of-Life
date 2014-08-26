//
//  ViewController.swift
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

class ViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet
    var _scrollView: UIScrollView!
    let _gameView = CGOLView(gridWidth: 50, gridHeight: 50)
    var _timer: NSTimer?
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _scrollView.addSubview(_gameView)
        _scrollView.contentSize = _gameView.bounds.size
        _scrollView.minimumZoomScale = min(
            _gameView.bounds.size.width / _scrollView.bounds.size.width,
            _gameView.bounds.size.height / _scrollView.bounds.size.height
        )
    }
    
    @IBAction
    private func _startStop() {
        if let timer = _timer {
            timer.invalidate()
            _timer = nil
        } else {
            _timer = NSTimer.scheduledTimerWithTimeInterval(
                1.0 / 5,
                target: self,
                selector: "_update",
                userInfo: nil,
                repeats: true
            )
        }
    }
    
    private dynamic func _update() {
        _step()
    }
    
    @IBAction
    private func _step() {
        _gameView.step()
    }
    
    @IBAction
    private func _clear() {
        _gameView.clear()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func viewForZoomingInScrollView(scrollView: UIScrollView!) -> UIView! {
        return _gameView
    }
}

