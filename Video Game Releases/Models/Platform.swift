//
//  Platform.swift
//  Video Game Releases
//
//  Created by George on 06/10/2019.
//  Copyright © 2019 George. All rights reserved.
//

import Foundation

enum Platform: Int, CustomStringConvertible, CaseIterable {
    case ps4 = 48
    case pc = 6
    case nswitch = 130
    case xboxone = 49
   
    
    var description: String {
        switch self {
        case .ps4: return "PS4"
        case .pc: return "PC"
        case .nswitch: return "Nintendo Switch"
        case .xboxone: return "Xbox One"

        }
    }
    
    var assetName: String {
        switch self {
        case .ps4: return "ps4"
        case .pc: return "pc"
        case .nswitch: return "switch"
        case .xboxone: return "xbox"
        }
    }
}
