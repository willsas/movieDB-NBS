//
//  Array+Extension.swift
//  movieDB-NBS
//
//  Created by Willa on 29/09/20.
//  Copyright © 2020 WillaSaskara. All rights reserved.
//

import Foundation

extension Array {
    
    /// Get value but optional
    /// please play it safe
    public subscript(safe index: Int) -> Element?{
        guard startIndex <= index && index < endIndex else {
            return nil
        }
        return self[index]
    }
 
}
