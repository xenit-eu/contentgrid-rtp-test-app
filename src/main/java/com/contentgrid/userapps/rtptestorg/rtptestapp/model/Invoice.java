package com.contentgrid.userapps.rtptestorg.rtptestapp.model;

import com.contentgrid.spring.querydsl.annotation.CollectionFilterParam;
import com.contentgrid.spring.querydsl.annotation.CollectionFilterParams;
import com.contentgrid.spring.querydsl.predicate.Ordered;
import com.contentgrid.userapps.rtptestorg.rtptestapp.model.support.Content;
import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.AttributeOverride;
import jakarta.persistence.Column;
import jakarta.persistence.Embedded;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Version;
import jakarta.validation.constraints.NotNull;
import java.lang.Long;
import java.math.BigDecimal;
import java.time.Instant;
import java.util.UUID;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.content.rest.RestResource;

@Entity
@NoArgsConstructor
@Getter
@Setter
public class Invoice {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@JsonProperty(access = JsonProperty.Access.READ_ONLY)
	private UUID id;

	@NotNull
	@Column(nullable = false)
	private Instant received;

	@Embedded
	@AttributeOverride(name = "id", column = @Column(name = "document__id"))
	@AttributeOverride(name = "length", column = @Column(name = "document__length"))
	@AttributeOverride(name = "mimetype", column = @Column(name = "document__mimetype"))
	@AttributeOverride(name = "filename", column = @Column(name = "document__filename"))
	@RestResource(linkRel = "d:document", path = "document")
	private Content document;

	@NotNull
	@Column(nullable = false)
	@JsonProperty("pay_before")
	@CollectionFilterParams({
			@CollectionFilterParam("pay_before"),
			@CollectionFilterParam(value = "pay_before~before", predicate = Ordered.LessThan.class),
			@CollectionFilterParam(value = "pay_before~after", predicate = Ordered.GreaterThan.class)
	})
	private Instant payBefore;

	@NotNull
	@Column(nullable = false)
	@JsonProperty("total_amount")
	@CollectionFilterParams({
			@CollectionFilterParam("total_amount"),
			@CollectionFilterParam(value = "total_amount~lt", predicate = Ordered.LessThan.class),
			@CollectionFilterParam(value = "total_amount~lte", predicate = Ordered.LessThanOrEqual.class),
			@CollectionFilterParam(value = "total_amount~gt", predicate = Ordered.GreaterThan.class),
			@CollectionFilterParam(value = "total_amount~gte", predicate = Ordered.GreaterThanOrEqual.class)
	})
	private BigDecimal totalAmount;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "supplier")
	@CollectionFilterParam
	@org.springframework.data.rest.core.annotation.RestResource(rel = "d:supplier")
	private Supplier supplier;

	@Version
	private Long _version = 0L;
}
