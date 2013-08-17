$(document).ready(function () {

  $('#add_answer').on('click', function(e){
    e.preventDefault();
    $("<input type='text' class='survey_answer' name='answer[]' placeholder='Enter a possible answer here' size='50'>").appendTo('#new_survey');
  });

  $('#add_question').on('click', function(e){
    e.preventDefault();
    $("<hr>").appendTo('#new_survey');
    $("<div class='new_question'>").appendTo('#new_survey');
    $("<input type='text' class='survey_question' name='question' placeholder='Enter a question here' size='50'>").appendTo('.new_question:last');
    $("<input type='text' class='survey_answer' name='answer[]' placeholder='Enter a possible answer here' size='50'>").appendTo('.new_question:last');
    $("<input type='text' class='survey_answer' name='answer[]' placeholder='Enter a possible answer here' size='50'>").appendTo('.new_question:last');
  });



  $('#create_survey').on('submit', function(e){
    e.preventDefault();
    var data = $(this).closest('form').serialize();
    $.post('/surveys/new', data, function(reply){
      console.log(reply);
      $('.container').append(reply);
    });
  });

  $('#create_question').on('submit', function(e){
    e.preventDefault();
    var data = $(this).closest('form').serialize();
    $.post('/questions/new', data, function(reply){
      $('.container').html(reply);
    })
  });

  $('#create_answers').on('submit', function(e){
    e.preventDefault();
    var data = $(this).closest('form').serialize();
    $.post('/answers/new', data, function(reply){
      $('.container').html(reply);
    })
  });


	setTimeout(function() {
		$('#myModal').reveal().trigger('click');
	},10);
  $('a#sign-out').on("click", function (e) {
    e.preventDefault();
    var request = $.ajax({ url: $(this).attr('href'), type: 'delete' });
    request.done(function () { window.location = "/"; });
  });

});

// - wrap form fields in div#form_fields (or other element)

// - click submit button
// $('form_fields').on('click', 'submit', function(e){

// })
// - grap text from input field $('input').text()
// - store this into a variable
// - create a radio button, set label to variable
// - append radio buttom to div