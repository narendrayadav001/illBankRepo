//
//  ListProtocols.swift
//  DemoByNarendraYadavv
//
//  Created by Narendra Yadav on 30/01/23.
//


import Foundation
import UIKit

protocol ViewToPresenterProtocol: AnyObject{
    var view: PresenterToViewProtocol? {get set}
    var interactor: PresenterToInteractorProtocol? {get set}
    var router: PresenterToRouterProtocol? {get set}
    func startFetchingList()
    func onSearch(searchTerm: String, listArry: [ListModelDetail])
}
protocol PresenterToViewProtocol: AnyObject{
    func showList(listArray: [ListModelDetail])
    func showSearchResult(searchTerm: String,listData: [ListModelDetail])
    func showError()
}

protocol PresenterToRouterProtocol: AnyObject {
    static func createModule()-> ListViewController
}

protocol PresenterToInteractorProtocol: AnyObject {
    var presenter:InteractorToPresenterProtocol? {get set}
    func fetchList()
    func onSearch(searchTerm: String, listArry: [ListModelDetail])
}

protocol InteractorToPresenterProtocol: AnyObject {
    func showSearchResult(searchTerm: String, listData: [ListModelDetail])
    func listFetchedSuccess(listModelArray: [ListModelDetail])
    func listFetchFailed()
}

