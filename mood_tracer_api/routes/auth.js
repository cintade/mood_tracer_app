const express = require('express');
const router = express.Router();
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const User = require('../models/user');

console.log('Auth routes loaded ✅');

// SIGNUP
router.post('/signup', async (req, res) => {
  const { email, password } = req.body;
  try {
    const existing = await User.findOne({ email });
    if (existing) return res.status(400).json({ message: 'Email sudah terdaftar' });

    const hashed = await bcrypt.hash(password, 10);
    const user = new User({ email, password: hashed });
    await user.save();
    res.status(200).json({ message: 'User berhasil dibuat' });
  } catch (err) {
    res.status(500).json({ message: 'Gagal daftar', error: err.message });
  }
});

// LOGIN
router.post('/login', async (req, res) => {
  const { email, password } = req.body;
  try {
    const user = await User.findOne({ email });
    if (!user) return res.status(400).json({ message: 'Email tidak ditemukan' });

    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) return res.status(400).json({ message: 'Password salah' });

    const token = jwt.sign({ id: user._id }, 'secret123', { expiresIn: '1h' });
    res.status(200).json({ message: 'Login berhasil', token });
  } catch (err) {
    res.status(500).json({ message: 'Gagal login', error: err.message });
  }
});

module.exports = router;
