package com.contentgrid.userapps.rtptestorg.rtptestapp.repository;

import com.contentgrid.userapps.rtptestorg.rtptestapp.model.Supplier;
import java.util.UUID;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

@RepositoryRestResource(collectionResourceRel = "d:suppliers", itemResourceRel = "d:supplier")
interface SupplierRepository extends JpaRepository<Supplier, UUID>, QuerydslPredicateExecutor<Supplier> {
}
