// jQuery.ajax
$(function() {
    "use strict";
    var gameWatcher;
    var sa = '//localhost:3000';
    //var sa = "https://young-citadel-2431.herokuapp.com";
    //var sa = "http://ttt.wdibos.com";

    $("#register").on("click", function(e) {
        $.ajax(sa + "/users", {
            contentType: "application/json",
            data: JSON.stringify({
                credentials: {
                    email: $("#email").val(),
                    password: $("#password").val(),
                    password_confirmation: $("#password").val()
                }
            }),
            dataType: "json",
            method: "POST",
            processData: false
        })
        .done(function(data, textStatus, jqXHR) {
            $("#result").val(JSON.stringify(data));
        })
        .fail(function(jqXHR, textStatus, errorThrown) {
            $("#result").val("registration failed");
        })
        .always();
    });

    $("#login").on("click", function(e) {
        $.ajax(sa + "/login", {
            contentType: "application/json",
            data: JSON.stringify({
                credentials: {
                    email: $("#email").val(),
                    password: $("#password").val(),
                    password_confirmation: $("#password").val()
                }
            }),
            dataType: "json",
            method: "POST",
            processData: false
        })
        .done(function(data, textStatus, jqXHR) {
            $("#token").val(data.token);
        })
        .fail(function(jqXHR, textStatus, errorThrown) {
            $("#result").val("login failed");
        })
        .always();
    });

    $("#list").on("click", function(e) {
        $.ajax(sa + "/users", {
            dataType: "json",
            method: "GET",
            headers: {
              Authorization: 'Token token=' + $('#token').val()
            }
        })
        .done(function(data, textStatus, jqXHR) {
            $("#result").val(JSON.stringify(data));
        })
        .fail(function(jqXHR, textStatus, errorThrown) {
            $("#result").val("login failed");
        })
        .always();
    });

    $("#create").on("click", function(e) {
        $.ajax(sa + "/games", {
            contentType: "application/json",
            processData: false,
            data: JSON.stringify({}),
            dataType: "json",
            method: "POST",
            headers: {
              Authorization: 'Token token=' + $('#token').val()
            }
        })
        .done(function(data, textStatus, jqXHR) {
            $("#result").val(JSON.stringify(data));
        })
        .fail(function(jqXHR, textStatus, errorThrown) {
            $("#result").val("create failed");
        })
        .always();
    });

    $("#show").on("click", function(e) {
        $.ajax(sa + "/games/" + $('#id').val(), {
            dataType: "json",
            method: "GET",
            headers: {
              Authorization: 'Token token=' + $('#token').val()
            }
        })
        .done(function(data, textStatus, jqXHR) {
            $("#result").val(JSON.stringify(data));
        })
        .fail(function(jqXHR, textStatus, errorThrown) {
            $("#result").val("show failed");
        })
        .always();
    });

    $("#join").on("click", function(e) {
      $.ajax(sa + "/games/" + $('#id').val(), {
          contentType: "application/json",
          processData: false,
          data: JSON.stringify({}),
          dataType: "json",
          method: "PATCH",
          headers: {
            Authorization: 'Token token=' + $('#token').val()
        }
    })
      .done(function(data, textStatus, jqXHR) {
          $("#result").val(JSON.stringify(data));
      })
      .fail(function(jqXHR, textStatus, errorThrown) {
          $("#result").val("join failed");
      })
      .always();
  });

$("#move").on("click", function(e) {
      $.ajax(sa + "/games/" + $('#id').val(), {
          contentType: "application/json",
          processData: false,
          data: JSON.stringify({
            game: {
                cell: {
                index: +$('#index').val(),
                value: $('#value').val()
                }
            }
          }),
          dataType: "json",
          method: "PATCH",
          headers: {
            Authorization: 'Token token=' + $('#token').val()
        }
    })
      .done(function(data, textStatus, jqXHR) {
          $("#result").val(JSON.stringify(data));
      })
      .fail(function(jqXHR, textStatus, errorThrown) {
          $("#result").val("move failed");
      })
      .always();
  });

    $('#watch').on('click', function() {
        gameWatcher = resourceWatcher(sa + "/games/" + $('#id').val() + '/watch', {
            Authorization: 'Token token=' + $('#token').val()
        });
        gameWatcher.on('change', function(data){
            var parsedData = JSON.parse(data);
            // heroku routers report this as a 503
            // if (data.timeout) { //not an error
            // gameWatcher.close();
            // return console.warn(data.timeout);
            // }
            var gameData = parsedData.game;
            var cell = gameData.cell
            $('#index').val(cell.index);
            $('#value').val(cell.value);
        });
        gameWatcher.on('error', function(e){
            console.error('an error has occured with the stream', e);
        });
    });

});



