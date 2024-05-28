
const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const bodyParser = require('body-parser');

const app = express();
app.use(cors());
app.use(bodyParser.json());

// MongoDB 연결
mongoose.connect('mongodb://localhost:27017/community', {
  useNewUrlParser: true,
  useUnifiedTopology: true
});

const PostSchema = new mongoose.Schema({
  title: String,
  content: String,
  author: String,
  created_at: { type: Date, default: Date.now }
});

const Post = mongoose.model('Post', PostSchema);

// 게시글 목록 조회
app.get('/posts', async (req, res) => {
  const posts = await Post.find();
  res.json(posts);
});

// 게시글 생성
app.post('/posts', async (req, res) => {
  const post = new Post(req.body);
  await post.save();
  res.status(201).send(post);
});

// 서버 시작
const PORT = 5000;
app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
