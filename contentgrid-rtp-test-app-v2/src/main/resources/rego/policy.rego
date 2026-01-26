# Note: ${system.policy.package} is automatically replaced with the package name.
# Replace it when deploying this file to OPA directly.
package ${system.policy.package}

import rego.v1

util.extract_content_type(header) := content_type if {
	mime_type := trim_space(split(header, ";")[0])
	content_type := lower(mime_type)
}
default util.content_type_in(headers, accepted_content_types) := false

util.content_type_in(headers, accepted_content_types) if {
	count(headers) == 1
	extracted_mime_type := util.extract_content_type(headers[0])
	extracted_mime_type == accepted_content_types[_]
}
default util.request.content_type_in(content_types) := false

util.request.content_type_in(content_types) if {
	util.content_type_in(input.request.headers["content-type"], content_types)
}
default can_read_invoice := false

default can_create_invoice := false

default can_update_invoice := false

default can_delete_invoice := false

default can_read_supplier := false

default can_create_supplier := false

default can_update_supplier := false

default can_delete_supplier := false

# Policy 6z4vihwwdvdq
# - input.entity is type 'invoice'
can_read_invoice if {
	input.auth.authenticated == true
	input.auth.principal.kind == "user"
	input.auth.principal["contentgrid:manage_invoices"] == true
}
can_create_invoice if {
	input.auth.authenticated == true
	input.auth.principal.kind == "user"
	input.auth.principal["contentgrid:manage_invoices"] == true
}
can_update_invoice if {
	input.auth.authenticated == true
	input.auth.principal.kind == "user"
	input.auth.principal["contentgrid:manage_invoices"] == true
}
can_delete_invoice if {
	input.auth.authenticated == true
	input.auth.principal.kind == "user"
	input.auth.principal["contentgrid:manage_invoices"] == true
}
# End policy 6z4vihwwdvdq
# Policy zsn6mlr6y4tq
# - input.entity is type 'supplier'
can_read_supplier if {
	input.auth.authenticated == true
	input.auth.principal.kind == "user"
	input.auth.principal["contentgrid:admin"] == true
}
can_create_supplier if {
	input.auth.authenticated == true
	input.auth.principal.kind == "user"
	input.auth.principal["contentgrid:admin"] == true
}
can_update_supplier if {
	input.auth.authenticated == true
	input.auth.principal.kind == "user"
	input.auth.principal["contentgrid:admin"] == true
}
can_delete_supplier if {
	input.auth.authenticated == true
	input.auth.principal.kind == "user"
	input.auth.principal["contentgrid:admin"] == true
}
# End policy zsn6mlr6y4tq
default allow := false

# Static definition Application Root
allow if {
	input.request.method == ["HEAD", "GET"][_]
	# Path /
	count(input.request.path) == 0
}
# Static definition HAL Explorer (old)
allow if {
	input.request.method == ["HEAD", "GET"][_]
	# Path /explorer/*
	count(input.request.path) >= 1
	input.request.path[0] == "explorer"
}
# Static definition HAL Explorer
allow if {
	input.request.method == ["HEAD", "GET"][_]
	# Path /webjars/hal-explorer/*
	count(input.request.path) >= 2
	input.request.path[0] == "webjars"
	input.request.path[1] == "hal-explorer"
}
# Static definition Swagger UI
allow if {
	input.request.method == ["HEAD", "GET"][_]
	# Path /webjars/swagger-ui/*
	count(input.request.path) >= 2
	input.request.path[0] == "webjars"
	input.request.path[1] == "swagger-ui"
}
# Static definition OpenAPI Spec
allow if {
	input.request.method == ["HEAD", "GET"][_]
	# Path /openapi.yml
	count(input.request.path) == 1
	input.request.path[0] == "openapi.yml"
}
# Static definition Dynamic HAL profiles
allow if {
	input.request.method == ["HEAD", "GET"][_]
	# Path /profile/*
	count(input.request.path) >= 1
	input.request.path[0] == "profile"
}
# Static definition Automations
allow if {
	input.request.method == ["HEAD", "GET"][_]
	# Path /.contentgrid/automations
	count(input.request.path) == 2
	input.request.path[0] == ".contentgrid"
	input.request.path[1] == "automations"
	input.auth.kind == "system"
	input.auth.principal.kind == "extension"
	input.entity.system == input.auth.principal.sub
}
allow if {
	input.request.method == ["HEAD", "GET"][_]
	# Path /.contentgrid/automations/{id}
	count(input.request.path) == 3
	input.request.path[0] == ".contentgrid"
	input.request.path[1] == "automations"
	# variable component {id}
	input.auth.kind == "system"
	input.auth.principal.kind == "extension"
	input.entity.system == input.auth.principal.sub
}
allow if {
	input.request.method == ["HEAD", "GET"][_]
	# Path /invoices
	count(input.request.path) == 1
	input.request.path[0] == "invoices"
	can_read_invoice == true
}
allow if {
	input.request.method == "POST"
	# Path /invoices
	count(input.request.path) == 1
	input.request.path[0] == "invoices"
	util.request.content_type_in(["application/json", "application/hal+json", "application/merge-patch+json", "multipart/form-data"])
	can_create_invoice == true
}
allow if {
	input.request.method == ["HEAD", "GET"][_]
	# Path /invoices/{id}
	count(input.request.path) == 2
	input.request.path[0] == "invoices"
	# variable component {id}
	can_read_invoice == true
}
allow if {
	input.request.method == "PUT"
	# Path /invoices/{id}
	count(input.request.path) == 2
	input.request.path[0] == "invoices"
	# variable component {id}
	util.request.content_type_in(["application/json", "application/hal+json", "application/merge-patch+json", "multipart/form-data"])
	can_update_invoice == true
}
allow if {
	input.request.method == "PATCH"
	# Path /invoices/{id}
	count(input.request.path) == 2
	input.request.path[0] == "invoices"
	# variable component {id}
	util.request.content_type_in(["application/json", "application/hal+json", "application/merge-patch+json", "multipart/form-data"])
	can_update_invoice == true
}
allow if {
	input.request.method == "DELETE"
	# Path /invoices/{id}
	count(input.request.path) == 2
	input.request.path[0] == "invoices"
	# variable component {id}
	can_delete_invoice == true
}
allow if {
	input.request.method == ["HEAD", "GET"][_]
	# Path /invoices/{id}/supplier
	count(input.request.path) == 3
	input.request.path[0] == "invoices"
	# variable component {id}
	input.request.path[2] == "supplier"
	can_read_invoice == true
}
allow if {
	input.request.method == "PUT"
	# Path /invoices/{id}/supplier
	count(input.request.path) == 3
	input.request.path[0] == "invoices"
	# variable component {id}
	input.request.path[2] == "supplier"
	util.request.content_type_in(["text/uri-list"])
	can_update_invoice == true
}
allow if {
	input.request.method == "DELETE"
	# Path /invoices/{id}/supplier
	count(input.request.path) == 3
	input.request.path[0] == "invoices"
	# variable component {id}
	input.request.path[2] == "supplier"
	can_update_invoice == true
}
allow if {
	input.request.method == ["HEAD", "GET"][_]
	# Path /invoices/{id}/document
	count(input.request.path) == 3
	input.request.path[0] == "invoices"
	# variable component {id}
	input.request.path[2] == "document"
	can_read_invoice == true
}
allow if {
	input.request.method == ["POST", "PUT", "DELETE"][_]
	# Path /invoices/{id}/document
	count(input.request.path) == 3
	input.request.path[0] == "invoices"
	# variable component {id}
	input.request.path[2] == "document"
	can_update_invoice == true
}
allow if {
	input.request.method == ["HEAD", "GET"][_]
	# Path /suppliers
	count(input.request.path) == 1
	input.request.path[0] == "suppliers"
	can_read_supplier == true
}
allow if {
	input.request.method == "POST"
	# Path /suppliers
	count(input.request.path) == 1
	input.request.path[0] == "suppliers"
	util.request.content_type_in(["application/json", "application/hal+json", "application/merge-patch+json", "multipart/form-data"])
	can_create_supplier == true
}
allow if {
	input.request.method == ["HEAD", "GET"][_]
	# Path /suppliers/{id}
	count(input.request.path) == 2
	input.request.path[0] == "suppliers"
	# variable component {id}
	can_read_supplier == true
}
allow if {
	input.request.method == "PUT"
	# Path /suppliers/{id}
	count(input.request.path) == 2
	input.request.path[0] == "suppliers"
	# variable component {id}
	util.request.content_type_in(["application/json", "application/hal+json", "application/merge-patch+json", "multipart/form-data"])
	can_update_supplier == true
}
allow if {
	input.request.method == "PATCH"
	# Path /suppliers/{id}
	count(input.request.path) == 2
	input.request.path[0] == "suppliers"
	# variable component {id}
	util.request.content_type_in(["application/json", "application/hal+json", "application/merge-patch+json", "multipart/form-data"])
	can_update_supplier == true
}
allow if {
	input.request.method == "DELETE"
	# Path /suppliers/{id}
	count(input.request.path) == 2
	input.request.path[0] == "suppliers"
	# variable component {id}
	can_delete_supplier == true
}
