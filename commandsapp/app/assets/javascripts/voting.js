$(document).ready(function() {
  $("fa-caret-up").click(function(){ upvote(); });
}

function setUpdatedAt(){
  var $target = $('.updated-at');
  var id = $target.attr('data-record-id');
  $ajax(
    url : '/records/'+id+'/updated_at',
    dataType : 'json',
    type : 'GET',
    success: function(data){
      $target.html(data['response']);
    }

  );

}