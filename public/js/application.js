$(document).ready(function () {

  $('#add_answer').on('click', function(e){
    e.preventDefault();
    $("<input type='text' class='survey_answer' name='answer[]' placeholder='Enter a possible answer here' size='50'>").appendTo('#new_survey');
  });

  $('#add_question').on('click', function(e){
    e.preventDefault();
    $("<hr>").appendTo('#new_survey');
    $("<input type='text' class='survey_question' name='question' placeholder='Enter a question here' size='50'>").appendTo('#new_survey');
    $("<input type='text' class='survey_answer' name='answer[]' placeholder='Enter a possible answer here' size='50'>").appendTo('#new_survey');
    $("<input type='text' class='survey_answer' name='answer[]' placeholder='Enter a possible answer here' size='50'>").appendTo('#new_survey');
  });

  $('#create_survey').on('submit', function(e){
    e.preventDefault();
    var data = $(this).closest('form').serialize();
    $.post('/surveys', data, function(response){
      $('.container').html(response);
    })
  });

  //<form name
  // answer.each do |answer|
  //    <input type="radio" value="<%=answer=%>"> <%= @answer %> <br>


	setTimeout(function() {
		$('#myModal').reveal().trigger('click');
	},10);
  $('a#sign-out').on("click", function (e) {
    e.preventDefault();
    var request = $.ajax({ url: $(this).attr('href'), type: 'delete' });
    request.done(function () { window.location = "/"; });
  });

});