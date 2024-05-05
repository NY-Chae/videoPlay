//
//  VideoCell.swift
//  videoPlay
//
//  Created by 채나연 on 5/5/24.
//

import UIKit
import Foundation

class VideoCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var thumbnailView: UIImageView!
    
      func setThumbnail(imageURL: URL) {
        DispatchQueue.global().async { [weak self] in
          if let data = try? Data(contentsOf: imageURL), let image = UIImage(data: data) {
            DispatchQueue.main.async {
              self?.thumbnailView.contentMode = .scaleAspectFill
              self?.thumbnailView.image = image
            }
          } else {
            DispatchQueue.main.async {
              self?.thumbnailView.contentMode = .scaleAspectFit
              self?.thumbnailView.tintColor = .lightGray
              self?.thumbnailView.image = UIImage(systemName: "play.rectangle.fill")
            }
          }
        }
      }
      
      func setTitle(title: String) {
        self.titleLabel.text = title
      }
    }
