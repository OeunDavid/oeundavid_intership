const express = require("express");
const router = express.Router();
const productController = require("../controllers/products.controller");

router.get("/products", productController.getAllProducts);
router.get("/products/:id", productController.getProductById);
router.post("/products", productController.createProduct);
router.put("/products/:id", productController.updateProduct);
router.delete("/products/:productid", productController.deleteProduct);

module.exports = router;
