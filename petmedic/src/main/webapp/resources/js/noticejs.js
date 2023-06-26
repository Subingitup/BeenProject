function noticeSubmit() {
   if(confirm("글을 등록하시겠습니까?")){
      return true;
   }
}

function goNoticeDel(val1, val2){
   if(confirm("해당 글을 삭제하시겠습니까? 삭제 후에는 복원할 수 없습니다.")){
      notDel(val1, val2);
   }
}

function notDel(val1, val2){
   location.href="/deleteNotice?notice_int="+val1+"&notice_realfile="+val2;
}

function resetFile() {
  $('#noticecustomFile').remove();
  $('#notice_file').remove();

  const newInput = $('<input type="file" class="custom-file-input" id="notice_file" name="notice_file" aria-describedby="inputGroupFileAddon01">');
  $('.custom-file').prepend(newInput);

  $('.custom-file-label').html('업로드할 이미지를 선택하세요');
}