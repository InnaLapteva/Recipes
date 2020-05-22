//
//  MainViewController.swift
//  Recipes
//
//  Created by Инна Лаптева on 21.05.2020.
//  Copyright © 2020 Инна Лаптева. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var dataSource: UICollectionViewDiffableDataSource<Int, Int>! = nil
    var collectionView: UICollectionView! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureDataSource()
    }
}

extension MainViewController {
    
     func createLayout() -> UICollectionViewLayout {
           let layout = UICollectionViewCompositionalLayout {
               (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

               let leadingItem = NSCollectionLayoutItem(
                   layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7),
                                                     heightDimension: .fractionalHeight(1.0)))
               leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

               let trailingItem = NSCollectionLayoutItem(
                   layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                     heightDimension: .fractionalHeight(0.3)))
               trailingItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
               let trailingGroup = NSCollectionLayoutGroup.vertical(
                   layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3),
                                                     heightDimension: .fractionalHeight(1.0)),
                   subitem: trailingItem, count: 2)
                ///////
               let containerGroup = NSCollectionLayoutGroup.horizontal(
                   layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.85),
                                                     heightDimension: .fractionalHeight(0.4)),
                   subitems: [leadingItem, trailingGroup])
            
               let section = NSCollectionLayoutSection(group: containerGroup)
               section.orthogonalScrollingBehavior = .continuous
            
            
            /*test*/
            
            let testLeadingItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5)))
            testLeadingItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            
            let testLeadingGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0)), subitem: testLeadingItem, count: 2)
            

            let testTrailingItem = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                                  heightDimension: .fractionalHeight(1.0)))
            testTrailingItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            
            let testContainerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.4)), subitems: [testLeadingGroup, testTrailingItem])
            
            let testSection = NSCollectionLayoutSection(group: testContainerGroup)
            testSection.orthogonalScrollingBehavior = .continuous

            

               return testSection

           }
        return layout
        
    }
    
    func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.register(TextCell.self, forCellWithReuseIdentifier: TextCell.reuseIdentifier)
        collectionView.register(ListCell.self, forCellWithReuseIdentifier: ListCell.reuseIdentifier)
        view.addSubview(collectionView)
        collectionView.delegate = self
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Int, Int>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: Int) -> UICollectionViewCell? in

            // Get a cell of the desired kind.
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TextCell.reuseIdentifier,
                for: indexPath) as? TextCell
                else { fatalError("Cannot create new cell") }

            // Populate the cell with our item description.
            cell.label.text = "\(indexPath.section), \(indexPath.item)"
            cell.imageView.image = UIImage(named: "cake")
            cell.imageView.contentMode = .scaleAspectFit
          //  cell.contentView.backgroundColor = .blue
            cell.contentView.layer.borderColor = UIColor.black.cgColor
            cell.contentView.layer.borderWidth = 1
            cell.contentView.layer.cornerRadius = 8
            cell.label.textAlignment = .center
            cell.label.font = UIFont.preferredFont(forTextStyle: .title1)

            // Return the cell.
            return cell
        }

        // initial data
        var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
        var identifierOffset = 0
        let itemsPerSection = 8
        for section in 0..<3 {
            snapshot.appendSections([section])
            let maxIdentifier = identifierOffset + itemsPerSection
            snapshot.appendItems(Array(identifierOffset..<maxIdentifier))
            identifierOffset += itemsPerSection
        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}


//MARK: SwiftUI
import SwiftUI

struct MainViewControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
}

struct ContainerView: UIViewControllerRepresentable {
    
    let viewController = MainViewController()
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ContainerView>) -> MainViewController {
        return viewController
    }
    func updateUIViewController(_ uiViewController: ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<ContainerView>) {
        
    }
    
}

