//
//  ResuableProtocol.swift
//  DemoByNarendraYadavv
//
//  Created by Narendra Yadav on 30/01/23.
//

import Foundation
import UIKit

protocol ReusableProtocol {
    static var ReuseIdentifier: String { get }
    static var NibName: String { get }
}

extension ReusableProtocol {
    static var ReuseIdentifier: String {
        return String(describing: Self.self)
    }
    static var NibName: String {
        return String(describing: Self.self)
    }
    static func nib() -> UINib? {
        if NibName.count > 0 {
            return UINib(nibName: NibName, bundle: nil)
        } else {
            return nil
        }
    }
}

extension ReusableProtocol where Self: UITableViewCell {
    static func registerNibForTable(_ table: UITableView) {
        if let nib = self.nib() {
            table.register(nib, forCellReuseIdentifier: self.ReuseIdentifier)
        }
    }
}

extension ReusableProtocol where Self: UITableViewHeaderFooterView {
    static func registerNibForTable(_ table: UITableView) {
        if let nib = self.nib() {
            table.register(nib, forHeaderFooterViewReuseIdentifier: self.ReuseIdentifier)
        }
    }
}

extension ReusableProtocol where Self: UICollectionViewCell {
    static func registerNibForCollection(_ collectionView: UICollectionView) {
        if let nib = self.nib() {
            collectionView.register(nib, forCellWithReuseIdentifier: self.ReuseIdentifier)
        }
    }
}

extension ReusableProtocol where Self: UICollectionReusableView {
    static func registerNibForCollection(_ collectionView: UICollectionView, kind: String) {
        if let nib = self.nib() {
            collectionView.register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: self.ReuseIdentifier)
        }
    }
}

