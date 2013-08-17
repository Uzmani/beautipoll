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

  $( "#dialog-form" ).dialog({
    autoOpen: false,
    height: 300,
    width: 350,
    modal: true,
    buttons: {
      "Create an account": function() {
        var bValid = true;
        allFields.removeClass( "ui-state-error" );

        bValid = bValid && checkLength( name, "username", 3, 16 );
        bValid = bValid && checkLength( email, "email", 6, 80 );
        bValid = bValid && checkLength( password, "password", 5, 16 );

        bValid = bValid && checkRegexp( name, /^[a-z]([0-9a-z_])+$/i, "Username may consist of a-z, 0-9, underscores, begin with a letter." );
        // From jquery.validate.js (by joern), contributed by Scott Gonzalez: http://projects.scottsplayground.com/email_address_validation/
        bValid = bValid && checkRegexp( email, /^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i, "eg. ui@jquery.com" );
        bValid = bValid && checkRegexp( password, /^([0-9a-zA-Z])+$/, "Password field only allow : a-z 0-9" );

        if ( bValid ) {
          $( "#users tbody" ).append( "<tr>" +
            "<td>" + name.val() + "</td>" +
            "<td>" + email.val() + "</td>" +
            "<td>" + password.val() + "</td>" +
          "</tr>" );
          $( this ).dialog( "close" );
        }
      },
      Cancel: function() {
        $( this ).dialog( "close" );
      }
    },
    close: function() {
      allFields.val( "" ).removeClass( "ui-state-error" );
    }
  });

  $( "#create-user" )
    .button()
    .click(function() {
      $( "#dialog-form" ).dialog( "open" );
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