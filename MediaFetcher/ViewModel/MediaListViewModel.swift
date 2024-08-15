//
//  MediaListViewModel.swift
//  SadadAssignment
//
//  Created by kiarash on 8/12/24.
//

import Foundation
import Combine

class MediaListViewModel: ObservableObject {
    
    @Published var mediaList: MediaList = []
    @Published var isLoading = true
    @Published var receivedError = false
    @Published var errorMessage = ""
    var cancelable: Set<AnyCancellable> = []
    
    func getMediaList() {
        self.isLoading = true
        APIClient.dispatch(APIRouter.getMediaList())
            .sink { completion in
                switch completion {
                case .finished:
                    self.isLoading = false
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.receivedError = true
                    self.isLoading = false
                }
            } receiveValue: { [weak self] mediaList in
                self?.mediaList = mediaList
            }.store(in: &cancelable)
    }
}
