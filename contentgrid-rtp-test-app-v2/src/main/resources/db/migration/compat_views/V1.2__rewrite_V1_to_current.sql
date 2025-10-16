CREATE SCHEMA "V1";
CREATE VIEW "V1"."supplier" AS 
	SELECT "id", "_version", "name", "telephone", "bank_account" FROM "supplier";
CREATE VIEW "V1"."invoice" AS 
	SELECT "id", "_version", "received", "document__id", "document__length", "document__mimetype", "document__filename", "pay_before", "total_amount", "supplier" FROM "invoice";
