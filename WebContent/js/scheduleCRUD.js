var ctx = sessionStorage.getItem("contextpath");

function fromServer() {
	if (httpRequest.readyState == 4) {
		if (httpRequest.status == 200) {
			document.getElementById("messageContent").innerHTML = httpRequest.responseText;
		}
	}
}
function contentView(data) {
	var id = "id=" + data;
	sendRequest(ctx + "/page/contentsView", id, fromServer, "POST");
}

function deleteSchedule(data) {
	var id = "id=" + data;
	sendRequest(ctx + "/page/deleteSchedule", id, fromServer, "POST");
}
function addSchedule(data) {
	sendRequest(ctx + "/page/addSchedule", data, fromServer, "POST");
}

function update(data) {
	sendRequest(ctx + "/page/updatePro", data, fromServer, "POST");
}
function updateInclueDuty(data) {
	sendRequest(ctx + "/page/updateProDuty", data, fromServer, "POST");
}
function toUpdatePage(data) {
	var data1 = "id=" + data;
	sendRequest(ctx + "/page/updateForm", data1, fromServer, "POST");
	event.preventDefault();
}