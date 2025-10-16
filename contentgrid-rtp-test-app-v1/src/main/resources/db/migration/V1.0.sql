-- BEGIN: enable-feature scribe/many-to-many-join-table-drop-additional-id-column
-- END: enable-feature scribe/many-to-many-join-table-drop-additional-id-column
-- BEGIN: enable-feature scribe/namespaced-content-property-columns
-- END: enable-feature scribe/namespaced-content-property-columns
-- BEGIN: enable-feature app/embedded-content-property
-- END: enable-feature app/embedded-content-property
-- BEGIN: enable-feature app/default-curied-link-relations
-- END: enable-feature app/default-curied-link-relations
-- BEGIN: enable-feature scribe/hash-long-database-index-names
-- END: enable-feature scribe/hash-long-database-index-names
-- BEGIN: enable-feature app/optimistic-locking
-- END: enable-feature app/optimistic-locking
-- BEGIN: enable-feature scribe/omit-noop-compatibility-views
-- END: enable-feature scribe/omit-noop-compatibility-views
-- BEGIN: enable-feature scribe/index-foreign-key-columns
-- END: enable-feature scribe/index-foreign-key-columns
-- BEGIN: enable-feature scribe/utf8-normalize-text-indexes
-- END: enable-feature scribe/utf8-normalize-text-indexes
-- BEGIN: enable-feature app/cursor-based-pagination
-- END: enable-feature app/cursor-based-pagination
-- BEGIN: enable-feature app/omit-legacy-page-metadata
-- END: enable-feature app/omit-legacy-page-metadata
CREATE TABLE "supplier" ("id" uuid NOT NULL, "_version" bigint NOT NULL DEFAULT 0, PRIMARY KEY ("id"));
ALTER TABLE "supplier" ADD COLUMN "name" text NULL;
ALTER TABLE "supplier" ALTER COLUMN "name" SET NOT NULL;
CREATE SCHEMA "extensions";
CREATE EXTENSION unaccent SCHEMA "extensions";
CREATE FUNCTION "extensions".contentgrid_prefix_search_normalize(arg text)
	RETURNS text
	LANGUAGE sql IMMUTABLE RETURNS NULL ON NULL INPUT PARALLEL SAFE
RETURN "extensions".unaccent('extensions.unaccent', lower(normalize(arg, NFKC)));
ALTER TABLE "supplier" ADD COLUMN "telephone" text NULL;
ALTER TABLE "supplier" ALTER COLUMN "telephone" SET NOT NULL;
ALTER TABLE "supplier" ADD COLUMN "bank_account" text NULL;
CREATE TABLE "invoice" ("id" uuid NOT NULL, "_version" bigint NOT NULL DEFAULT 0, PRIMARY KEY ("id"));
ALTER TABLE "invoice" ADD COLUMN "received" timestamptz NULL;
ALTER TABLE "invoice" ALTER COLUMN "received" SET NOT NULL;
-- BEGIN: Create of content property invoice.document
ALTER TABLE "invoice" ADD COLUMN "document__id" text NULL;
ALTER TABLE "invoice" ADD COLUMN "document__length" bigint NULL;
ALTER TABLE "invoice" ADD COLUMN "document__mimetype" text NULL;
ALTER TABLE "invoice" ADD COLUMN "document__filename" text NULL;
-- END: Create of content property invoice.document
ALTER TABLE "invoice" ADD COLUMN "pay_before" timestamptz NULL;
ALTER TABLE "invoice" ALTER COLUMN "pay_before" SET NOT NULL;
ALTER TABLE "invoice" ADD COLUMN "total_amount" decimal NULL;
ALTER TABLE "invoice" ALTER COLUMN "total_amount" SET NOT NULL;
ALTER TABLE "invoice" ADD COLUMN "supplier" uuid NULL REFERENCES "supplier"("id");
