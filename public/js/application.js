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
        $('.container').html(response);
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
        $('.container').html(response);
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
    // close: function() {}
  });

  function bindEvents() {
    $('.question_type').change(function(){
      var val = $(this).val()
      if (val == "text"){
        console.log("WHOA")
        textAnswer();
      }
      else if (val == "radio_button"){
        radioAnswer();
      }
      else if (val == "checkbox"){
        checkboxAnswer();
      }
      else if (val == "ranking"){
        rankingAnswer();
      }
      else {
       clearFields();
      }
    });
  }

  function textAnswer(){
    console.log("Text")
    var $fieldType = $("<input type='text' name='choice' class='text_answer' placeholder='Answer'><br><input type='text' name='choice' class='text_answer' placeholder='Answer'>")
    $('.answer_fields').html($fieldType);
    $('.answer_fields').addClass('text');
  }

  function radioAnswer(){
    console.log("Radio")
    var $fieldType = $("<input type='radio' name='choice' class='radio_answer' value=''><input type='text' class='text_answer' placeholder='Answer'><br><input type='radio' name='choice' class='radio_answer' value=''><input type='text' class='text_answer' placeholder='Answer'>")
    $('.answer_fields').html($fieldType);
    $('.answer_fields').addClass('radio');
  }

  function checkboxAnswer(){
    console.log("Checkbox")
    var $fieldType = $("<input type='checkbox' name='choice' class='checkbox_answer' value=''><input type='text' class='text_answer' placeholder='Answer'><br><input type='checkbox' name='choice' class='checkbox_answer' value=''><input type='text' class='text_answer' placeholder='Answer'>")
    $('.answer_fields').html($fieldType);
    $('.answer_fields').addClass('checkbox');
  }

  //Strange hybrid of the creating survey and taking survey functionality
  //Needs to be separated. Sortable should only happen for taking.
  function rankingAnswer(){
    console.log("Ranking");
    var $sortAnswers = $("<ul id='sortable'><li class='ui-state-default'><span class='ui-icon ui-icon-arrowthick-2-n-s'></span><input type='text' name='choice' placeholder='text'></li><li class='ui-state-default'><span class='ui-icon ui-icon-arrowthick-2-n-s'></span><input type='text' name='choice' placeholder='text'></li><li class='ui-state-default'><span class='ui-icon ui-icon-arrowthick-2-n-s'></span><input type='text' name='choice' placeholder='text'></li><li class='ui-state-default'><span class='ui-icon ui-icon-arrowthick-2-n-s'></span><input type='text' name='choice' placeholder='text'></li><li class='ui-state-default'><span class='ui-icon ui-icon-arrowthick-2-n-s'></span><input type='text' name='choice' placeholder='text'></li><li class='ui-state-default'><span class='ui-icon ui-icon-arrowthick-2-n-s'></span><input type='text' name='choice' placeholder='text'></li><li class='ui-state-default'><span class='ui-icon ui-icon-arrowthick-2-n-s'></span><input type='text' name='choice' placeholder='text'></li></ul>")
    $sortAnswers.sortable();
    $('.answer_fields').html($sortAnswers);
    $('.answer_fields').addClass('ranking');
  }

  function clearFields(){
    console.log("Clear");
    $('.answer_fields').html('');
    $('.answer_fields').removeClass();
  }

  bindEvents();

  $(document).on("click", "#add_choice", function() {
    var format = $('.question_type').val();
    switch (format) {  //CLOSE SWITCH STATEMENT
    case "radio_button":
      $('#making_questions').append("<input type='radio' name='choice' class='radio_answer' value=''><input type='text' class='text_answer' placeholder='Answer'><br>")
    };
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

 //  $(document).on("click", "#add_choice", function() {
 //    $("#making_questions").append("<input type='text' name='choice' placeholder='Add an answer choice!'>");
 //    return false;
 //  });

 //  $(document).on("click", "#complete_survey", function() {
 //    $("#thanks").dialog();
 //  });

	// setTimeout(function() {
	// 	$('#myModal').reveal().trigger('click');
	// },10);
 //  $('a#sign-out').on("click", function (e) {
 //    e.preventDefault();
 //    var request = $.ajax({ url: $(this).attr('href'), type: 'delete' });
 //    request.done(function () { window.location = "/"; });
 //  });

});

// - wrap form fields in div#form_fields (or other element)

// - click submit button
// $('form_fields').on('click', 'submit', function(e){

// })
// - grap text from input field $('input').text()
// - store this into a variable
// - create a radio button, set label to variable
// - append radio buttom to div