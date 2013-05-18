$(document).ready(function(){
	$("#statsimg").html("<img src='images/chartcpu.png' />");	
	$("#cpu").click(function () {
		$("#statsimg").html("<img src='images/chartcpu.png' />");
	});
	$("#temp").click(function () {
		$("#statsimg").html("<img src='images/charttemp.png') />");
	});
});
