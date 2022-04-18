-- liquibase formatted sql

-- changeset knoldus:1650267790858-1
CREATE TABLE "public"."guacamole_user" ("user_id" INTEGER GENERATED BY DEFAULT AS IDENTITY NOT NULL, "entity_id" INTEGER NOT NULL, "password_hash" BYTEA NOT NULL, "password_salt" BYTEA, "password_date" TIMESTAMP WITH TIME ZONE NOT NULL, "disabled" BOOLEAN DEFAULT FALSE NOT NULL, "expired" BOOLEAN DEFAULT FALSE NOT NULL, "access_window_start" TIME WITHOUT TIME ZONE, "access_window_end" TIME WITHOUT TIME ZONE, "valid_from" date, "valid_until" date, "timezone" VARCHAR(64), "full_name" VARCHAR(256), "email_address" VARCHAR(256), "organization" VARCHAR(256), "organizational_role" VARCHAR(256), CONSTRAINT "guacamole_user_pkey" PRIMARY KEY ("user_id"));

-- changeset knoldus:1650267790858-2
CREATE TABLE "public"."guacamole_user_group" ("user_group_id" INTEGER GENERATED BY DEFAULT AS IDENTITY NOT NULL, "entity_id" INTEGER NOT NULL, "disabled" BOOLEAN DEFAULT FALSE NOT NULL, CONSTRAINT "guacamole_user_group_pkey" PRIMARY KEY ("user_group_id"));

-- changeset knoldus:1650267790858-3
CREATE TABLE "public"."guacamole_sharing_profile" ("sharing_profile_id" INTEGER GENERATED BY DEFAULT AS IDENTITY NOT NULL, "sharing_profile_name" VARCHAR(128) NOT NULL, "primary_connection_id" INTEGER NOT NULL, CONSTRAINT "guacamole_sharing_profile_pkey" PRIMARY KEY ("sharing_profile_id"));

-- changeset knoldus:1650267790858-4
CREATE TABLE "public"."guacamole_connection_parameter" ("connection_id" INTEGER NOT NULL, "parameter_name" VARCHAR(128) NOT NULL, "parameter_value" VARCHAR(4096) NOT NULL, CONSTRAINT "guacamole_connection_parameter_pkey" PRIMARY KEY ("connection_id", "parameter_name"));

-- changeset knoldus:1650267790858-5
CREATE TABLE "public"."guacamole_sharing_profile_parameter" ("sharing_profile_id" INTEGER NOT NULL, "parameter_name" VARCHAR(128) NOT NULL, "parameter_value" VARCHAR(4096) NOT NULL, CONSTRAINT "guacamole_sharing_profile_parameter_pkey" PRIMARY KEY ("sharing_profile_id", "parameter_name"));

-- changeset knoldus:1650267790858-6
CREATE TABLE "public"."guacamole_user_attribute" ("user_id" INTEGER NOT NULL, "attribute_name" VARCHAR(128) NOT NULL, "attribute_value" VARCHAR(4096) NOT NULL, CONSTRAINT "guacamole_user_attribute_pkey" PRIMARY KEY ("user_id", "attribute_name"));

-- changeset knoldus:1650267790858-7
CREATE TABLE "public"."guacamole_user_group_attribute" ("user_group_id" INTEGER NOT NULL, "attribute_name" VARCHAR(128) NOT NULL, "attribute_value" VARCHAR(4096) NOT NULL, CONSTRAINT "guacamole_user_group_attribute_pkey" PRIMARY KEY ("user_group_id", "attribute_name"));

-- changeset knoldus:1650267790858-8
CREATE TABLE "public"."guacamole_connection_attribute" ("connection_id" INTEGER NOT NULL, "attribute_name" VARCHAR(128) NOT NULL, "attribute_value" VARCHAR(4096) NOT NULL, CONSTRAINT "guacamole_connection_attribute_pkey" PRIMARY KEY ("connection_id", "attribute_name"));

-- changeset knoldus:1650267790858-9
CREATE TABLE "public"."guacamole_connection_group_attribute" ("connection_group_id" INTEGER NOT NULL, "attribute_name" VARCHAR(128) NOT NULL, "attribute_value" VARCHAR(4096) NOT NULL, CONSTRAINT "guacamole_connection_group_attribute_pkey" PRIMARY KEY ("connection_group_id", "attribute_name"));

-- changeset knoldus:1650267790858-10
CREATE TABLE "public"."guacamole_sharing_profile_attribute" ("sharing_profile_id" INTEGER NOT NULL, "attribute_name" VARCHAR(128) NOT NULL, "attribute_value" VARCHAR(4096) NOT NULL, CONSTRAINT "guacamole_sharing_profile_attribute_pkey" PRIMARY KEY ("sharing_profile_id", "attribute_name"));

-- changeset knoldus:1650267790858-11
CREATE TABLE "public"."guacamole_connection_history" ("history_id" INTEGER GENERATED BY DEFAULT AS IDENTITY NOT NULL, "user_id" INTEGER, "username" VARCHAR(128) NOT NULL, "remote_host" VARCHAR(256) DEFAULT 'NULL::character varying', "connection_id" INTEGER, "connection_name" VARCHAR(128) NOT NULL, "sharing_profile_id" INTEGER, "sharing_profile_name" VARCHAR(128) DEFAULT 'NULL::character varying', "start_date" TIMESTAMP WITH TIME ZONE NOT NULL, "end_date" TIMESTAMP WITH TIME ZONE, CONSTRAINT "guacamole_connection_history_pkey" PRIMARY KEY ("history_id"));

-- changeset knoldus:1650267790858-12
CREATE TABLE "public"."guacamole_user_history" ("history_id" INTEGER GENERATED BY DEFAULT AS IDENTITY NOT NULL, "user_id" INTEGER, "username" VARCHAR(128) NOT NULL, "remote_host" VARCHAR(256) DEFAULT 'NULL::character varying', "start_date" TIMESTAMP WITH TIME ZONE NOT NULL, "end_date" TIMESTAMP WITH TIME ZONE, CONSTRAINT "guacamole_user_history_pkey" PRIMARY KEY ("history_id"));

-- changeset knoldus:1650267790858-13
CREATE TABLE "public"."guacamole_user_password_history" ("password_history_id" INTEGER GENERATED BY DEFAULT AS IDENTITY NOT NULL, "user_id" INTEGER NOT NULL, "password_hash" BYTEA NOT NULL, "password_salt" BYTEA, "password_date" TIMESTAMP WITH TIME ZONE NOT NULL, CONSTRAINT "guacamole_user_password_history_pkey" PRIMARY KEY ("password_history_id"));

-- changeset knoldus:1650267790858-14
CREATE TABLE "public"."guacamole_connection_group" ("connection_group_id" INTEGER GENERATED BY DEFAULT AS IDENTITY NOT NULL, "parent_id" INTEGER, "connection_group_name" VARCHAR(128) NOT NULL, "type" GUACAMOLE_CONNECTION_GROUP_TYPE DEFAULT 'ORGANIZATIONAL' NOT NULL, "max_connections" INTEGER, "max_connections_per_user" INTEGER, "enable_session_affinity" BOOLEAN DEFAULT FALSE NOT NULL, CONSTRAINT "guacamole_connection_group_pkey" PRIMARY KEY ("connection_group_id"));

-- changeset knoldus:1650267790858-15
CREATE TABLE "public"."guacamole_connection" ("connection_id" INTEGER GENERATED BY DEFAULT AS IDENTITY NOT NULL, "connection_name" VARCHAR(128) NOT NULL, "parent_id" INTEGER, "protocol" VARCHAR(32) NOT NULL, "max_connections" INTEGER, "max_connections_per_user" INTEGER, "connection_weight" INTEGER, "failover_only" BOOLEAN DEFAULT FALSE NOT NULL, "proxy_port" INTEGER, "proxy_hostname" VARCHAR(512), "proxy_encryption_method" GUACAMOLE_PROXY_ENCRYPTION_METHOD, CONSTRAINT "guacamole_connection_pkey" PRIMARY KEY ("connection_id"));

-- changeset knoldus:1650267790858-16
CREATE TABLE "public"."guacamole_entity" ("entity_id" INTEGER GENERATED BY DEFAULT AS IDENTITY NOT NULL, "name" VARCHAR(128) NOT NULL, "type" GUACAMOLE_ENTITY_TYPE NOT NULL, CONSTRAINT "guacamole_entity_pkey" PRIMARY KEY ("entity_id"));

-- changeset knoldus:1650267790858-17
ALTER TABLE "public"."guacamole_user" ADD CONSTRAINT "guacamole_user_single_entity" UNIQUE ("entity_id");

-- changeset knoldus:1650267790858-18
ALTER TABLE "public"."guacamole_user_group" ADD CONSTRAINT "guacamole_user_group_single_entity" UNIQUE ("entity_id");

-- changeset knoldus:1650267790858-19
CREATE INDEX "guacamole_sharing_profile_primary_connection_id" ON "public"."guacamole_sharing_profile"("primary_connection_id");

-- changeset knoldus:1650267790858-20
ALTER TABLE "public"."guacamole_sharing_profile" ADD CONSTRAINT "sharing_profile_name_primary" UNIQUE ("sharing_profile_name", "primary_connection_id");

-- changeset knoldus:1650267790858-21
CREATE INDEX "guacamole_connection_parameter_connection_id" ON "public"."guacamole_connection_parameter"("connection_id");

-- changeset knoldus:1650267790858-22
CREATE INDEX "guacamole_sharing_profile_parameter_sharing_profile_id" ON "public"."guacamole_sharing_profile_parameter"("sharing_profile_id");

-- changeset knoldus:1650267790858-23
CREATE INDEX "guacamole_user_attribute_user_id" ON "public"."guacamole_user_attribute"("user_id");

-- changeset knoldus:1650267790858-24
CREATE INDEX "guacamole_user_group_attribute_user_group_id" ON "public"."guacamole_user_group_attribute"("user_group_id");

-- changeset knoldus:1650267790858-25
CREATE INDEX "guacamole_connection_attribute_connection_id" ON "public"."guacamole_connection_attribute"("connection_id");

-- changeset knoldus:1650267790858-26
CREATE INDEX "guacamole_connection_group_attribute_connection_group_id" ON "public"."guacamole_connection_group_attribute"("connection_group_id");

-- changeset knoldus:1650267790858-27
CREATE INDEX "guacamole_sharing_profile_attribute_sharing_profile_id" ON "public"."guacamole_sharing_profile_attribute"("sharing_profile_id");

-- changeset knoldus:1650267790858-28
CREATE TABLE "public"."guacamole_connection_permission" ("entity_id" INTEGER NOT NULL, "connection_id" INTEGER NOT NULL, "permission" GUACAMOLE_OBJECT_PERMISSION_TYPE NOT NULL, CONSTRAINT "guacamole_connection_permission_pkey" PRIMARY KEY ("entity_id", "connection_id", "permission"));

-- changeset knoldus:1650267790858-29
CREATE TABLE "public"."guacamole_connection_group_permission" ("entity_id" INTEGER NOT NULL, "connection_group_id" INTEGER NOT NULL, "permission" GUACAMOLE_OBJECT_PERMISSION_TYPE NOT NULL, CONSTRAINT "guacamole_connection_group_permission_pkey" PRIMARY KEY ("entity_id", "connection_group_id", "permission"));

-- changeset knoldus:1650267790858-30
CREATE TABLE "public"."guacamole_sharing_profile_permission" ("entity_id" INTEGER NOT NULL, "sharing_profile_id" INTEGER NOT NULL, "permission" GUACAMOLE_OBJECT_PERMISSION_TYPE NOT NULL, CONSTRAINT "guacamole_sharing_profile_permission_pkey" PRIMARY KEY ("entity_id", "sharing_profile_id", "permission"));

-- changeset knoldus:1650267790858-31
CREATE TABLE "public"."guacamole_user_permission" ("entity_id" INTEGER NOT NULL, "affected_user_id" INTEGER NOT NULL, "permission" GUACAMOLE_OBJECT_PERMISSION_TYPE NOT NULL, CONSTRAINT "guacamole_user_permission_pkey" PRIMARY KEY ("entity_id", "affected_user_id", "permission"));

-- changeset knoldus:1650267790858-32
CREATE TABLE "public"."guacamole_user_group_permission" ("entity_id" INTEGER NOT NULL, "affected_user_group_id" INTEGER NOT NULL, "permission" GUACAMOLE_OBJECT_PERMISSION_TYPE NOT NULL, CONSTRAINT "guacamole_user_group_permission_pkey" PRIMARY KEY ("entity_id", "affected_user_group_id", "permission"));

-- changeset knoldus:1650267790858-33
CREATE TABLE "public"."guacamole_system_permission" ("entity_id" INTEGER NOT NULL, "permission" GUACAMOLE_SYSTEM_PERMISSION_TYPE NOT NULL, CONSTRAINT "guacamole_system_permission_pkey" PRIMARY KEY ("entity_id", "permission"));

-- changeset knoldus:1650267790858-34
CREATE INDEX "guacamole_connection_history_user_id" ON "public"."guacamole_connection_history"("user_id");

-- changeset knoldus:1650267790858-35
CREATE INDEX "guacamole_connection_history_connection_id" ON "public"."guacamole_connection_history"("connection_id");

-- changeset knoldus:1650267790858-36
CREATE INDEX "guacamole_connection_history_sharing_profile_id" ON "public"."guacamole_connection_history"("sharing_profile_id");

-- changeset knoldus:1650267790858-37
CREATE INDEX "guacamole_connection_history_start_date" ON "public"."guacamole_connection_history"("start_date");

-- changeset knoldus:1650267790858-38
CREATE INDEX "guacamole_connection_history_end_date" ON "public"."guacamole_connection_history"("end_date");

-- changeset knoldus:1650267790858-39
CREATE INDEX "guacamole_connection_history_connection_id_start_date" ON "public"."guacamole_connection_history"("connection_id", "start_date");

-- changeset knoldus:1650267790858-40
CREATE INDEX "guacamole_user_history_user_id" ON "public"."guacamole_user_history"("user_id");

-- changeset knoldus:1650267790858-41
CREATE INDEX "guacamole_user_history_start_date" ON "public"."guacamole_user_history"("start_date");

-- changeset knoldus:1650267790858-42
CREATE INDEX "guacamole_user_history_end_date" ON "public"."guacamole_user_history"("end_date");

-- changeset knoldus:1650267790858-43
CREATE INDEX "guacamole_user_history_user_id_start_date" ON "public"."guacamole_user_history"("user_id", "start_date");

-- changeset knoldus:1650267790858-44
CREATE INDEX "guacamole_user_password_history_user_id" ON "public"."guacamole_user_password_history"("user_id");

-- changeset knoldus:1650267790858-45
CREATE INDEX "guacamole_connection_group_parent_id" ON "public"."guacamole_connection_group"("parent_id");

-- changeset knoldus:1650267790858-46
ALTER TABLE "public"."guacamole_connection_group" ADD CONSTRAINT "connection_group_name_parent" UNIQUE ("connection_group_name", "parent_id");

-- changeset knoldus:1650267790858-47
CREATE INDEX "guacamole_connection_parent_id" ON "public"."guacamole_connection"("parent_id");

-- changeset knoldus:1650267790858-48
ALTER TABLE "public"."guacamole_connection" ADD CONSTRAINT "connection_name_parent" UNIQUE ("connection_name", "parent_id");

-- changeset knoldus:1650267790858-49
ALTER TABLE "public"."guacamole_entity" ADD CONSTRAINT "guacamole_entity_name_scope" UNIQUE ("type", "name");

-- changeset knoldus:1650267790858-50
CREATE INDEX "guacamole_connection_permission_connection_id" ON "public"."guacamole_connection_permission"("connection_id");

-- changeset knoldus:1650267790858-51
CREATE INDEX "guacamole_connection_permission_entity_id" ON "public"."guacamole_connection_permission"("entity_id");

-- changeset knoldus:1650267790858-52
CREATE INDEX "guacamole_connection_group_permission_connection_group_id" ON "public"."guacamole_connection_group_permission"("connection_group_id");

-- changeset knoldus:1650267790858-53
CREATE INDEX "guacamole_connection_group_permission_entity_id" ON "public"."guacamole_connection_group_permission"("entity_id");

-- changeset knoldus:1650267790858-54
CREATE INDEX "guacamole_sharing_profile_permission_sharing_profile_id" ON "public"."guacamole_sharing_profile_permission"("sharing_profile_id");

-- changeset knoldus:1650267790858-55
CREATE INDEX "guacamole_sharing_profile_permission_entity_id" ON "public"."guacamole_sharing_profile_permission"("entity_id");

-- changeset knoldus:1650267790858-56
CREATE INDEX "guacamole_user_permission_affected_user_id" ON "public"."guacamole_user_permission"("affected_user_id");

-- changeset knoldus:1650267790858-57
CREATE INDEX "guacamole_user_permission_entity_id" ON "public"."guacamole_user_permission"("entity_id");

-- changeset knoldus:1650267790858-58
CREATE INDEX "guacamole_user_group_permission_affected_user_group_id" ON "public"."guacamole_user_group_permission"("affected_user_group_id");

-- changeset knoldus:1650267790858-59
CREATE INDEX "guacamole_user_group_permission_entity_id" ON "public"."guacamole_user_group_permission"("entity_id");

-- changeset knoldus:1650267790858-60
CREATE INDEX "guacamole_system_permission_entity_id" ON "public"."guacamole_system_permission"("entity_id");

-- changeset knoldus:1650267790858-61
CREATE TABLE "public"."guacamole_user_group_member" ("user_group_id" INTEGER NOT NULL, "member_entity_id" INTEGER NOT NULL, CONSTRAINT "guacamole_user_group_member_pkey" PRIMARY KEY ("user_group_id", "member_entity_id"));

-- changeset knoldus:1650267790858-62
ALTER TABLE "public"."guacamole_connection_attribute" ADD CONSTRAINT "guacamole_connection_attribute_ibfk_1" FOREIGN KEY ("connection_id") REFERENCES "public"."guacamole_connection" ("connection_id") ON UPDATE NO ACTION ON DELETE CASCADE;

-- changeset knoldus:1650267790858-63
ALTER TABLE "public"."guacamole_connection_group_attribute" ADD CONSTRAINT "guacamole_connection_group_attribute_ibfk_1" FOREIGN KEY ("connection_group_id") REFERENCES "public"."guacamole_connection_group" ("connection_group_id") ON UPDATE NO ACTION ON DELETE CASCADE;

-- changeset knoldus:1650267790858-64
ALTER TABLE "public"."guacamole_connection_group" ADD CONSTRAINT "guacamole_connection_group_ibfk_1" FOREIGN KEY ("parent_id") REFERENCES "public"."guacamole_connection_group" ("connection_group_id") ON UPDATE NO ACTION ON DELETE CASCADE;

-- changeset knoldus:1650267790858-65
ALTER TABLE "public"."guacamole_connection_group_permission" ADD CONSTRAINT "guacamole_connection_group_permission_entity" FOREIGN KEY ("entity_id") REFERENCES "public"."guacamole_entity" ("entity_id") ON UPDATE NO ACTION ON DELETE CASCADE;

-- changeset knoldus:1650267790858-66
ALTER TABLE "public"."guacamole_connection_group_permission" ADD CONSTRAINT "guacamole_connection_group_permission_ibfk_1" FOREIGN KEY ("connection_group_id") REFERENCES "public"."guacamole_connection_group" ("connection_group_id") ON UPDATE NO ACTION ON DELETE CASCADE;

-- changeset knoldus:1650267790858-67
ALTER TABLE "public"."guacamole_connection_history" ADD CONSTRAINT "guacamole_connection_history_ibfk_1" FOREIGN KEY ("user_id") REFERENCES "public"."guacamole_user" ("user_id") ON UPDATE NO ACTION ON DELETE SET NULL;

-- changeset knoldus:1650267790858-68
ALTER TABLE "public"."guacamole_connection_history" ADD CONSTRAINT "guacamole_connection_history_ibfk_2" FOREIGN KEY ("connection_id") REFERENCES "public"."guacamole_connection" ("connection_id") ON UPDATE NO ACTION ON DELETE SET NULL;

-- changeset knoldus:1650267790858-69
ALTER TABLE "public"."guacamole_connection_history" ADD CONSTRAINT "guacamole_connection_history_ibfk_3" FOREIGN KEY ("sharing_profile_id") REFERENCES "public"."guacamole_sharing_profile" ("sharing_profile_id") ON UPDATE NO ACTION ON DELETE SET NULL;

-- changeset knoldus:1650267790858-70
ALTER TABLE "public"."guacamole_connection" ADD CONSTRAINT "guacamole_connection_ibfk_1" FOREIGN KEY ("parent_id") REFERENCES "public"."guacamole_connection_group" ("connection_group_id") ON UPDATE NO ACTION ON DELETE CASCADE;

-- changeset knoldus:1650267790858-71
ALTER TABLE "public"."guacamole_connection_parameter" ADD CONSTRAINT "guacamole_connection_parameter_ibfk_1" FOREIGN KEY ("connection_id") REFERENCES "public"."guacamole_connection" ("connection_id") ON UPDATE NO ACTION ON DELETE CASCADE;

-- changeset knoldus:1650267790858-72
ALTER TABLE "public"."guacamole_connection_permission" ADD CONSTRAINT "guacamole_connection_permission_entity" FOREIGN KEY ("entity_id") REFERENCES "public"."guacamole_entity" ("entity_id") ON UPDATE NO ACTION ON DELETE CASCADE;

-- changeset knoldus:1650267790858-73
ALTER TABLE "public"."guacamole_connection_permission" ADD CONSTRAINT "guacamole_connection_permission_ibfk_1" FOREIGN KEY ("connection_id") REFERENCES "public"."guacamole_connection" ("connection_id") ON UPDATE NO ACTION ON DELETE CASCADE;

-- changeset knoldus:1650267790858-74
ALTER TABLE "public"."guacamole_sharing_profile_attribute" ADD CONSTRAINT "guacamole_sharing_profile_attribute_ibfk_1" FOREIGN KEY ("sharing_profile_id") REFERENCES "public"."guacamole_sharing_profile" ("sharing_profile_id") ON UPDATE NO ACTION ON DELETE CASCADE;

-- changeset knoldus:1650267790858-75
ALTER TABLE "public"."guacamole_sharing_profile" ADD CONSTRAINT "guacamole_sharing_profile_ibfk_1" FOREIGN KEY ("primary_connection_id") REFERENCES "public"."guacamole_connection" ("connection_id") ON UPDATE NO ACTION ON DELETE CASCADE;

-- changeset knoldus:1650267790858-76
ALTER TABLE "public"."guacamole_sharing_profile_parameter" ADD CONSTRAINT "guacamole_sharing_profile_parameter_ibfk_1" FOREIGN KEY ("sharing_profile_id") REFERENCES "public"."guacamole_sharing_profile" ("sharing_profile_id") ON UPDATE NO ACTION ON DELETE CASCADE;

-- changeset knoldus:1650267790858-77
ALTER TABLE "public"."guacamole_sharing_profile_permission" ADD CONSTRAINT "guacamole_sharing_profile_permission_entity" FOREIGN KEY ("entity_id") REFERENCES "public"."guacamole_entity" ("entity_id") ON UPDATE NO ACTION ON DELETE CASCADE;

-- changeset knoldus:1650267790858-78
ALTER TABLE "public"."guacamole_sharing_profile_permission" ADD CONSTRAINT "guacamole_sharing_profile_permission_ibfk_1" FOREIGN KEY ("sharing_profile_id") REFERENCES "public"."guacamole_sharing_profile" ("sharing_profile_id") ON UPDATE NO ACTION ON DELETE CASCADE;

-- changeset knoldus:1650267790858-79
ALTER TABLE "public"."guacamole_system_permission" ADD CONSTRAINT "guacamole_system_permission_entity" FOREIGN KEY ("entity_id") REFERENCES "public"."guacamole_entity" ("entity_id") ON UPDATE NO ACTION ON DELETE CASCADE;

-- changeset knoldus:1650267790858-80
ALTER TABLE "public"."guacamole_user_attribute" ADD CONSTRAINT "guacamole_user_attribute_ibfk_1" FOREIGN KEY ("user_id") REFERENCES "public"."guacamole_user" ("user_id") ON UPDATE NO ACTION ON DELETE CASCADE;

-- changeset knoldus:1650267790858-81
ALTER TABLE "public"."guacamole_user" ADD CONSTRAINT "guacamole_user_entity" FOREIGN KEY ("entity_id") REFERENCES "public"."guacamole_entity" ("entity_id") ON UPDATE NO ACTION ON DELETE CASCADE;

-- changeset knoldus:1650267790858-82
ALTER TABLE "public"."guacamole_user_group_attribute" ADD CONSTRAINT "guacamole_user_group_attribute_ibfk_1" FOREIGN KEY ("user_group_id") REFERENCES "public"."guacamole_user_group" ("user_group_id") ON UPDATE NO ACTION ON DELETE CASCADE;

-- changeset knoldus:1650267790858-83
ALTER TABLE "public"."guacamole_user_group" ADD CONSTRAINT "guacamole_user_group_entity" FOREIGN KEY ("entity_id") REFERENCES "public"."guacamole_entity" ("entity_id") ON UPDATE NO ACTION ON DELETE CASCADE;

-- changeset knoldus:1650267790858-84
ALTER TABLE "public"."guacamole_user_group_member" ADD CONSTRAINT "guacamole_user_group_member_entity" FOREIGN KEY ("member_entity_id") REFERENCES "public"."guacamole_entity" ("entity_id") ON UPDATE NO ACTION ON DELETE CASCADE;

-- changeset knoldus:1650267790858-85
ALTER TABLE "public"."guacamole_user_group_member" ADD CONSTRAINT "guacamole_user_group_member_parent" FOREIGN KEY ("user_group_id") REFERENCES "public"."guacamole_user_group" ("user_group_id") ON UPDATE NO ACTION ON DELETE CASCADE;

-- changeset knoldus:1650267790858-86
ALTER TABLE "public"."guacamole_user_group_permission" ADD CONSTRAINT "guacamole_user_group_permission_affected_user_group" FOREIGN KEY ("affected_user_group_id") REFERENCES "public"."guacamole_user_group" ("user_group_id") ON UPDATE NO ACTION ON DELETE CASCADE;

-- changeset knoldus:1650267790858-87
ALTER TABLE "public"."guacamole_user_group_permission" ADD CONSTRAINT "guacamole_user_group_permission_entity" FOREIGN KEY ("entity_id") REFERENCES "public"."guacamole_entity" ("entity_id") ON UPDATE NO ACTION ON DELETE CASCADE;

-- changeset knoldus:1650267790858-88
ALTER TABLE "public"."guacamole_user_history" ADD CONSTRAINT "guacamole_user_history_ibfk_1" FOREIGN KEY ("user_id") REFERENCES "public"."guacamole_user" ("user_id") ON UPDATE NO ACTION ON DELETE SET NULL;

-- changeset knoldus:1650267790858-89
ALTER TABLE "public"."guacamole_user_password_history" ADD CONSTRAINT "guacamole_user_password_history_ibfk_1" FOREIGN KEY ("user_id") REFERENCES "public"."guacamole_user" ("user_id") ON UPDATE NO ACTION ON DELETE CASCADE;

-- changeset knoldus:1650267790858-90
ALTER TABLE "public"."guacamole_user_permission" ADD CONSTRAINT "guacamole_user_permission_entity" FOREIGN KEY ("entity_id") REFERENCES "public"."guacamole_entity" ("entity_id") ON UPDATE NO ACTION ON DELETE CASCADE;

-- changeset knoldus:1650267790858-91
ALTER TABLE "public"."guacamole_user_permission" ADD CONSTRAINT "guacamole_user_permission_ibfk_1" FOREIGN KEY ("affected_user_id") REFERENCES "public"."guacamole_user" ("user_id") ON UPDATE NO ACTION ON DELETE CASCADE;

-- changeset knoldus:1650267854185-92
INSERT INTO "public"."guacamole_entity" ("entity_id", "name", "type") VALUES (1, 'guacadmin', 'USER');

-- changeset knoldus:1650267854185-93
INSERT INTO "public"."guacamole_user" (entity_id, password_hash, password_salt, password_date)
SELECT
    entity_id,
    decode('CA458A7D494E3BE824F5E1E175A1556C0F8EEF2C2D7DF3633BEC4A29C4411960', 'hex'),  
    decode('FE24ADC5E11E2B25288D1704ABE67A79E342ECC26064CE69C5B3177795A82264', 'hex'),
    CURRENT_TIMESTAMP
FROM "public"."guacamole_entity" WHERE name = 'guacadmin' AND guacamole_entity.type = 'USER';


-- changeset knoldus:1650267854185-94
INSERT INTO "public"."guacamole_user_permission" ("entity_id", "affected_user_id", "permission") VALUES (1, 1, 'READ');
INSERT INTO "public"."guacamole_user_permission" ("entity_id", "affected_user_id", "permission") VALUES (1, 1, 'UPDATE');
INSERT INTO "public"."guacamole_user_permission" ("entity_id", "affected_user_id", "permission") VALUES (1, 1, 'ADMINISTER');

-- changeset knoldus:1650267854185-95
INSERT INTO "public"."guacamole_system_permission" ("entity_id", "permission") VALUES (1, 'CREATE_CONNECTION');
INSERT INTO "public"."guacamole_system_permission" ("entity_id", "permission") VALUES (1, 'CREATE_CONNECTION_GROUP');
INSERT INTO "public"."guacamole_system_permission" ("entity_id", "permission") VALUES (1, 'CREATE_SHARING_PROFILE');
INSERT INTO "public"."guacamole_system_permission" ("entity_id", "permission") VALUES (1, 'CREATE_USER');
INSERT INTO "public"."guacamole_system_permission" ("entity_id", "permission") VALUES (1, 'CREATE_USER_GROUP');
INSERT INTO "public"."guacamole_system_permission" ("entity_id", "permission") VALUES (1, 'ADMINISTER');
