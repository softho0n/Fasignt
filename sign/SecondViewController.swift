//
//  SecondViewController.swift
//  sign
//
//  Created by Jason on 2022/02/21.
//

import UIKit

class SecondViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CSCollectionViewCell
        cell.lbl.text = name
        cell.layer.borderWidth = 0.35
        cell.lbl.font = UIFont(name: fontList[indexPath.row], size: 15)
        return cell
    }
    
    var fontList = [
        "BlackHanSans-Regular",
        "DoHyeon-Regular",
        "GothicA1-Regular",
        "NanumBrushScript-Regular",
        "PoorStory-Regular",
        "SingleDay-Regular",
        "EastSeaDokdo-Regular",
        "KirangHaerang-Regular",
        "NotoSansKR-Regular",
        "NotoSerifKR-Regular"
    ]
    var name: String = ""
    var selectedIndexPath: IndexPath = IndexPath()
    
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var introView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveBtn.isEnabled = false
    
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        saveBtn.isEnabled = false
        saveBtn.isHidden = true
        introView.isHidden = false
    }
    
    @IBAction func saveSignImage(_ sender: Any) {
        let cell = self.collectionView!.cellForItem(at: selectedIndexPath) as! CSCollectionViewCell
        cell.isSelected = false
        cell.layer.borderColor = UIColor.clear.cgColor
        
        let image: UIImage!
        UIGraphicsBeginImageContext(cell.frame.size)
        cell.layer.render(in: UIGraphicsGetCurrentContext()!)
        image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
        
        cell.layer.borderColor = UIColor.black.cgColor
        
        let alert = UIAlertController(title: "알림", message: "저장되었습니다!", preferredStyle: UIAlertController.Style.alert)
        let defaultAction =  UIAlertAction(title: "확인", style: UIAlertAction.Style.default)
        alert.addAction(defaultAction)
        self.present(alert, animated: false)
    }
    
    @IBAction func generateSaveralFonts(_ sender: Any) {
        introView.isHidden = true
        name = nameField.text!
        nameField.text = ""
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.collectionView.collectionViewLayout.invalidateLayout()
        }
    }
}

extension SecondViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        saveBtn.isEnabled = true
        saveBtn.isHidden = false
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 2 - 3
        let size = CGSize(width: width, height: width / 2)
        return size
    }
}
