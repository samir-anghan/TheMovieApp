//
//  Debouncer.swift
//  TheMovieApp
//
//  Created by Samir on 10/17/19.
//  Copyright © 2019 Samir Anghan. All rights reserved.
//
//  https://gist.github.com/bradfol/541c010a6540404eca0f4a5da009c761

import Foundation

class Debouncer {
    
    /**
     Create a new Debouncer instance with the provided time interval.
     
     - parameter timeInterval: The time interval of the debounce window.
     */
    init(timeInterval: TimeInterval, handler: Handler? = nil) {
        self.timeInterval = timeInterval
        self.handler = handler
    }
    
    typealias Handler = () -> Void
    
    /// Closure to be debounced.
    /// Perform the work you would like to be debounced in this handler.
    var handler: Handler?
    
    /// Time interval of the debounce window.
    private let timeInterval: TimeInterval
    
    private var timer: Timer?
    
    /// Indicate that the handler should be invoked.
    /// Begins the debounce window with the duration of the time interval parameter.
    func renewInterval() {
        // Invalidate existing timer if there is one
        timer?.invalidate()
        // Begin a new timer from now
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false, block: { [weak self] timer in
            self?.handleTimer(timer)
        })
    }
    
    private func handleTimer(_ timer: Timer) {
        guard timer.isValid else {
            return
        }
        handler?()
        handler = nil
    }
}
