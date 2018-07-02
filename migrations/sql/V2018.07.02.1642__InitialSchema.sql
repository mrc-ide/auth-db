CREATE TABLE "app_user" (
"username" TEXT NOT NULL ,
"name" TEXT ,
"email" TEXT ,
"password_hash" TEXT ,
"last_logged_in" TIMESTAMP ,
PRIMARY KEY ("username")
);

CREATE TABLE user_group (
  id TEXT NOT NULL,
  name        TEXT NOT NULL,
  description TEXT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE user_group_membership (
  username   TEXT NOT NULL,
  user_group TEXT NOT NULL,
  PRIMARY KEY (username, user_group)
);

ALTER TABLE user_group_membership
  ADD FOREIGN KEY (username) REFERENCES app_user (username);
ALTER TABLE user_group_membership
  ADD FOREIGN KEY (user_group) REFERENCES user_group (id);

CREATE TABLE "permission" (
"name" TEXT NOT NULL ,
PRIMARY KEY ("name")
);

CREATE TABLE "role" (
"id"  SERIAL ,
"name" TEXT NOT NULL ,
"scope_prefix" TEXT ,
"description" TEXT NOT NULL ,
PRIMARY KEY ("id")
);

CREATE TABLE "role_permission" (
"role" INTEGER ,
"permission" TEXT NOT NULL ,
PRIMARY KEY ("role", "permission")
);

CREATE TABLE user_group_role (
user_group TEXT NOT NULL ,
role INTEGER ,
scope_id TEXT NOT NULL ,
PRIMARY KEY (user_group, role, scope_id)
);

ALTER TABLE user_group_role ADD FOREIGN KEY (user_group) REFERENCES user_group (id);
ALTER TABLE user_group_role ADD FOREIGN KEY (role) REFERENCES role (id);
