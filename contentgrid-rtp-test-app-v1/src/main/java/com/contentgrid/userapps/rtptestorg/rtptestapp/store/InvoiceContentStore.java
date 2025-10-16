package com.contentgrid.userapps.rtptestorg.rtptestapp.store;

import com.contentgrid.userapps.rtptestorg.rtptestapp.model.Invoice;
import java.lang.String;
import org.springframework.content.commons.store.ContentStore;
import org.springframework.content.rest.StoreRestResource;

@StoreRestResource
interface InvoiceContentStore extends ContentStore<Invoice, String> {
}
