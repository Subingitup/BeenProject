function faqSubmit(){
   alert('자주묻는 질문을 등록하시겠습니까?');
   return true;
}

function goFaqModi(val){
   location.href="/updateFAQ?faq_int="+val;
}

function faqModi(){
   alert('글을 수정하시겠습니까?');
   return true;
}

function faqDel(val){
   if(confirm("해당 글을 삭제하시겠습니까? 삭제 후에는 복원할 수 없습니다.")){
      location.href="deleteFAQ?faq_int="+val;
   }
}