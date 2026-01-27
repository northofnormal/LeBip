//
//  TimeInterval+Extensions.swift
//  LeBip
//
//  Created by Anne Cahalan on 1/26/26.
//

import Foundation

extension TimeInterval {
    var readable: String {
        let (hr,  minf) = modf(self / 3600)
        let (min, secf) = modf(60 * minf)
        let (h, m, s) = (hr, min, 60 * secf)
        
        var formattedTime: String = ""

        if !h.isZero {
            formattedTime += "\(Int(h)) hours, "
        }

        if !m.isZero {
            formattedTime += "\(Int(m)) minutes, "
        }

        if !s.isZero {
            formattedTime += "\(Int(s)) seconds"
        }

        return formattedTime
    }
}
