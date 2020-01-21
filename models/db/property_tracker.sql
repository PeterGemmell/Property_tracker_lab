DROP TABLE IF EXISTS properties_tracker;

CREATE TABLE properties_tracker(
  id SERIAL PRIMARY KEY,
  address VARCHAR(255),
  value INT,
  number_of_bedrooms INT,
  year_built INT
)
