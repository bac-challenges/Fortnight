//
//  ViewModel.swift
//  CodeChallenge
//
//  Created by emile on 01/07/2022.
//

import Combine

class ViewModel: ObservableObject {
    @Published var items =  [Item]()
    @Published var chatListLoadingError: String = ""
    @Published var showAlert: Bool = false
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    var dataManager: ServiceProtocol
    private let type: ItemType
    
    init( dataManager: ServiceProtocol = Service.shared, type: ItemType = .home) {
        self.dataManager = dataManager
        self.type = type
        getItems()
    }
    
    func getItems() {
        dataManager.fetch(type)
            .sink { (dataResponse) in
                if dataResponse.error != nil {
                    self.createAlert(with: dataResponse.error!)
                } else {
                    self.items = dataResponse.value!.self
                }
            }.store(in: &cancellableSet)
    }
    
    func createAlert( with error: NetworkError ) {
        chatListLoadingError = error.backendError == nil ? error.initialError.localizedDescription : error.backendError!.message
        self.showAlert = true
    }
}
