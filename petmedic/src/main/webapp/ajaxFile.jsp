<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ajax Test</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<style>
table {
	border-collapse: collapse;
	border: 1px solid #333;
	width: 60%;
}
th, td {
	border: 1px solid #333;
}

th {
	background-color: #aaa;
	color: #fff;
}
</style>
<script>
function getBoard(val) { //getBoard(2)
	
	var objParams = {seq: val}; //=> {seq : 2,  pw : "1234", ...} // js의 {} object 자료형은 자바의 hashmap 처럼 무조건 key value로 들어가야한다
	var values = []; //ArrayList 값을 받을 배열변수를 선언
	
	$.ajax ({
		type: "post", //form태그의 method속성과 동일
		url: "reqAjax2", //form태그의 action속성과 동일
		data: objParams, //form요소들의 name속성: name에 대입된 값을 묶어놓은 집합체
		cache : false, //브라우저 캐시를 막아서, 캐시 된 값이 아닌 현재 값을 호출해 올 수 있습니다. 무조건 false하자
		success: function(res) { //test.java의 reqAjax2의 retVal값
			if(res.code =="OK") { //controller에서 넘겨준 성공여부 코드
				values = res.boardList ; //java에서 정의한 ArrayList명을 적어준다.
				$.each(values, function (index, value) {
					console.log(index + " : " + value.title); //Book.java 의 멤버필드명을 써주면 된다.
					$("#status").append("<tr><td>"+value.seq+"</td><td>"+value.title+"</td><td>"+value.writer+"</td></tr>"); //selector인지 객체인지에 따라 바뀜 //append 뒤에추가(형제있으면 막내로, 아니면 자식으로)
				});
				$("#demo").hide();
				console.log("성공");
			}else {
				console.log("실패");
			}
		}, 
		error:function(request,status) {
			alert("오류가 발생합니다.");
		}
	
	});
}

</script>
</head>
<body>
	<h2>ajax Object 받기</h2>
    <table id="status">
        <tr><th>번호</th><th>제목</th><th>작성자</th></tr>
    </table>
    <br>
    <div id="demo">
        <button type="button" onclick="getBoard()">데이터 불러오기</button>
    </div><br><br>
</body>
</html>