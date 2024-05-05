//
//  ViewController.swift
//  videoPlay
//
//  Created by 채나연 on 5/5/24.
//

import UIKit
import AVKit

// URLSession을 통해 가져올 영상의 Decodable Model 입니다.
struct VideoInfo: Decodable {
  let id: String
  let title: String
  let thumbnailUrl: URL
  let videoUrl: URL
}

class ViewController: UITableViewController {
  
  var videoInfoList: [VideoInfo] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.fetchData()
  }
  
  // 데이터를 가져옵니다.
  private func fetchData() {
    guard
      let url = URL(
        string: "https://gist.githubusercontent.com/poudyalanil/ca84582cbeb4fc123a13290a586da925/raw/14a27bd0bcd0cd323b35ad79cf3b493dddf6216b/videos.json"
      )
    else { return }
    
    Task {
      do {
        let (data, _) = try await URLSession.shared.data(from: url)
        let videoInfoList = try JSONDecoder().decode([VideoInfo].self, from: data)
        self.videoInfoList = videoInfoList
        self.tableView.reloadData()
      } catch {
        print("Error: \(error)")
      }
    }
  }
  
  // AVPlayerController를 띄웁니다.
  private func presentPlayerViewController(videoURL: URL) {
    // AVPlayerController 생성
    let playerController = AVPlayerViewController()

    // AVPlayer 생성
    let player = AVPlayer(url: videoURL as URL)

    // AVPlayer 할당
    playerController.player = player

    // AVPlayerController 노출
    self.present(playerController, animated: true) {
      player.play() // present 되면, 비디오 재생
    }
  }
}

extension ViewController {
  // productList의 count를 반환합니다.
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.videoInfoList.count
  }
  
  // tableView cell의 높이를 반환합니다.
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100 // 100으로 고정
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let product = self.videoInfoList[indexPath.row]
    presentPlayerViewController(videoURL: product.videoUrl)
  }
  
  // 각 index별 tableView cell을 반환합니다.
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard
      let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as? VideoCell
    else {
      return UITableViewCell()
    }
    
    let product = self.videoInfoList[indexPath.row]
    
    cell.setThumbnail(imageURL: product.thumbnailUrl)
    cell.setTitle(title: product.title)
    
    return cell
  }
}
