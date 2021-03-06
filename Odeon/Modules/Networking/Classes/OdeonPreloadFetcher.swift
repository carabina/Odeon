//
//  OdeonPreloadFetcher.swift
//  Odeon
//
//  Created by Sherlock, James on 24/12/2018.
//  Copyright © 2018 Sherlouk. All rights reserved.
//

import Foundation
import Moya
import PromiseKit

class OdeonPreloadFetcher {

    struct Preload {
        let cinemas: [Cinema]
        let filmAttributes: [FilmAttributesResponse.Attributes]
        let performanceAttributes: [PerformanceAttributesResponse.Attributes]
    }
    
    // MARK: - Fetch
    
    func fetch() -> Promise<Preload> {
        let provider = MoyaProvider<OdeonService>()
        
        return when(fulfilled:
             provider.requestDecodePromise(.allCinemas, type: [Cinema].self),
             provider.requestDecodePromise(.filmAttributes, type: FilmAttributesResponse.self),
             provider.requestDecodePromise(.performanceAttributes, type: PerformanceAttributesResponse.self)
        ).map({ cinemas, filmAttributes, performanceAttributes -> Preload in
            
            print("[PRELOAD] Found \(cinemas.count) cinemas")
            print("[PRELOAD] Found the names of \(filmAttributes.data.count) film attributes")
            print("[PRELOAD] Found the names of \(performanceAttributes.data.count) performance attributes")
            
            return Preload(
                cinemas: cinemas,
                filmAttributes: filmAttributes.data,
                performanceAttributes: performanceAttributes.data
            )
            
        })
    }
    
}
