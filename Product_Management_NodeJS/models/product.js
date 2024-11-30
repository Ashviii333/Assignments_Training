let products = [
    { name: "Laptop", id: "1", price: "50000", category: "Digital", manufacturingDate: "2024-01-01", expirationDate: "2026-01-01" },
    { name: "Mobile", id: "2", price: "5000", category: "Digital", manufacturingDate: "2023-01-01", expirationDate: "2025-01-01" },
];

module.exports = {
    addProduct: (product) => products.push(product),
    getAllProducts: () => products
};
