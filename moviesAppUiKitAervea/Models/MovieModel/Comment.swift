//
//  File.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 28.02.2023.
//

import Foundation
class Comment {
    var commentId: Int
    var commentText: String
    var replies: [Reply]

    init(commentId: Int, commentText: String, replies: [Reply]) {
        self.commentId = commentId
        self.commentText = commentText
        self.replies = replies
    }
}

class Reply {
    var replyId: Int
    var replyText: String

    init(replyId: Int, replyText: String) {
        self.replyId = replyId
        self.replyText = replyText
    }
}

