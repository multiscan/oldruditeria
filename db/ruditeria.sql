CREATE TABLE costs (
  id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  product_id INTEGER UNSIGNED NOT NULL,
  valid_from DATETIME NULL,
  amount FLOAT NULL,
  PRIMARY KEY(id, product_id),
  INDEX costs_FKIndex1(product_id)
);

CREATE TABLE payments (
  id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id INTEGER UNSIGNED NOT NULL,
  amount FLOAT NULL,
  date DATETIME NULL,
  PRIMARY KEY(id, user_id),
  INDEX payments_FKIndex1(user_id)
);

CREATE TABLE products (
  id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(45) NOT NULL,
  picture VARCHAR(255) NULL,
  PRIMARY KEY(id)
);

CREATE TABLE purchases (
  id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id INTEGER UNSIGNED NOT NULL,
  product_id INTEGER UNSIGNED NOT NULL,
  date DATETIME NULL,
  PRIMARY KEY(id, user_id, product_id),
  INDEX purchases_FKIndex1(user_id),
  INDEX purchases_FKIndex2(product_id)
);

CREATE TABLE users (
  id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(45) NOT NULL,
  email VARCHAR(45) NOT NULL,
  camipro INTEGER UNSIGNED NULL,
  picture VARCHAR(255) NULL,
  fingerprint BLOB NULL,
  expiry DATETIME NULL,
  PRIMARY KEY(id)
);


