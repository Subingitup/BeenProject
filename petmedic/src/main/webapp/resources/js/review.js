$(document).ready(function(){ 
	$( window ).resize(function() {
		var windowWidth = $( window ).width();
		if(windowWidth >= 978) {
			$("#subNavMenu").hide();
		}
	});
	
	$("#clMenu").click(function(){
		$("#subNavMenu").toggle();
	});
	
	$("#revWrite").click(function(){
		location.href = "getReserveForReview";
	});
	
	$("#revDel").click(function(){
		let rev_test = confirm("정말로 삭제하시겠습니까?");
		if(rev_test == true){
			let v = document.fm.rev_hos_seq.value;
			let f = document.fm.rev_pic.value;
			location.href = "deleteReview?rev_hos_seq="+v+"&rev_pic="+f;
		}
		else if(rev_test == false){
		  	return false;
		}
	});
	$("#revRepDel").click(function(){
		let rev_test = confirm("정말로 삭제하시겠습니까?");
		if(rev_test == true){
			let v = document.fm.rev_hos_seq.value;
			let f = document.fm.rev_pic.value;
			location.href = "updateDelReview?rev_hos_seq="+v;
		}
		else if(rev_test == false){
		  	return false;
		}
	});
	
		
	$("#getMyReviewPostList").click(function(){
		location.href = "getMyReviewPostList";
	});
	
	$("#revIns").click(function(){
		location.href = "getReserveForReview";
	});
	
});


function revDetail(val){
	location.href = "getReview?rev_hos_seq="+val;
}


function revMyDetail(val){
	location.href = "getMyReview?rev_hos_seq="+val;
}

function getReviewList(){
	location.href = "getReviewList";
}
function getAdminRevList(){
	location.href = "getAdminRevList";
}
function getMyReviewPostList(){
	location.href = "getMyReviewPostList";
}






