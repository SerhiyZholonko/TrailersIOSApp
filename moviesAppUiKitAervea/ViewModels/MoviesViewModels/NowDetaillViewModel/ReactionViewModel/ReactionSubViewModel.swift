//
//  ReactionSubViewModel.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 22.02.2023.
//

import Foundation


struct ReactionSubViewModel {
    //MARK: - Public
    public var pImageName: String{
        return imageName
    }
    public var pTitle: String {
        return title
    }
    public var ifLike: Bool {
        get {
            return DataService.shared.getFavoriteStatus(for: likerMarker)
        }
        set {
            DataService.shared.setFavoriteStatus(for: likerMarker, with: newValue)
            viewModelDidChange?(self)
        }
    }
    public var ifFavorite: Bool {
        get {
            return DataService.shared.getFavoriteStatus(for: favoriteMarker)
        }
        set {
            DataService.shared.setFavoriteStatus(for: favoriteMarker, with: newValue)
            viewModelDidChange?(self)
        }
    }
    public var ifComment: Bool {
        get {
            return DataService.shared.getFavoriteStatus(for: commentMarker)
        }
        set {
            DataService.shared.setFavoriteStatus(for: commentMarker, with: newValue)
            viewModelDidChange?(self)
        }
    }
    var viewModelDidChange: ((ReactionSubViewModel) -> Void)?

    //MARK: - Private
    private var imageName: String
    private var title: String
    private let likerMarker: String
    private let favoriteMarker: String
    private let commentMarker: String

    
    init(imageName: String, title: String, likerMarker: String, favoriteMarker: String, commentMarker: String) {
        self.imageName = imageName
        self.title = title
        self.likerMarker = likerMarker
        self.favoriteMarker = favoriteMarker
        self.commentMarker = commentMarker
    }
    mutating func likeButtonPressed() {
        self.ifLike.toggle()
    }
    mutating func commentButtonPressed() {
        self.ifComment.toggle()
    }
    mutating func favoriteButtonPressed() {
        self.ifFavorite.toggle()
    }
   
}
