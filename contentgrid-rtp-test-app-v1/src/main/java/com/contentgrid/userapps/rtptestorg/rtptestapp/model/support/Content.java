package com.contentgrid.userapps.rtptestorg.rtptestapp.model.support;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.Embeddable;
import java.lang.Long;
import java.lang.String;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.content.commons.annotations.ContentId;
import org.springframework.content.commons.annotations.ContentLength;
import org.springframework.content.commons.annotations.MimeType;
import org.springframework.content.commons.annotations.OriginalFileName;

@Embeddable
@NoArgsConstructor
@Getter
@Setter
public class Content {
	@ContentId
	@JsonIgnore
	private String id;

	@ContentLength
	@JsonProperty(access = JsonProperty.Access.READ_ONLY)
	private Long length;

	@MimeType
	private String mimetype;

	@OriginalFileName
	private String filename;
}
