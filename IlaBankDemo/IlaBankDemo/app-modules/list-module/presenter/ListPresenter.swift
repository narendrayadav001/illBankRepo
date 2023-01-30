//
//  ListPresenter.swift
//  DemoByNarendraYadavv
//
//  Created by Narendra Yadav on 30/01/23.
//

import Foundation
import UIKit

// MARK: - List Presenter-
class ListPresenter:ViewToPresenterProtocol {
    var view: PresenterToViewProtocol?
    var interactor: PresenterToInteractorProtocol?
    var router: PresenterToRouterProtocol?
    func startFetchingList() {
        interactor?.fetchList()
    }
    func onSearch(searchTerm: String, listArry: [ListModelDetail]) {
        interactor?.onSearch(searchTerm: searchTerm, listArry: listArry)
    }
}

// MARK: - List Presenter Extension-
extension ListPresenter: InteractorToPresenterProtocol{
    func listFetchedSuccess(listModelArray: [ListModelDetail]) {
        view?.showList(listArray: listModelArray)
    }
    func listFetchFailed() {
        view?.showError()
    }
    func showSearchResult(searchTerm: String, listData: [ListModelDetail]) {
        view?.showSearchResult(searchTerm: searchTerm, listData: listData)
    }
}
