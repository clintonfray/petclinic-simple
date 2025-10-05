# echo "CREATE DATABASE IF NOT EXISTS petclinic;" | mysql -u petclinic

# echo "ALTER DATABASE petclinic DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;"| mysql -u postgres demodb
# echo "create unique index users_ux1 on users(login);" | psql -U postgres demodb
# echo "create table todos (id integer primary key, title character varying(16) not null, status integer default 0 not null, dt timestamp default now() not null);" | psql -U postgres demodb
# echo "create sequence todo_id_seq;" | psql -U postgres demodb
# echo "insert into users values(0, 'admin', 'admin');" | psql -U postgres demodb 


echo "ALTER DATABASE petclinic DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;" | mysql -u petclinic -p petclinic --database petclinic

# SCHEMA

echo "CREATE TABLE IF NOT EXISTS vets (
  id INT(4) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(30),
  last_name VARCHAR(30),
  INDEX(last_name)
) engine=InnoDB;" | mysql -u petclinic -p petclinic --database petclinic

echo "CREATE TABLE IF NOT EXISTS specialties (
  id INT(4) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(80),
  INDEX(name)
) engine=InnoDB;"

echo "CREATE TABLE IF NOT EXISTS vet_specialties (
  vet_id INT(4) UNSIGNED NOT NULL,
  specialty_id INT(4) UNSIGNED NOT NULL,
  FOREIGN KEY (vet_id) REFERENCES vets(id),
  FOREIGN KEY (specialty_id) REFERENCES specialties(id),
  UNIQUE (vet_id,specialty_id)
) engine=InnoDB;"

echo "CREATE TABLE IF NOT EXISTS types (
  id INT(4) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(80),
  INDEX(name)
) engine=InnoDB;"

echo "CREATE TABLE IF NOT EXISTS owners (
  id INT(4) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(30),
  last_name VARCHAR(30),
  address VARCHAR(255),
  city VARCHAR(80),
  telephone VARCHAR(20),
  INDEX(last_name)
) engine=InnoDB;"

echo "CREATE TABLE IF NOT EXISTS pets (
  id INT(4) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(30),
  birth_date DATE,
  type_id INT(4) UNSIGNED NOT NULL,
  owner_id INT(4) UNSIGNED,
  INDEX(name),
  FOREIGN KEY (owner_id) REFERENCES owners(id),
  FOREIGN KEY (type_id) REFERENCES types(id)
) engine=InnoDB;"

echo "CREATE TABLE IF NOT EXISTS visits (
  id INT(4) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  pet_id INT(4) UNSIGNED,
  visit_date DATE,
  description VARCHAR(255),
  FOREIGN KEY (pet_id) REFERENCES pets(id)
) engine=InnoDB;"

# DATA

echo "INSERT IGNORE INTO vets VALUES (1, 'James', 'Carter');"
echo "INSERT IGNORE INTO vets VALUES (2, 'Helen', 'Leary');"
echo "INSERT IGNORE INTO vets VALUES (3, 'Linda', 'Douglas');"
echo "INSERT IGNORE INTO vets VALUES (4, 'Rafael', 'Ortega');"
echo "INSERT IGNORE INTO vets VALUES (5, 'Henry', 'Stevens');"
echo "INSERT IGNORE INTO vets VALUES (6, 'Sharon', 'Jenkins');"

echo "INSERT IGNORE INTO specialties VALUES (1, 'radiology');"
echo "INSERT IGNORE INTO specialties VALUES (2, 'surgery');"
echo "INSERT IGNORE INTO specialties VALUES (3, 'dentistry');"

echo "INSERT IGNORE INTO vet_specialties VALUES (2, 1);"
echo "INSERT IGNORE INTO vet_specialties VALUES (3, 2);"
echo "INSERT IGNORE INTO vet_specialties VALUES (3, 3);"
echo "INSERT IGNORE INTO vet_specialties VALUES (4, 2);"
echo "INSERT IGNORE INTO vet_specialties VALUES (5, 1);"

echo "INSERT IGNORE INTO types VALUES (1, 'cat');"
echo "INSERT IGNORE INTO types VALUES (2, 'dog');"
echo "INSERT IGNORE INTO types VALUES (3, 'lizard');"
echo "INSERT IGNORE INTO types VALUES (4, 'snake');"
echo "INSERT IGNORE INTO types VALUES (5, 'bird');"
echo "INSERT IGNORE INTO types VALUES (6, 'hamster');"

echo "INSERT IGNORE INTO owners VALUES (1, 'George', 'Franklin', '110 W. Liberty St.', 'Madison', '6085551023');"
echo "INSERT IGNORE INTO owners VALUES (2, 'Betty', 'Davis', '638 Cardinal Ave.', 'Sun Prairie', '6085551749');"
echo "INSERT IGNORE INTO owners VALUES (3, 'Eduardo', 'Rodriquez', '2693 Commerce St.', 'McFarland', '6085558763');"
echo "INSERT IGNORE INTO owners VALUES (4, 'Harold', 'Davis', '563 Friendly St.', 'Windsor', '6085553198');"
echo "INSERT IGNORE INTO owners VALUES (5, 'Peter', 'McTavish', '2387 S. Fair Way', 'Madison', '6085552765');"
echo "INSERT IGNORE INTO owners VALUES (6, 'Jean', 'Coleman', '105 N. Lake St.', 'Monona', '6085552654');"
echo "INSERT IGNORE INTO owners VALUES (7, 'Jeff', 'Black', '1450 Oak Blvd.', 'Monona', '6085555387');"
echo "INSERT IGNORE INTO owners VALUES (8, 'Maria', 'Escobito', '345 Maple St.', 'Madison', '6085557683');"
echo "INSERT IGNORE INTO owners VALUES (9, 'David', 'Schroeder', '2749 Blackhawk Trail', 'Madison', '6085559435');"
echo "INSERT IGNORE INTO owners VALUES (10, 'Carlos', 'Estaban', '2335 Independence La.', 'Waunakee', '6085555487');"

echo "INSERT IGNORE INTO pets VALUES (1, 'Leo', '2000-09-07', 1, 1);"
echo "INSERT IGNORE INTO pets VALUES (2, 'Basil', '2002-08-06', 6, 2);"
echo "INSERT IGNORE INTO pets VALUES (3, 'Rosy', '2001-04-17', 2, 3);"
echo "INSERT IGNORE INTO pets VALUES (4, 'Jewel', '2000-03-07', 2, 3);"
echo "INSERT IGNORE INTO pets VALUES (5, 'Iggy', '2000-11-30', 3, 4);"
echo "INSERT IGNORE INTO pets VALUES (6, 'George', '2000-01-20', 4, 5);"
echo "INSERT IGNORE INTO pets VALUES (7, 'Samantha', '1995-09-04', 1, 6);"
echo "INSERT IGNORE INTO pets VALUES (8, 'Max', '1995-09-04', 1, 6);"
echo "INSERT IGNORE INTO pets VALUES (9, 'Lucky', '1999-08-06', 5, 7);"
echo "INSERT IGNORE INTO pets VALUES (10, 'Mulligan', '1997-02-24', 2, 8);"
echo "INSERT IGNORE INTO pets VALUES (11, 'Freddy', '2000-03-09', 5, 9);"
echo "INSERT IGNORE INTO pets VALUES (12, 'Lucky', '2000-06-24', 2, 10);"
echo "INSERT IGNORE INTO pets VALUES (13, 'Sly', '2002-06-08', 1, 10);"

echo "INSERT IGNORE INTO visits VALUES (1, 7, '2010-03-04', 'rabies shot');"
echo "INSERT IGNORE INTO visits VALUES (2, 8, '2011-03-04', 'rabies shot');"
echo "INSERT IGNORE INTO visits VALUES (3, 8, '2009-06-04', 'neutered');"
echo "INSERT IGNORE INTO visits VALUES (4, 7, '2008-09-04', 'spayed');"
