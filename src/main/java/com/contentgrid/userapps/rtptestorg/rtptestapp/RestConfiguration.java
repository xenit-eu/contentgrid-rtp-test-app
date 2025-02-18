package com.contentgrid.userapps.rtptestorg.rtptestapp;

import com.contentgrid.userapps.rtptestorg.rtptestapp.model.Invoice;
import com.contentgrid.userapps.rtptestorg.rtptestapp.model.Supplier;
import java.lang.Override;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.rest.core.config.RepositoryRestConfiguration;
import org.springframework.data.rest.webmvc.config.RepositoryRestConfigurer;
import org.springframework.web.servlet.config.annotation.CorsRegistry;

@Configuration
public class RestConfiguration implements RepositoryRestConfigurer {
	@Override
	public void configureRepositoryRestConfiguration(RepositoryRestConfiguration config,
			CorsRegistry cors) {
		config.exposeIdsFor(Supplier.class);
		config.exposeIdsFor(Invoice.class);
	}
}
