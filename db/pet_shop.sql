DROP TABLE pet_shops;
DROP TABLE pets;


CREATE TABLE pets (
  id SERIAL4 primary key,
  name VARCHAR(255),
  type VARCHAR(255)
);

CREATE TABLE pet_shops (
  id SERIAL4 primary key,
  name VARCHAR(255),
  address VARCHAR(255),
  stock_type VARCHAR(255),
  pet_id INT4 references pets(id)
);