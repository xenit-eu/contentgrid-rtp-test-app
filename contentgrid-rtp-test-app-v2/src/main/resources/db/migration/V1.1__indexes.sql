CREATE INDEX CONCURRENTLY "supplier__name_idx" ON "supplier"(normalize("name", NFKC));
CREATE INDEX CONCURRENTLY "supplier__name_cgsearch" ON "supplier"("extensions".contentgrid_prefix_search_normalize("name") text_pattern_ops);
CREATE UNIQUE INDEX CONCURRENTLY "supplier__bank_account_idx" ON "supplier"(normalize("bank_account", NFKC));
CREATE INDEX CONCURRENTLY "supplier__bank_account_cgsearch" ON "supplier"("extensions".contentgrid_prefix_search_normalize("bank_account") text_pattern_ops);
CREATE INDEX CONCURRENTLY "invoice__pay_before_idx" ON "invoice"("pay_before");
CREATE INDEX CONCURRENTLY "invoice__total_amount_idx" ON "invoice"("total_amount");
CREATE INDEX CONCURRENTLY "invoice__supplier_idx" ON "invoice"("supplier");
