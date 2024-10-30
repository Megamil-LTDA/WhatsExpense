CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL
);

CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL
);

CREATE TABLE expenses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    description VARCHAR(255) NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    date DATE NOT NULL,
    category_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

CREATE TABLE expense_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    expense_id INT,
    item_name VARCHAR(255) NOT NULL,
    item_price DECIMAL(10, 2) NOT NULL,
    quantity INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,
    FOREIGN KEY (expense_id) REFERENCES expenses(id)
);

INSERT INTO categories (name, description) VALUES
('Alimentação', 'Gastos com alimentação, como restaurantes e lanches'),
('Contas', 'Pagamentos de contas fixas, como água, luz e internet'),
('Lazer', 'Gastos com entretenimento, como cinema e jogos'),
('Transporte', 'Gastos com transporte, como combustível e passagens'),
('Saúde', 'Gastos com saúde e bem-estar, como consultas e medicamentos'),
('Casa', 'Gastos com compras para casa, como eletrodomésticos e móveis');

-- Teste
INSERT INTO expense_items (item_name, item_price, quantity, created_at) VALUES ('Arroz', 4.99, 1, NOW());
INSERT INTO expense_items (item_name, item_price, quantity, created_at) VALUES ('Feijão', 6.50, 1, NOW());
INSERT INTO expense_items (item_name, item_price, quantity, created_at) VALUES ('Macarrão', 3.75, 1, NOW());
INSERT INTO expense_items (item_name, item_price, quantity, created_at) VALUES ('Óleo', 5.00, 1, NOW());
INSERT INTO expense_items (item_name, item_price, quantity, created_at) VALUES ('Açúcar', 2.50, 1, NOW());
