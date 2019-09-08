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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData(comicIssue: 2188)
    }
    
    @IBAction func setCurrentComic(_ sender: UIButton) {
        loadData(comicIssue: nil)
    }
    private func loadData(comicIssue: Int?) {
        
        ComicAPIHelper.shared.getComic(num:comicIssue) {(result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let comicFromJSON):
                    self.comic = comicFromJSON
                    self.loadImage()
                }
            }
        }
    }
    
    
    
    func loadImage() {
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
    
    


}
