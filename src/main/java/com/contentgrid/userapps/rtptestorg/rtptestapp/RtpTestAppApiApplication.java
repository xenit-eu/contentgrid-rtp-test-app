package com.contentgrid.userapps.rtptestorg.rtptestapp;

import com.contentgrid.spring.data.rest.hal.CurieProviderCustomizer;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
public class RtpTestAppApiApplication {

	public static void main(String[] args) {
		SpringApplication.run(RtpTestAppApiApplication.class, args);
	}

	@Bean
	CurieProviderCustomizer datamodelCurieProviderCustomizer() {
		return CurieProviderCustomizer.register("d", "https://contentgrid.cloud/rels/datamodel/{rel}");
	}

}
