//
//  MainViewController.swift
//  Recipes
//
//  Created by Инна Лаптева on 21.05.2020.
//  Copyright © 2020 Инна Лаптева. All rights reserved.
//

import UIKit


struct Recipe: Hashable, Decodable {
    var recipeName: String
    var recipeImageString: String
    var ingredints: String
}

enum Section: Int, CaseIterable {
    case backings
    case soups
    case salads
    case meals
}


class MainViewController: UIViewController {
    
     static let headerElementKind = "header-element-kind"
    
     var collectionView: UICollectionView!
     var dataSource: UICollectionViewDiffableDataSource<Section, Recipe>?
    
    
    //этого тут не будет. Найти json!
    let backings: [Recipe] = [Recipe(recipeName: "Мильфей", recipeImageString: "cake", ingredints: "Слоеное тесто, взбитые сливки, ягоды"),
    Recipe(recipeName: "Мильфей1", recipeImageString: "cake", ingredints: "Слоеное тесто, взбитые сливки, ягоды"),
    Recipe(recipeName: "Мильфей2", recipeImageString: "cake", ingredints: "Слоеное тесто, взбитые сливки, ягоды"),
    Recipe(recipeName: "Мильфей3", recipeImageString: "cake", ingredints: "Слоеное тесто, взбитые сливки, ягоды"),
    Recipe(recipeName: "Мильфей4", recipeImageString: "cake", ingredints: "Слоеное тесто, взбитые сливки, ягоды")]
    
    let soups: [Recipe] = [Recipe(recipeName: "Борщ", recipeImageString: "soup", ingredints: "Бульон, обжарка, капуста, картошка"),
    Recipe(recipeName: "Борщ1", recipeImageString: "soup", ingredints: "Бульон, обжарка, капуста, картошка"),
    Recipe(recipeName: "Борщ2", recipeImageString: "soup", ingredints: "Бульон, обжарка, капуста, картошка"),
    Recipe(recipeName: "Борщ3", recipeImageString: "soup", ingredints: "Бульон, обжарка, капуста, картошка"),
    Recipe(recipeName: "Борщ4", recipeImageString: "soup", ingredints: "Бульон, обжарка, капуста, картошка"),
    Recipe(recipeName: "Борщ5", recipeImageString: "soup", ingredints: "Бульон, обжарка, капуста, картошка")]
    
    let salads: [Recipe] = [Recipe(recipeName: "Капрезе", recipeImageString: "salad", ingredints: "Помидоры, моцарелла, бальзамический соус"),
    Recipe(recipeName: "Капрезе1", recipeImageString: "salad", ingredints: "Помидоры, моцарелла, бальзамический соус"),
    Recipe(recipeName: "Капрезе2", recipeImageString: "salad", ingredints: "Помидоры, моцарелла, бальзамический соус"),
    Recipe(recipeName: "Капрезе3", recipeImageString: "salad", ingredints: "Помидоры, моцарелла, бальзамический соус"),
    Recipe(recipeName: "Капрезе4", recipeImageString: "salad", ingredints: "Помидоры, моцарелла, бальзамический соус"),
    Recipe(recipeName: "Капрезе5", recipeImageString: "salad", ingredints: "Помидоры, моцарелла, бальзамический соус")]
    
    let meals: [Recipe] = [Recipe(recipeName: "Стейк", recipeImageString: "stake", ingredints: "Говядина, соль, перец"),
    Recipe(recipeName: "Стейк1", recipeImageString: "stake", ingredints: "Говядина, соль, перец"),
    Recipe(recipeName: "Стейк2", recipeImageString: "stake", ingredints: "Говядина, соль, перец")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchBar()
        setUpCollectionView()
        createDataSource()
        reloadData()
      
    }
}

extension MainViewController {
    //configureHierarchy()
    private func setUpCollectionView() {
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout() )
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .mainWhite()
        view.addSubview(collectionView)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell1")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell2")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell3")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell4")
        collectionView.register(TitleSupplementaryView.self,
                                forSupplementaryViewOfKind: MainViewController.headerElementKind,
                                withReuseIdentifier: TitleSupplementaryView.reuseIdentifier)
    }
    private func reloadData() {
        //следит за изменениями данных
        var snapshot = NSDiffableDataSourceSnapshot<Section, Recipe>()
        
        snapshot.appendSections([.backings, .salads, .meals, .soups])
        snapshot.appendItems(salads, toSection: .salads)
        snapshot.appendItems(soups, toSection: .soups)
        snapshot.appendItems(meals, toSection: .meals)
        snapshot.appendItems(backings, toSection: .backings)

        // регистрация снэпшот
        dataSource?.apply(snapshot, animatingDifferences: true)
        
    }
 // MARK: - setup layout
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout  { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
                   // section -> group -> item -> size
                   
                   guard let section = Section(rawValue: sectionIndex) else {fatalError("не удалось извлечь секцию ")}
                   switch section {
                   case .salads:
                    return self.createSection()
                   case .backings:
                    return self.createSection()
                   case .soups:
                    return self.createSection()
                   case .meals:
                    return self.createSection()
            }
                   
               }
        
        
        return layout
    }
    
    private func createSection() -> NSCollectionLayoutSection {

        let leadingItem = NSCollectionLayoutItem(
                       layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                                          heightDimension: .fractionalHeight(1)))
                   leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

                   let trailingItem = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.5),
                                                         heightDimension: .fractionalHeight(0.5)))
                   trailingItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
                   let trailingGroup = NSCollectionLayoutGroup.vertical(
                       layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3),
                                                         heightDimension: .fractionalHeight(1.0)),
                       subitem: trailingItem, count: 2)

                   let containerGroup = NSCollectionLayoutGroup.horizontal(
                       layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.85),
                                                         heightDimension: .fractionalHeight(0.4)),
                       subitems: [leadingItem, trailingGroup])
                   let section = NSCollectionLayoutSection(group: containerGroup)
                   section.orthogonalScrollingBehavior = .continuous
        
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(44)), elementKind: MainViewController.headerElementKind, alignment: .top)
        section.boundarySupplementaryItems = [sectionHeader]
        
        
        return section
    }
    
//MARK: - composition layout
    
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Recipe> (collectionView: collectionView, cellProvider: { (colectionView, indexPath, recipe) -> UICollectionViewCell? in
            
            guard let section = Section(rawValue: indexPath.section) else {fatalError("не удалось извлечь секцию ")}
            switch section {
            case .salads:
                let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "cell1" , for: indexPath)
                cell.backgroundColor = .green
                cell.layer.cornerRadius = 8
                return cell
            case .backings:
                let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "cell2" , for: indexPath)
                cell.backgroundColor = .blue
                return cell
            case .soups:
                let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "cell3" , for: indexPath)
                cell.backgroundColor = .yellow
                return cell
            case .meals:
                let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "cell4" , for: indexPath)
                cell.backgroundColor = .purple
                return cell
            }
        })
        guard let dataSource = dataSource else { return }
        dataSource.supplementaryViewProvider = {
                   (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
                   guard let sectionKind = Section(rawValue: indexPath.section)
                       else { fatalError("Unknown section kind") }

                   // Get a supplementary view of the desired kind.
                   if let header = collectionView.dequeueReusableSupplementaryView(
                       ofKind: kind,
                       withReuseIdentifier: TitleSupplementaryView.reuseIdentifier,
                       for: indexPath) as? TitleSupplementaryView {
                       // Populate the view with our section's description.
                       header.label.text = String(describing: sectionKind)
                       // Return the view.
                       return header
                   } else {
                       fatalError("Cannot create new header")
                   }
               }
    }
}

extension MainViewController: UISearchBarDelegate {
    
    private func setUpSearchBar() {
        
        navigationController?.navigationBar.barTintColor = .mainWhite()
        navigationController?.navigationBar.shadowImage = UIImage()
        
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        //делегат
        searchController.searchBar.delegate = self
    }
    
    // SearchBarDelegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
               
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

