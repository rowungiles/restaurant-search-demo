//
//  Networking.swift
//  RestaurantSearchDemo
//
//  Created by Rowun Giles on 26/03/2018.
//  Copyright © 2018 Rowun Giles. All rights reserved.
//

import Foundation

protocol NetworkingInterface {
    func fetchData(for url: URL, additionalHeaders: [AnyHashable: Any]?)
    func cancelFetch()
}

final class Networking<Delegate: FetchDelegate>: NetworkingInterface, Fetch {

    private weak var delegate: Delegate?
    private var task: URLSessionDataTaskProtocol?
    
    var customSession: URLSessionProtocol?
    
    deinit {
        customSession?.invalidateAndCancel()
    }
    
    func setDelegate(_ delegate: Delegate) {
        self.delegate = delegate
    }
    
    func fetchData(for url: URL, additionalHeaders: [AnyHashable: Any]? = nil) {
        if customSession == nil {
            customSession = createCustomSession(additionalHeaders: additionalHeaders)
        }
        
        task = customSession?.dataTask(with: url) { [weak self] (data, response, error) in
            self?.responseComplete(data: data, response: response, error: error)
        }
        
        task?.resume()
    }
    
    func responseComplete(data: Data?, response: URLResponse?, error: Error?) {
        if let error = error, (error as NSError).code == NSURLErrorCancelled {
            return // a cancelled error may occur if an SSL cert is out of date - but for this demo, this isn't a case I'm looking to handle.
        }
        
        switch (response as? HTTPURLResponse)?.statusCode {
        case 200?:
            delegate?.dataFetchComplete(result: successResponse(data: data))
        default:
            delegate?.dataFetchComplete(result: failureResponse(error: error))
        }
    }
    
    func successfulFetch(data: Data?) throws -> Delegate.Object {
        guard let delegate = delegate else {
            throw FetchError.delegateLost
        }
        
        return try delegate.successfulFetch(data: data)
    }
    
    private func createCustomSession(additionalHeaders: [AnyHashable: Any]?) -> URLSession {
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = additionalHeaders
        return URLSession(configuration: config, delegate: URLSession.shared.delegate, delegateQueue: OperationQueue.main)
    }
}

extension Networking {
    
    func cancelFetch() {
        task?.cancel()
        task = nil
    }
}
