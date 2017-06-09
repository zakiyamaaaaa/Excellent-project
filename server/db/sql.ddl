create database noside;

/*
CREATE TABLE noside.`user`
(
   uid    VARCHAR(20),
   name   VARCHAR(20),
   email  VARCHAR(20),
   latlon GEOMETRY NOT NULL,
   SPATIAL KEY latlon (latlon)
)
ENGINE=MyISAM DEFAULT CHARSET=utf8;
*/

CREATE TABLE noside.`user`
(
   uid    VARCHAR(20),
   name   VARCHAR(20),
   email  VARCHAR(20)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8;
