//
//  ListInteractor.swift
//  DemoByNarendraYadavv
//
//  Created by Narendra Yadav on 30/01/23.
//

import Foundation
import UIKit

// MARK: -  List Interactor
class ListInteractor: PresenterToInteractorProtocol{
    var presenter: InteractorToPresenterProtocol?
    
    // MARK: -  Get all the data from json file and bind with the model.
    func fetchList() {
        loadJsonDataFromFile("listData") { (data) in
            if let json = data {
                do {
                    let response = try JSONDecoder().decode(ListModel.self, from: json)
                    self.presenter?.listFetchedSuccess(listModelArray: response.list ?? [ListModelDetail]())
                } catch {
                    self.presenter?.listFetchFailed()
                }
            }
        }
    }
    
    // MARK: -  Get search data list on searching.
    func onSearch(searchTerm: String, listArry: [ListModelDetail]){
        let list = searchTerm.isEmpty ? listArry : listArry.filter { $0.title!.contains(searchTerm) }
        self.presenter?.showSearchResult(searchTerm: searchTerm, listData: list)
    }
    
}
