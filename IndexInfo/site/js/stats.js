$(document).ready(function(){
	$("#statsimg").html("<img src='images/chartcpu.png' />");	
	$("#cpu").click(function (event) {
		$("#statsimg").html("<img src='images/chartcpu.png' />");
		event.preventDefault();
		return false;
	});
	$("#temp").click(function (event) {
		$("#statsimg").html("<img src='images/charttemp.png') />");
		event.preventDefault();
		return false;
	});
});
