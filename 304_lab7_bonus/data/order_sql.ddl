CREATE TABLE user (
uid INT NOT NULL,
fname VARCHAR (20) NOT NULL,
lname VARCHAR (20) NOT NULL,
email VARCHAR (50) NOT NULL,
password VARCHAR (20) NOT NULL,
isAdmin BOOLEAN NOT NULL,
postalcode  CHAR (6) NOT NULL,
PRIMARY KEY (uid)
FOREIGN KEY (postalcode) REFERENCES location (postalcode)
ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE Location (
postalcode CHAR (6) NOT NULL,
address VARCHAR (50) NOT NULL,
city VARCHAR (2) NOT NULL,
region VARCHAR (20) NOT NULL,
PRIMARY KEY (postalcode)
);

CREATE TABLE shipping (
sid INT NOT NULL,
shipmethod VARCHAR (20) NOT NULL,
status INT NOT NULL,
description VARCHAR (5000),
postalcode CHAR (6) NOT NULL,
PRIMARY KEY (sid),
FOREIGN KEY (postalcode) REFERENCES Location(postalcode)
ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE customerorder (
coid INT NOT NULL,
uid INT NOT NULL,
pid INT NOT NULL,
pmid INT NOT NULL,
price INT NOT NULL
PRIMARY KEY (coid)
FOREIGN KEY (postalcode) REFERENCES Location (postalcode)
FOREIGN KEY (pid) REFERENCES Product (pid)
ON DELETE SET NULL ON UPDATE CASCADE
FOREIGN KEY (uid) REFERENCES user (uid)
ON DELETE SET NULL ON UPDATE CASCADE
FOREIGN KEY (pid) REFERENCES product (pid)
ON DELETE SET NULL ON UPDATE CASCADE
FOREIGN KEY (pmid) REFERENCES paymentmethod (pmid)
ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE paymentmethod (
pmid INT NOT NULL,
uid INT NOT NULL,
postalcode INT NOT NULL,
PRIMARY KEY (pmid, uid) 
FOREIGN KEY (uid) REFERENCES user (uid)
ON DELETE SET NULL ON UPDATE CASCADE
FOREIGN KEY (postalcode) REFERENCES location (postalcode)
ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE creditcard (
pmid INT NOT NULL,
uid INT NOT NULL,
postalcode CHAR (6) NOT NULL,
billingname VARCHAR (50) NOT NULL, 
cardnum INT NOT NULL,
validtill DATE NOT NULL,
PRIMARY KEY (pmid, postalcode, uid),
FOREIGN KEY (postalcode) REFERENCES Location (postalcode),
ON DELETE SET NULL ON UPDATE CASCADE
FOREIGN KEY (uid) REFERENCES User (uid),
ON DELETE SET NULL ON UPDATE CASCADE
);


CREATE TABLE debitcard (
pmid INT NOT NULL,
uid INT NOT NULL,
postalcode CHAR (6) NOT NULL,
billingname VARCHAR (50) NOT NULL, 
cardnum INT NOT NULL,
validtill DATE NOT NULL,
PRIMARY KEY (pmid, postalcode, uid),
FOREIGN KEY (postalcode) REFERENCES location (postalcode),
ON DELETE SET NULL ON UPDATE CASCADE
FOREIGN KEY (uid) REFERENCES User (uid),
ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE product (
pid INT NOT NULL,
supid INT NOT NULL,
pname VARCHAR (50) NOT NULL,
price DECIMAL (10,2) NOT NULL,
description VARCHAR (5000),
image BLOB,
PRIMARY KEY (pid)
FOREIGN KEY (supid) REFERENCES supplier (supid)
ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE category (
cid INT NOT NULL,
pid INT NOT NULL,
PRIMARY KEY (cid)
FOREIGN KEY (pid) REFERENCES product (pid)
ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE supplier (
supid INT NOT NULL,
supname VARCHAR (50) NOT NULL,
PRIMARY KEY (supid)
);

CREATE TABLE hasordered (
coid INT NOT NULL,
pid INT NOT NULL,
quantity INT NOT NULL,
PRIMARY KEY (coid, pid),
FOREIGN KEY (coid) REFERENCES customerorder (coid)
ON DELETE SET NULL ON UPDATE CASCADE
FOREIGN KEY (pid) REFERENCES product (pid)
ON DELETE SET NULL ON UPDATE CASCADE
)

CREATE TABLE cart (
uid INT NOT NULL,
pid INT NOT NULL,
quantity INT NOT NULL,
PRIMARY KEY (uid, pid)
FOREIGN KEY (uid) REFERENCES user (uid)
ON DELETE SET NULL ON UPDATE CASCADE
FOREIGN KEY (pid) REFERENCES product (pid)
ON DELETE SET NULL ON UPDATE CASCADE
);
