$(document).ready(function () {

  $("#title-form").dialog({
    dialogClass: "no-close",
    autoOpen: false,
    height: 325,
    width: 750,
    modal: true,
    buttons: {
      "Create your Survey!": function() {

      var formElement = document.getElementById("title-input");
      var oReq = new XMLHttpRequest();
      oReq.open("post", "/surveys/new");
      oReq.send(new FormData(formElement));
      oReq.onload = function (oEvent) {
        var response = oReq.response;
        console.log(response);
        window.location.href = "/surveys/edit/" + response;
      }

      $(this).dialog("close");

      },
      Cancel: function() {
        $( this ).dialog("close");
        window.location.href="/";
      }
    },
    close: function() {}
  });

  $("#question-form").dialog({
    dialogClass: "no-close",
    autoOpen: true,
    height: 575,
    width: 750,
    modal: true,
    buttons: {
      "Add your question!": function() {

      var content = $("#question_content"),
      choice = $("input[name='choice']").map(function(){
        return $(this).val();
      }).get().join(".y.y.");

      var data = "content="+content.val()+"&choice="+choice;
      $.post('/surveys/new_q', data, function(response) {
        window.location.href = "/surveys/edit";
      });
      $(this).dialog("close");

      },
      Cancel: function() {
        $(this).dialog("close");
        $.get('/surveys/escape', function(response) {
          $('.container').html(response);
        });
      }
    },
    close: function() {}
  });

  $(document).on("click", "#add_choice", function() {
    $("#making_questions").append("<input type='text' name='choice' placeholder='Add an answer choice!'>");
    return false;
  });

  $(document).on('click', '#create-survey', function(e) {
    e.preventDefault();
    $('#title-form').dialog('open');
  });

  $(document).on("click", "#complete_survey", function() {
    $("#thanks").dialog('open');
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