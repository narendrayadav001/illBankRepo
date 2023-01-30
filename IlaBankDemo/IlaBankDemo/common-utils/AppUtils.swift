//
//  AppUtils.swift
//  DemoByNarendraYadavv
//
//  Created by Narendra Yadav on 30/01/23.
//

import Foundation
import UIKit

// MARK: -  Load Json Data From Local File
func loadJsonDataFromFile(_ path: String, completion: (Data?) -> Void) {
    if let fileUrl = Bundle.main.url(forResource: path, withExtension: "json") {
        do {
            let data = try Data(contentsOf: fileUrl, options: [])
            completion(data as Data)
        } catch (_) {
            completion(nil)
        }
    }
}



