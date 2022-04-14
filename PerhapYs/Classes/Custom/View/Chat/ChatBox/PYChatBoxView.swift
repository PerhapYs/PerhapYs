//
//  PYChatBoxView.swift
//  MetaU
//
//  Created by PerhapYs on 2022/4/11.
//

import UIKit

class PYChatBoxView: UICollectionView {

    init(){
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 34.F()
        
        super.init(frame: .zero, collectionViewLayout: layout)
        self.backgroundColor = UIColor.clear
        self.delegate = self
        self.dataSource = self
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        
        self.register_PY(PYChatBoxLeftCollectionViewCell.self)
        self.register_PY(PYChatBoxRightCollectionViewCell.self)
        self.registerHeader_PY(PYChatBoxHeaderCollectionReusableView.self)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension PYChatBoxView{
    
    override func reloadData() {
        super.reloadData()
        
        self.performBatchUpdates {
            
        } completion: { isFinished in
            if isFinished{
                let lastSection = self.numberOfSections - 1
                let lastRow = self.numberOfItems(inSection: lastSection) - 1
                let lastIndexPath = IndexPath.init(row: lastRow, section: lastSection)
                self.scrollToItem(at: lastIndexPath, at: .bottom, animated: false)
            }
        }
    }
}

extension PYChatBoxView : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let edge = UIEdgeInsets.init(top: 10.F(), left: 0, bottom: 10.F(), right: 0)
        let titleHeight = 20.F()
        var height = titleHeight + edge.top + edge.bottom
        height = max(height, 48.F())
        return CGSize.init(width: collectionView.bounds.size.width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize.init(width: collectionView.bounds.size.width, height: 69.F())
    }
}
extension PYChatBoxView : UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let isLeft = indexPath.row % 2 == 0
        
        var returnCell : PYChatBoxCollectionViewCell!
        if isLeft{
            let cell = collectionView.dequeueReusableCell_PY(with: PYChatBoxLeftCollectionViewCell.self, for: indexPath)
            returnCell = cell
        }
        else{
            let cell = collectionView.dequeueReusableCell_PY(with: PYChatBoxRightCollectionViewCell.self, for: indexPath)
            returnCell = cell
        }
        returnCell?.model = nil
        return returnCell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableHeader_PY(PYChatBoxHeaderCollectionReusableView.self, for: indexPath)
        header.model = nil
        return header
    }
}
