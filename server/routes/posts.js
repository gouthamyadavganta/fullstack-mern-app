import express from "express";
import { getFeedPosts, getUserPosts, likePost } from "../controllers/posts.js";
import { verifyToken } from "../middleware/auth.js";

const router = express.Router();

/* READ (Public) */
router.get("/", getFeedPosts);
router.get("/:userId/posts", getUserPosts);

/* UPDATE (Secured) */
router.patch("/:id/like", verifyToken, likePost);

export default router;

