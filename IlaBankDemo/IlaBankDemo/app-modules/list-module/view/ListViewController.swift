//
//  ListViewController.swift
//  DemoByNarendraYadavv
//
//  Created by Narendra Yadav on 30/01/23.
//

import UIKit

class ListViewController: UIViewController {
    
    // MARK: - Outlets -
    @IBOutlet var searchview: UISearchBar!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var labelNoResultFound: UILabel!
    @IBOutlet weak var carouselCollection: UICollectionView!
    
    // MARK: - Variables-
    private var searchTerm: String?
    private var listArray: [ListModelDetail]?
    private var listArrayForSearch: [ListModelDetail]?
    private var isAnimationInProgress = false
    
    // MARK: - Presenter-
    var presentor:ViewToPresenterProtocol?
    
    // MARK: - View Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "List Module"
        configureTableAndCollectionView()
        presentor?.startFetchingList()
        self.hideKeyboardWhenTappedAround()
    }
    
    // MARK: -  Configure Table and CollectionView with cell registration
    func configureTableAndCollectionView(){
        
        ListCell.registerNibForTable(listTableView)
        CarouselCollectionCell.registerNibForCollection(carouselCollection)
        
        let layout = CarouselFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: carouselCollection.frame.width/2, height: carouselCollection.frame.height)
        carouselCollection.collectionViewLayout = layout
        
        listTableView.keyboardDismissMode = .onDrag
        self.searchview.delegate = self
        carouselCollection.delegate = self
        self.listTableView.delegate = self
        carouselCollection.dataSource = self
        self.listTableView.dataSource = self
    }
}

// MARK: - Confirm Presenter View Protocol -
extension ListViewController:PresenterToViewProtocol{
    
    // MARK: -  On Error of List fetching
    func showError() {
        let alert = UIAlertController(title: "Alert", message: "Problem Fetching List", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: -  Show List Items
    func showList(listArray: [ListModelDetail]) {
        self.listArray = listArray
        listArrayForSearch = listArray
        self.pageControl.numberOfPages = self.listArrayForSearch?.count ?? 0
        showFilterData(index: 0)
        self.listTableView.reloadData()
        
    }
    
    // MARK: -  On Searching layout If Needed
    func showSearchResult(searchTerm: String, listData: [ListModelDetail]) {
        listArray = listData
        labelNoResultFound.isHidden = true
        if listArray?.count ?? 0 <= 0 {
            labelNoResultFound.isHidden = false
        }
        if searchTerm.isEmpty {
            self.searchview.resignFirstResponder()
            UIView.animate(withDuration: 0.2) {
                self.carouselCollection.isHidden = false
                self.pageControl.isHidden = false
                self.view.layoutIfNeeded()
            }
        }
        listTableView.reloadData()
    }
    
}

// MARK: - Table Delegate and DataSource-
extension ListViewController:UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.ReuseIdentifier) as? ListCell else { return UITableViewCell() }
        
        cell.configureCell(titleText: listArray?[indexPath.row].title ?? "", imageUrl: listArray?[indexPath.row].imageUrl ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
}

// MARK: - SearchBar Delegate-
extension ListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchTerm = searchText
        self.listArray = listArrayForSearch
        if let arrayValue = self.listArray,let arrayForSearch = listArrayForSearch  {
            presentor?.onSearch(searchTerm: searchText,
                                listArry: searchText.isEmpty ? arrayForSearch : arrayValue)
        }
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

// MARK: - CollectionView Delegate and DataSource-
extension ListViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return listArrayForSearch?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCollectionCell.ReuseIdentifier, for: indexPath) as? CarouselCollectionCell else { return UICollectionViewCell() }
        if indexPath.item < listArrayForSearch?.count ?? 0 {
            cell.configureCell(imageUrl: listArrayForSearch?[indexPath.item].imageUrl ?? "")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2, height: collectionView.frame.height)
    }
    
}

// MARK: - ScrollView Delegate-
extension ListViewController: UIScrollViewDelegate {
    
    /// This function is used to Animate the top view
    private func animateCollectionView() {
        // Lock the animation functionality
        isAnimationInProgress = true
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        } completion: { [weak self] (_) in
            // Unlock the animation functionality
            self?.isAnimationInProgress = false
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // Check if the animation is locked or not
        if !isAnimationInProgress {
            // Check if an animation is required
            if scrollView.contentOffset.y > .zero &&
                !(self.carouselCollection.isHidden) {
                self.carouselCollection.isHidden = true
                self.pageControl.isHidden = true
                animateCollectionView()
            }
            else if scrollView.contentOffset.y <= .zero
                        && (self.carouselCollection.isHidden) {
                if (searchTerm?.isEmpty ?? true) {
                    self.carouselCollection.isHidden = false
                    self.pageControl.isHidden = false
                    animateCollectionView()
                }
                
            }
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let center = CGPoint(x: scrollView.contentOffset.x + (scrollView.frame.width / 2), y: (scrollView.frame.height / 2))
        if let ip = carouselCollection.indexPathForItem(at: center) {
            self.searchview.text = nil
            self.searchview.resignFirstResponder()
            pageControl.currentPage = ip.item
            showFilterData(index: ip.item)
        }
    }
    
    /// This function is used to Filter the Data
    func showFilterData(index: Int){
        if let list = listArrayForSearch?[index]{
            self.listArray = listArrayForSearch?.filter({$0.categoryId == list.categoryId})
            self.listTableView.reloadData()
        }
        
    }
}
