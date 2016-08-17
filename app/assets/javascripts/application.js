// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require endless_page
//= require jquery-1.11.1.min
//= require jquery.backstretch.min
//= require jquery.timeago
//= require scripts
//= require bootstrap.min
//= require notify

function valid_user(msg, tipe){
  $("#invitation_username").keyup(function() {
    if (this.value.length == 0){ $(".show_existed_username_message").html("") };
    if (this.value.length > 1){
      $.ajax({
        url: '/invitations/valid_user',
        data: {username: this.value},
        beforeSend: function(req){
          $(".show_existed_username_message").html("")
        },
        success: function(req)
        {
          if (req.status == "existed"){
            $(".show_existed_username_message").removeClass("green").addClass("red").html(req.message)
            $("#btnMine").removeClass("btn-reserve").addClass("btn-reserve-disable").html(req.message)
            document.getElementById("btnMine").disabled = true;
          }else{
            $(".show_existed_username_message").removeClass("red").addClass("green").html(req.message)
            $("#btnMine").removeClass("btn-reserve-disable").addClass("btn-reserve").html(req.message)
            document.getElementById("btnMine").disabled = false;
          }
        }
      });
    }else{
      $("#btnMine").removeClass("btn-reserve-disable").addClass("btn-reserve")
      document.getElementById("btnMine").disabled = false;
    }
  });

	notif(msg, tipe)

	$.ajax({
    url: "/invitations/invited_username",
    data_type: "script",
    type: "GET"
  }).done(function(user_names) {
    var i = 0;
    setTimeout(function(){
      $.notify("Someone has recently reserved: " + user_names[0], "info" );
      i += 1;
      rand = Math.round(Math.random() * (30000 - 10000)) + 10000;
      setInterval(function() {
        var user_name = user_names[i++];
        $.notify("Someone has recently reserved: " + user_name, "info" );
        if(i >= user_names.length) i = 0;
      }, rand);
    });
  });
}

function notif(msg, tipe){
	tipe = tipe == undefined ? "success" : tipe;
  $.notify(msg.replace("&#39;", "'"), tipe );
}