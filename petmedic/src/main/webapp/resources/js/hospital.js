function register(){
	location.href="register.jsp"
}

$(document).ready(function(){ 
	$( window ).resize(function() {
		var windowWidth = $( window ).width();
		if(windowWidth >= 978) {
			$("#subNavMenu").hide();
		}
});

		
	$("#updatehospital").click(function(val){
		location.href = "/updatePageHospital?hos_id=" + val;
	});
	
   
	
	
	
	$("#delwaithospital").click(function(){
		
		let con_test = confirm("삭제상태로 만드시겠습니까?");
			
		if(con_test == true){
			let v = document.fm.hos_id.value;
			location.href = "deletewaitingHospital?hos_id="+v;
		}
		else if(con_test == false){
		  	return false;
		} 
			
	});
	
	$("#hospitalList").click(function(){   
		location.href = "getHospitalList";
	});
});

function movehospital(val){ 
	location.href = "getHospital?hos_id="+val;
}
