const { getPool } = require("../config/initDB"); // adjust path if needed

function validateProduct({ productName, price, stock }) {
  return productName && price > 0 && stock >= 0;
}

const getAllProducts = async (req, res) => {
  const page = parseInt(req.query.page) || 1;
  const limit = parseInt(req.query.limit) || 10;
  const offset = (page - 1) * limit;
  try {
    const pool = getPool();
    const result = await pool.query`
      SELECT * FROM PRODUCTS
      ORDER BY PRODUCTID ASC
      OFFSET ${offset} ROWS
      FETCH NEXT ${limit} ROWS ONLY
    `;
    if (result.recordset.length === 0)
      return res.status(404).json({ message: "No products found" });
    const countResult = await pool.query(
      `SELECT COUNT(*) as total FROM PRODUCTS`
    );
    const totalCount = countResult.recordset[0].total;
    res.status(200).json({ products: result.recordset, totalCount });
  } catch (err) {
    res.status(500).json({ message: "Server error", error: err.message });
  }
};

const getProductById = async (req, res) => {
  const { id } = req.params;
  try {
    const pool = getPool();
    const result =
      await pool.query`SELECT * FROM PRODUCTS WHERE PRODUCTID = ${id}`;
    if (result.recordset.length === 0)
      return res.status(404).json({ message: "Product not found" });
    res.status(200).json(result.recordset[0]);
  } catch (err) {
    res.status(500).json({ message: "Server error", error: err.message });
  }
};

const createProduct = async (req, res) => {
  const { productName, price, stock } = req.body;

  // Validate inputs
  if (!validateProduct({ productName, price, stock })) {
    return res.status(400).json({ message: "Invalid input fields" });
  }

  try {
    const pool = getPool();
    const result = await pool.query`
      INSERT INTO PRODUCTS (PRODUCTNAME, PRICE, STOCK)
      OUTPUT INSERTED.*
      VALUES (${productName}, ${price}, ${stock})
    `;

    // Return the newly inserted product
    const newProduct = result.recordset[0];
    res.status(201).json(newProduct);
  } catch (err) {
    res.status(500).json({ message: "Server error", error: err.message });
  }
};

const updateProduct = async (req, res) => {
  const { id } = req.params;
  const { productName, price, stock } = req.body;

  if (!id || isNaN(id)) {
    return res.status(400).json({ message: "Invalid product ID" });
  }

  const fields = [];
  const inputs = {};

  if (productName !== undefined) {
    fields.push("PRODUCTNAME = @productName");
    inputs.productName = productName;
  }

  if (price !== undefined) {
    if (isNaN(price)) {
      return res.status(400).json({ message: "Price must be a number" });
    }
    fields.push("PRICE = @price");
    inputs.price = price;
  }

  if (stock !== undefined) {
    if (!Number.isInteger(stock)) {
      return res.status(400).json({ message: "Stock must be an integer" });
    }
    fields.push("STOCK = @stock");
    inputs.stock = stock;
  }

  if (fields.length === 0) {
    return res
      .status(400)
      .json({ message: "No valid fields provided for update" });
  }

  const setClause = fields.join(", ");

  try {
    const pool = await getPool();
    const request = pool.request();

    for (const [key, value] of Object.entries(inputs)) {
      request.input(key, value);
    }

    request.input("id", id);

    const result = await request.query(
      `UPDATE PRODUCTS SET ${setClause} WHERE PRODUCTID = @id`
    );

    if (result.rowsAffected[0] === 0) {
      return res.status(404).json({ message: "Product not found" });
    }

    res.status(200).json({ message: "Product updated successfully" });
  } catch (err) {
    res.status(500).json({ message: "Server error", error: err.message });
  }
};

const deleteProduct = async (req, res) => {
  const { productid } = req.params;
  if (!productid || isNaN(productid)) {
    return res.status(400).json({ message: "Invalid or missing product ID" });
  }
  try {
    const pool = await getPool();
    const result = await pool
      .request()
      .input("productid", productid)
      .query("DELETE FROM PRODUCTS WHERE PRODUCTID = @productid");

    if (result.rowsAffected[0] === 0) {
      return res.status(404).json({ message: "Product not found" });
    }

    res.status(200).json({ message: "Product deleted successfully" });
  } catch (err) {
    res.status(500).json({ message: "Server error", error: err.message });
  }
};

module.exports = {
  getAllProducts,
  getProductById,
  createProduct,
  updateProduct,
  deleteProduct,
};
