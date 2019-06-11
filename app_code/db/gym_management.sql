DROP TABLE bookings;
DROP TABLE members;
DROP TABLE gym_classes;

CREATE TABLE members (
  id SERIAL8 PRIMARY KEY,
  first_name VARCHAR(255),
  last_name VARCHAR(255)
);

CREATE TABLE gym_classes (
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  class_time VARCHAR(255),
  class_date VARCHAR(255),
  spaces INT8
);

CREATE TABLE bookings (
  id SERIAL8 PRIMARY KEY,
  member_id INT8 REFERENCES members(id) ON DELETE CASCADE,
  gym_class_id INT8 REFERENCES gym_classes(id) ON DELETE CASCADE
);
