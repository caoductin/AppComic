//
//  TabCategory.swift
//  AppComic
//
//  Created by cao duc tin  on 4/10/24.
//

import SwiftUI

enum TabCategory:String, CaseIterable, Identifiable {
    case newest = "Mới nhất"
    case law = "pháp luật"
    case education = "Giáo dục"
    case entertainment = "giải trí"
    case travel = "Du lịch"
    case sports = "Thể thao"
    case science = "Khoa học"
    
    var id: String { self.rawValue } // Required for Identifiable
}

