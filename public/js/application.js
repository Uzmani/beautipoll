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
        window.location.href = "/surveys/edit/" + response;
      }

      $(this).dialog("close");

      },
      Cancel: function() {
        $( this ).dialog("close");
      }
    },
    close: function() {}
  });

  $("#question-form").dialog({
    dialogClass: "no-close",
    autoOpen: false,
    height: 575,
    width: 750,
    modal: true,
    buttons: {
      "Add my question!": function() {

      var content = $("#question_content"),
      choice = $("input[name='choice']").map(function(){
        return $(this).val();
      }).get().join(".y.y.");

      var data = "content="+content.val()+"&choice="+choice;
      $.post('/surveys/new_q', data, function(response) {
        window.location.href = "/surveys/edit/" + response;
      });
      $(this).dialog("close");

      },
      Cancel: function() {
        $(this).dialog("close");
      }
    },
  });

  $("#edit-form").dialog({
    dialogClass: "no-close",
    autoOpen: false,
    height: 575,
    width: 750,
    modal: true,
    buttons: {
      "Save my edits": function() {

      var content = $("#question_content"),
      choice = $("input[name='choice']").map(function(){
        return $(this).val();
      }).get().join(".y.y.");

      var data = "question_num="+window.question_num+"&content="+content.val()+"&choice="+choice;
      $.post('/surveys/edit_q', data, function(response) {
        window.location.href = "/surveys/edit/" + response;
      });
      $(this).dialog("close");

      },
      Cancel: function() {
        $(this).dialog("close");
      }
    },
  });

  $("#delete-form").dialog({
    dialogClass: "no-close",
    autoOpen: false,
    height: 175,
    width: 750,
    modal: true,
    buttons: {
      "Yes, I'm sure!": function() {

      var data = "question_num="+window.question_num;
      $.post('/surveys/delete_q', data, function(response) {
        window.location.href = "/surveys/edit/" + response;
      });
      $(this).dialog("close");

      },
      "Ack, no. Get me out of here!": function() {
        $(this).dialog("close");
      }
    },
  });

  function bindEvents() {
    $('.question_type').change(function(){
      $('#default_select').replaceWith("<option id='default_select' value='default_select' disabled>Choose Format</option>")
      var val = $(this).val()
      if (val == "text"){
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
    if ($('.answer_fields').html() == ""){
      var $fieldType = $("<input type='hidden' class = 'format'><input type='text' name='choice' class='text_answer' placeholder='Answer'><br><input type='hidden' class = 'format'><input type='text' name='choice' class='text_answer' placeholder='Answer'><br>");
      $('.answer_fields').html($fieldType);
    } else {
        if ($('.answer_fields #sortable').length >= 1){
          $.each(textField(), function(index, input){
            var html = $('.answer_fields').html();
            $('.answer_fields').html(html+"<input type='hidden' class = 'format'><input type='text' name='choice' class='text_answer' placeholder='Answer' value='"+input+"'><br>");
          });
        }
        else {  
          $('.format').replaceWith("<input type='hidden' class='format'>")
        }
    }
  }

  function radioAnswer(){
    if ($('.answer_fields').html() == ""){
      var $fieldType = $("<input type='radio' class='format' value=''><input type='text' name='choice' class='text_answer' placeholder='Answer'><br><input type='radio' class='format' value=''><input type='text' name='choice' class='text_answer' placeholder='Answer'><br>");
      $('.answer_fields').html($fieldType);
    } else {
          if ($('.answer_fields #sortable').length >= 1){
          $.each(textField(), function(index, input){
            var html = $('.answer_fields').html();
            $('.answer_fields').html(html+"<input type='radio' class = 'format'><input type='text' name='choice' class='text_answer' placeholder='Answer' value='"+input+"'><br>");
          });
        }
        else {
          $('.format').replaceWith("<input type='radio' class='format'>");
        }
    }
  }

  function checkboxAnswer(){
    if ($('.answer_fields').html() == ""){
      var $fieldType = $("<input type='checkbox' class='format' value=''><input type='text' name='choice' class='text_answer' placeholder='Answer'><br><input type='checkbox' class='format' value=''><input type='text' name='choice' class='text_answer' placeholder='Answer'><br>");
    $('.answer_fields').html($fieldType);
  } else {
      if ($('.answer_fields #sortable').length >= 1){
          $.each(textField(), function(index, input){
            var html = $('.answer_fields').html();
            $('.answer_fields').html(html+"<input type='checkbox' class = 'format'><input type='text' name='choice' class='text_answer' placeholder='Answer' value='"+input+"'><br>");
          });
        }
        else {
          $('.format').replaceWith("<input type='checkbox' class='format'>");
        }
    }
  }

  //Strange hybrid of the creating survey and taking survey functionality
  //Needs to be separated. Sortable should only happen for taking.
  function rankingAnswer(){
    if ($('.answer_fields').html() == ""){ 
      var $sortAnswers = $("<ul id='sortable'><div class='ui-state-default'><span class='ui-icon ui-icon-arrowthick-2-n-s'></span><input type='text' class='text_answer' name='choice' placeholder='text'></div><div class='ui-state-default'><span class='ui-icon ui-icon-arrowthick-2-n-s'></span><input type='text' name='choice' class='text_answer' placeholder='text'></div></ul>");
      $('.answer_fields').html($sortAnswers);
      $sortAnswers.sortable();
    }
    else {
      var choice = $(".text_answer").map(function(){
        return $(this).val();
      }).get(); 
      $('.answer_fields').html("<ul id='sortable'>");
      $.each(choice, function(index, input){
        var html = $('.answer_fields').html();
        $('.answer_fields').html(html+"<div class='ui-state-default'><span class='ui-icon ui-icon-arrowthick-2-n-s'></span><input type='text' class='text_answer' name='choice' placeholder='text' value='"+input+"''></div>");
      })
      var html = $('.answer_fields').html();
      $('.answer_fields').html(html+"</ul>");
      var $sortAnswers = $('#sortable');
      $sortAnswers.sortable();
    }
  }

  function textField(){
    var choice = $(".text_answer").map(function(){
        return $(this).val();
      }).get(); 
    $('.answer_fields').html("");
    return choice;
  }

  function clearFields(){
    $('.answer_fields').html('');
  }

  bindEvents();

  $(document).on("click", "#add_choice", function() {
    var format = $('.question_type').val();
    switch (format) {
    case "text":
      $('.answer_fields').append("<input type='hidden' class = 'format'><input type='text' name='choice' class='text_answer' placeholder='Answer'><br>");
      break;
    case "radio_button":
      $('.answer_fields').append("<input type='radio' class='format' value=''><input type='text' name='choice' class='text_answer' placeholder='Answer'><br>");
      break;
    case "checkbox":
      $('.answer_fields').append("<input type='checkbox' class='format' value=''><input type='text' name='choice' class='text_answer' placeholder='Answer'><br>");
      break;
    case "ranking":
      $('.answer_fields').append("<div class='ui-state-default'><span class='ui-icon ui-icon-arrowthick-2-n-s'></span><input type='text' name='choice' placeholder='text'></div>");
      break;
    };
    return false;
  });

  $(document).on('click', '#create-survey', function(e) {
    e.preventDefault();
    $('#title-form').dialog('open');
  });

  $(document).on('click', '#new-question', function(e) {
    e.preventDefault();
    $('#question-form').dialog('open');
  });

  $(document).on("click", "#complete_survey", function() {
    $("#thanks").dialog('open');
  });

  $(document).on('click', '#edit_question', function(e) {
    e.preventDefault();
    window.question_num = $(this).data("id");
    $('#edit-form').dialog('open');
  });

  $(document).on('click', '#delete_question', function(e) {
    e.preventDefault();
    window.question_num = $(this).data("id");
    $('#delete-form').dialog('open');
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
