package com.contentgrid.userapps.rtptestorg.rtptestapp;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest(properties = "contentgrid.appserver.content-store.type=ephemeral")
class RtpTestAppApiApplicationTests {

	@Test
	void contextLoads() {
	}

}
