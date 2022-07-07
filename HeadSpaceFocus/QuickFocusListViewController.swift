//
//  QuickFocusListViewController.swift
//  HeadSpaceFocus
//
//  Created by Songhee Choi on 2022/07/07.
//

import UIKit

class QuickFocusListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let breathingList = QuickFocus.breathing
    let walkingList = QuickFocus.walking
    
    enum Section: CaseIterable { // CaseIterable : 케이스를 모두 배열로 가져올 수 있게 Section.allCases 쓸 수 있음
        case breathe
        case walking
        
        var title: String {
            switch self {
            case .breathe: return "breathing exercises"
            case .walking: return "Mindful walks"
            }
        }
    }
    
    typealias Item = QuickFocus
    var datasource: UICollectionViewDiffableDataSource<Section, Item>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Presentation //
        datasource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuickFocusCell", for: indexPath) as? QuickFocusCell else { return nil }
            
            cell.configure(item)
            return cell
        })
        
        //header
        datasource?.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "QuickFocusHeaderView", for: indexPath) as? QuickFocusHeaderView else {
                return nil
            }
            let allSections = Section.allCases
            let section = allSections[indexPath.section]
            header.configure(section.title)
            return header
        }
        
        // Data //
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.breathe, .walking]) //동일: snapshot.appendSections(Section.allCases)
        snapshot.appendItems(breathingList, toSection: .breathe)
        snapshot.appendItems(walkingList, toSection: .walking)
        datasource?.apply(snapshot)
        
        // Layout //
        collectionView.collectionViewLayout = layout()
        self.navigationItem.largeTitleDisplayMode = .never // 라지 타이틀 없앰
        
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .estimated(50))
        let item = NSCollectionLayoutItem(layoutSize: layoutSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        group.interItemSpacing = .fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 20, bottom: 30, trailing: 20)
        section.interGroupSpacing = 20
        
        // header
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [header] // 헤더 관리하는데에 넣어줌
        
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }

}
