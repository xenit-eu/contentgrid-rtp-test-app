package com.contentgrid.userapps.rtptestorg.rtptestapp.model;

import com.contentgrid.spring.querydsl.annotation.CollectionFilterParam;
import com.contentgrid.spring.querydsl.annotation.CollectionFilterParams;
import com.contentgrid.spring.querydsl.predicate.Text;
import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Version;
import jakarta.validation.constraints.NotNull;
import java.lang.Long;
import java.lang.String;
import java.util.UUID;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@NoArgsConstructor
@Getter
@Setter
public class Supplier {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@JsonProperty(access = JsonProperty.Access.READ_ONLY)
	private UUID id;

	@NotNull
	@Column(nullable = false)
	@CollectionFilterParams({
			@CollectionFilterParam(predicate = Text.EqualsNormalized.class),
			@CollectionFilterParam(value = "name~prefix", predicate = Text.ContentGridPrefixSearch.class)
	})
	private String name;

	@NotNull
	@Column(nullable = false)
	private String telephone;

	@Column(unique = true)
	@JsonProperty("bank_account")
	@CollectionFilterParam(value = "bank_account~prefix", predicate = Text.ContentGridPrefixSearch.class)
	private String bankAccount;

	@Version
	private Long _version = 0L;
}
