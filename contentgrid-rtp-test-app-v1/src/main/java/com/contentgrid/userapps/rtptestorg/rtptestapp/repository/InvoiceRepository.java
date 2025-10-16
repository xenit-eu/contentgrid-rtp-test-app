package com.contentgrid.userapps.rtptestorg.rtptestapp.repository;

import com.contentgrid.userapps.rtptestorg.rtptestapp.model.Invoice;
import java.util.UUID;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

@RepositoryRestResource(collectionResourceRel = "d:invoices", itemResourceRel = "d:invoice")
interface InvoiceRepository extends JpaRepository<Invoice, UUID>, QuerydslPredicateExecutor<Invoice> {
}
