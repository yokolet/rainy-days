import { describe, it, expect, beforeEach, vi } from "vitest"
import { IComment } from "../../components/Comment.vue"
import { buildCommentTree } from "../useCommentTree"

describe("useCommentTree", () => {
  const comments: IComment[] = [
    {
      id: "1",
      body: "the first comment",
      username: "username1",
      updatedAt: "2018-08-09T00:00:00.000Z",
      postId: "1",
      replyId: null,
    },
    {
      id: "2",
      body: "the second comment",
      username: "whoever@example.com",
      updatedAt: "2019-09-10T00:00:00.000Z",
      postId: "1",
      replyId: null,
    },
    {
      id: "4",
      body: "a reply to the first comment",
      username: "someone",
      updatedAt: "2020-10-11T00:00:00.000Z",
      postId: "1",
      replyId: "1",
    },
    {
      id: "8",
      body: "a reply to the reply of first comment",
      username: "test@example.com",
      updatedAt: "2021-11-12T00:00:00.000Z",
      postId: "1",
      replyId: "4",
    },
    {
      id: "16",
      body: "the third comment",
      username: "whoever@example.com",
      updatedAt: "2022-12-13T00:00:00.000Z",
      postId: "1",
      replyId: null,
    },
    {
      id: "32",
      body: "a reply to the third comment",
      username: "whoever",
      updatedAt: "2022-12-13T00:00:00.000Z",
      postId: "1",
      replyId: "16",
    },
    {
      id: "64",
      body: "another reply to the third comment",
      username: "someone@example.com",
      updatedAt: "2023-01-14T00:00:00.000Z",
      postId: "1",
      replyId: "16",
    },
  ]

  it("creates a comment tree", () => {
    let graph = buildCommentTree(comments)
    console.log(graph)
  })
})
