const express = require('express');
const mysql = require('mysql2/promise');
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();
app.use(bodyParser.json());
app.use(cors({
  origin: '*',
  methods: ['GET', 'POST', 'PUT', 'DELETE'],
  allowedHeaders: ['Content-Type', 'Authorization']
}));

const dbConfig = {
  host: 'localhost',
  user: 'root',
  password: 'root',
  database: 'my_app_db',
};

const db = mysql.createPool(dbConfig);

// Create item endpoint
app.post('/items', async (req, res) => {
  const { name, category, description, price, timestamp } = req.body;
  if (!name || !category || !description || !price || !timestamp) {
    return res.status(400).send({ message: 'Invalid request. Please provide all required parameters.' });
  }
  const query = `INSERT INTO items (name, category, description, price, timestamp) VALUES (?, ?, ?, ?, ?)`;
  try {
    const [result] = await db.execute(query, [name, category, description, price, timestamp]);
    res.status(201).send({ id: result.insertId });
  } catch (err) {
    console.error(err);
    res.status(500).send({ message: 'Error creating item' });
  }
});

// Get items endpoint
app.get('/items', async (req, res) => {
  const query = 'SELECT * FROM items';
  try {
    const [results] = await db.execute(query);
    res.send(results);
  } catch (err) {
    console.error(err);
    res.status(500).send({ message: 'Error fetching items' });
  }
});

// Get single item endpoint
app.get('/items/:id', async (req, res) => {
  const id = req.params.id;
  const query = 'SELECT * FROM items WHERE id = ?';
  try {
    const [results] = await db.execute(query, [id]);
    if (results.length > 0) {
      res.send(results[0]);
    } else {
      res.status(404).send({ message: 'Item not found' });
    }
  } catch (err) {
    console.error(err);
    res.status(500).send({ message: 'Error fetching item' });
  }
});

// Update item endpoint
app.put('/items/:id', async (req, res) => {
  const id = req.params.id;
  const { name, category, description, price } = req.body;
  if (!id || !name || !category || !description || !price) {
    return res.status(400).send({ message: 'Invalid request. Please provide all required parameters.' });
  }
  const query = `UPDATE items SET name = ?, category = ?, description = ?, price = ? WHERE id = ?`;
  try {
    await db.execute(query, [name, category, description, price, id]);
    res.send({ message: 'Item updated successfully' });
  } catch (err) {
    console.error(err);
    res.status(500).send({ message: 'Error updating item' });
  }
});

// Delete item endpoint
app.delete('/items/:id', async (req, res) => {
  const id = req.params.id;
  const query = `DELETE FROM items WHERE id = ?`;
  try {
    await db.execute(query, [id]);
    res.send({ message: 'Item deleted successfully' });
  } catch (err) {
    console.error(err);
    res.status(500).send({ message: 'Error deleting item' });
  }
});

// Cashout item endpoint
app.post('/items/:id/cashout', async (req, res) => {
  const id = req.params.id;
  const { exitPrice, reason, exitAt } = req.body;
  if (!id || !exitPrice || !reason || !exitAt) {
    return res.status(400).send({ message: 'Invalid request. Please provide all required parameters.' });
  }
  const query = `UPDATE items SET exit_price = ?, reason = ?, exit_at = ? WHERE id = ?`;
  try {
    await db.execute(query, [exitPrice, reason, exitAt, id]);
    res.send({ message: 'Item cashed out successfully' });
  } catch (err) {
    console.error(err);
    res.status(500).send({ message: 'Error cashing out item' });
  }
});

app.listen(3000, () => {
  console.log('API listening on port 3000');
});
