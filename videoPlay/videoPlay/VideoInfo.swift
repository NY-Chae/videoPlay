//
//  Videonfo.swift
//  videoPlay
//
//  Created by 채나연 on 5/5/24.
//

import Foundation

struct VideoInfo: Decodable {
    let id: String
    let title: String
    let thumbnailUrl: URL
    let videoUrl: URL
}
