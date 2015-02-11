function jumpPage(pageNo) {
	$("#pageNo").val(pageNo);
	$("#mainForm").submit();
}

function sort(orderBy, defaultOrder) {
	
	if ($("#selPageOrderBy").val() == orderBy) {
		if ($("#selPageOrder").val() == "") {
			$("#selPageOrder").val(defaultOrder);
		}
		else if ($("#selPageOrder").val() == "desc") {
			$("#selPageOrder").val("asc");
		}
		else if ($("#selPageOrder").val() == "asc") {
			$("#selPageOrder").val("desc");
		}
	}
	else {
		$("#selPageOrderBy").val(orderBy);
		$("#selPageOrder").val(defaultOrder);
	}
	$("#formPage").submit();
}

function search() {
	$("#order").val("");
	$("#orderBy").val("");
	$("#pageNo").val("1");

	$("#mainForm").submit();
}