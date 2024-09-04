const express = require('express');
const app = express();
const db = require('./db');

const bodyParser = require('body-parser');
app.use(bodyParser.json()); // or app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.json());

app.get('/flutter_latihan_arsip_barang_items_db', async (req, res) => {
  try {
    const [rows] = await db.execute('SELECT * FROM items');
    res.json(rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Error connecting to database' });
  }
});

app.post('/flutter_latihan_arsip_barang_items_db', async (req, res) => {
  try {
    const { name, category, description, price, timestamp } = req.body;
    const timestampDate = new Date(timestamp); // Convert input value to a Date object
    const query = 'INSERT INTO items (name, category, description, price, timestamp) VALUES (?, ?, ?, ?, ?)';
    const values = [name, category, description, price, timestampDate];
    const [rows] = await db.execute(query, values);
    res.status(201).json({ success: true, message: 'Item added successfully' });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Error adding item' });
  }
});

app.get('/flutter_latihan_arsip_barang_users_db', async (req, res) => {
  try {
    const [rows] = await db.execute('SELECT * FROM users');
    res.json(rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Error connecting to database' });
  }
});

app.post('/flutter_latihan_arsip_barang_user_db', async (req, res) => {
  const { username, password } = req.body;
  try {
    const [rows] = await db.execute(
      'SELECT * FROM users WHERE username=? AND password=?',
      [username, password]
    );
    if (rows.length > 0) {
      const userRole = rows[0].role;
      res.json({ success: true, role: userRole });
    } else {
      res.status(401).json({ success: false, message: 'Invalid credentials' });
    }
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Error connecting to database' });
  }
});

app.post('/flutter_latihan_arsip_barang_register_users_db', async (req, res) => {
  const { username, password } = req.body;
  try {
    // Insert user into database
    const [rows] = await db.execute(
      'INSERT INTO users (username, password) VALUES (?, ?)',
      [username, password]
    );
    res.status(201).json({ success: true, message: 'User registered successfully' });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Error registering user' });
  }
});

app.post('/flutter_latihan_arsip_barang_update_user_role', async (req, res) => {
  const { role, username } = req.body;
  try {
    const [rows] = await db.execute(
      'UPDATE users SET role=? WHERE username=?',
      [role, username]
    );
    res.json({ success: true });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Error updating user role' });
  }
});

app.patch('/flutter_latihan_arsip_barang_items_db', async (req, res) => {
  const { id, exit_at, reason, exit_price } = req.body;
  
  try {
    await db.execute(
      'UPDATE items SET exit_at = ?, reason = ?, exit_price = ? WHERE id = ?',
      [exit_at || null, reason || null, exit_price || null, id]
    );
    res.json({ success: true });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Error updating item' });
  }
});

app.put('/flutter_latihan_arsip_barang_items_db/:id', async (req, res) => {
  const id = req.params.id;
  const { name, category, description, price, timestamp } = req.body;
  try {
    const query = 'UPDATE items SET name = ?, category = ?, description = ?, price = ?, timestamp = ? WHERE id = ?';
    const values = [name, category, description, price, timestamp, id];
    const [rows] = await db.execute(query, values);
    res.json({ success: true, message: 'Item updated successfully' });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Error updating item' });
  }
});

app.delete('/flutter_latihan_arsip_barang_items_db/:id', async (req, res) => {
  const id = req.params.id;
  try {
    const query = 'DELETE FROM items WHERE id = ?';
    const values = [id];
    const [rows] = await db.execute(query, values);
    res.json({ success: true, message: 'Item deleted successfully' });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Error deleting item' });
  }
});

app.listen(3000, () => {
  console.log('Server listening on port 3000');
});