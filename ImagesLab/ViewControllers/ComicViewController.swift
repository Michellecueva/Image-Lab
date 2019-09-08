//
//  ComicViewController.swift
//  ImagesLab
//
//  Created by Michelle Cueva on 9/7/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import UIKit

class ComicViewController: UIViewController {

    @IBOutlet weak var comicImage: UIImageView!
    
    var comic: Comic!
    
    var currentComic: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData(comicIssue: nil)
    }
    
    @IBAction func setCurrentComic(_ sender: UIButton) {
        loadData(comicIssue: nil)
    }
    
    @IBAction func setRandomComic(_ sender: UIButton) {
        loadData(comicIssue: getRandomComic())
    }
    
    private func loadData(comicIssue: Int?) {
        
        ComicAPIHelper.shared.getComic(num:comicIssue) {(result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let comicFromJSON):
                    self.comic = comicFromJSON
                    if self.currentComic == nil {
                        self.currentComic = self.comic.num
                    }
                    self.loadImage()
                }
            }
        }
    }
    
    
    private func loadImage() {
        ImageHelper.shared.getImage(urlStr:comic.img) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let imageFromOnline):
                    self.comicImage.image = imageFromOnline
                }
            }
        }
    }
    
    private func getRandomComic() -> Int {
        if let currentComic = currentComic {
            return Int.random(in: 0 ... currentComic)
        } else {
            return Int.random(in: 0 ... 1000)
        }
    }

}
