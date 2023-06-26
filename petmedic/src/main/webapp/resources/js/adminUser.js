//========리스트


//검색목록 초기화(처음상태로)
function resetSearchUserList() {
	location.href = "getUserList";
}


//해당 눌렀을 때 회원 상세
function uDtail(val) {
	location.href = "getUserPage?users_id=" + val;
}



//=============겟유저

//목록으로 버튼 함수
function userList(){
	location.href = "getUserList";
}
