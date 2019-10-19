//
//  DateFormatter.swift
//  TheMovieApp
//
//  Created by Samir on 10/18/19.
//  Copyright © 2019 Samir Anghan. All rights reserved.
//

import Foundation

class DateStringFormatter {
    static let instance = DateFormatter()
    
    static func format(dateString: String) -> String {
        instance.dateFormat = "yyyy-MM-dd"
        
        guard let date = instance.date(from: dateString) else { return dateString }
        instance.dateFormat = "MMM dd, yyyy"
        return instance.string(from: date)
    }
}
