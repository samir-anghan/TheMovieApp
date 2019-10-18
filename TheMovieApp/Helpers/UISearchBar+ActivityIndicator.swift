//
//  UISearchBar+ActivityIndicator.swift
//  TheMovieApp
//
//  Created by Samir on 10/17/19.
//  Copyright © 2019 Samir Anghan. All rights reserved.
//

import Foundation
import UIKit

/**
 Usage
 =====

 To show the acttivity indicator:
    searchController.searchBar.isLoading = true

 To stop the activity indicator (assuming it will be called when a network or extensive block is finished):
    DispatchQueue.main.async {
        searchController.searchBar.isLoading = false
    }
*/
extension UISearchBar {
    private var textField: UITextField? {
        let subViews = self.subviews.flatMap { $0.subviews }
        return (subViews.filter { $0 is UITextField }).first as? UITextField
    }
    
    private var activityIndicator: UIActivityIndicatorView? {
        return textField?.leftView?.subviews.compactMap { $0 as? UIActivityIndicatorView }.first
    }
    
    var isLoading: Bool {
        get {
            return activityIndicator != nil
        }
        set {
            if newValue {
                if activityIndicator == nil {
                    let _activityIndicator = UIActivityIndicatorView(style: .medium)
                    _activityIndicator.backgroundColor = UIColor.clear
                    _activityIndicator.startAnimating()
                    self.setImage(UIImage(), for: .search, state: .normal)
                    textField?.leftView?.addSubview(_activityIndicator)
                    let leftViewSize = textField?.leftView?.frame.size ?? CGSize.zero
                    _activityIndicator.center = CGPoint(x: leftViewSize.width / 2, y: leftViewSize.height / 2)
                }
            } else {
                self.setImage(nil, for: .search, state: .normal)
                activityIndicator?.removeFromSuperview()
            }
        }
    }
}

