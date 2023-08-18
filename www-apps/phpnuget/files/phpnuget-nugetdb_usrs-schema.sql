CREATE TABLE nugetdb_usrs (
  UserId char(128) NOT NULL,
  Name char(128) DEFAULT "",
  Company char(128) DEFAULT NULL,
  Md5Password char(255) NOT NULL,
  Packages char(128) DEFAULT NULL,
  Enabled tinyint(1) NOT NULL DEFAULT 1,
  Email char(128) NOT NULL,
  Token char(128) NOT NULL,
  Admin tinyint(1) DEFAULT 0,
  Id char(128) NOT NULL
);
