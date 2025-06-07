var zr_resource = GetParentResourceName();
var zr_config = {};
var zr_data = {};
var zr_jobs = {};
let birthdateRaw = zr_data.zr_birthdate || "0000-00-00";
let birthdateParts = birthdateRaw.split("-");
let formattedBirthdate = `${birthdateParts[2]}-${birthdateParts[1]}-${birthdateParts[0]}`;

window.addEventListener("message", function(event) {
    let data = event.data;

    if ( data.type == 'show' ) {
        $("#zr-container").show();
        zr_config = data.config;
        zr_data = data.data;
        zr_jobs = data.jobs;
        zr_data.server_date = data.server_date;
        zr_data.server_time = data.server_time;
        zr_data.changelog = data.changelog;
        zr_data.headshot = data.headshot;
        zr_data.location = data.location;
        zr_setup_pausemenu();
    } 

    if ( data.type == 'hide' ) {
        $("#zr-container").hide();
    };
});

function zr_setup_pausemenu() {
    var translation = zr_config.zr_translation;
    var gender = translation.male;
    $('#zr-jobs').html('');
    $("#zr-back").html(translation.back);
    $("#rysiu-logout").html(translation.logout);
    $("#zr-disconnect").html(translation.disconnect);
    $("#zr-rules-txt").html(translation.rulestitle);
    $("#zr-rules-rules").html(translation.rules);
    $("#zr-discord-txt").html(translation.discord);
    $('#zr-trans-maps').html(translation.maps);
    $("#zr-trans-tmaps").html(translation.mapstxt);
    $("#zr-trans-settings").html(translation.settings);
    $("#zr-trans-tsettings").html(translation.settingstxt);
    $("#zr-changelog-btn").html(translation.changelogbtn);
    $("#zr-changelog-title").html(translation.changelog);
    $("#zr-changelog-content").html(zr_data.changelog);
    if (zr_data.zr_gender == 1) {
      gender = translation.female;
    }
    if (zr_data.zr_gender == 'm') {
      gender = translation.male;
    }
    if (zr_data.zr_gender == 'f') {
      gender = translation.female;
    }
document.documentElement.style.setProperty("--zr-green", (gender == translation.male ? "rgba(114, 137, 217, 1)" : "rgb(166, 62, 204)"));
document.documentElement.style.setProperty("--zr-blue", (gender == translation.male ? "rgba(114, 137, 217, 1)" : "rgb(166, 62, 204)"));
var header = "<div id="zr-info-header"><div id="zr-info-avatar"></div><div id="zr-info-extra"><div id="zr-info-datetime"></div><div id="zr-info-location"></div></div></div>";
    var charinfo = header + "\n    <div class=\"zr-infos-title\">1. <span class=\"zr-clr\">Character Information.</span></div>\n    <div class=\"zr-infos-infos\">\n        <div class=\"zr-infos-box\">\n            <div class=\"zr-box-ele\"></div>\n            <div class=\"zr-box-img\" style=\"background-image: url('./zr-assets/zr-icon-name.svg');\"></div>\n            <div class=\"zr-box-infos\">" + translation.fname + ": <span class=\"zr-clr\">" + zr_data.zr_firstName + "</span></div>\n        </div>\n        <div class=\"zr-infos-box\">\n            <div class=\"zr-box-ele\"></div>\n            <div class=\"zr-box-img\" style=\"background-image: url('./zr-assets/zr-icon-name.svg');\"></div>\n            <div class=\"zr-box-infos\">" + translation.lname + ': <span class="zr-clr">' + zr_data.zr_lastName + "</span></div>\n        </div>\n        <div class=\"zr-infos-box\">\n            <div class=\"zr-box-img\" style=\"background-image: url('./zr-assets/zr-icon-gender.svg');\"></div>\n            <div class=\"zr-box-infos\">" + translation.gender + ": <span class=\"zr-clr-sec\">" + gender + "</span></div>\n        </div>\n        <div class=\"zr-infos-box\">\n            <div class=\"zr-box-img\" style=\"background-image: url('./zr-assets/zr-icon-dob.svg');\"></div>\n            <div class=\"zr-box-infos\">" + translation.dob + ': <span class="zr-clr-sec">' + zr_data.zr_birthdate + "</span></div>\n        </div>\n        <div class=\"zr-infos-box\" style=\"width: 100%;\">\n            <div class=\"zr-box-ele\"></div>\n            <div class=\"zr-box-img\" style=\"background-image: url('./zr-assets/zr-icon-job.svg');\"></div>\n            <div class=\"zr-box-infos\">" + translation.job + ": <span class=\"zr-clr\">" + zr_data.zr_job + "</span> - <span class=\"zr-clr\">" + zr_data.zr_grade + "</span></div>\n        </div>\n        <div class=\"zr-infos-box\">\n            <div class=\"zr-box-img\" style=\"background-image: url('./zr-assets/zr-icon-cash.svg');\"></div>\n            <div class=\"zr-box-infos\">" + translation.cash + ": <span class=\"zr-clr\">" + zr_data.zr_cash + "</span> " + translation.currency + "</div>\n        </div>\n        <div class=\"zr-infos-box\">\n            <div class=\"zr-box-img\" style=\"background-image: url('./zr-assets/zr-icon-bank.svg');\"></div>\n            <div class=\"zr-box-infos\">" + translation.bank + ": <span class=\"zr-clr\">" + zr_data.zr_bank + "</span> " + translation.currency + "</div>\n        </div>\n    </div>\n    <div class=\"zr-triple\" style=\"right: 1.563vw;\"><div class=\"zr-triple-ele\"></div><div class=\"zr-triple-ele\"></div><div class=\"zr-triple-ele\"></div></div>\n    <div class=\"zr-line\" style=\"top: 1.563vw;\"></div>\n    ";
    $("#zr-multi-infos").html(charinfo);
$("#zr-info-datetime").html(zr_data.server_date + " " + zr_data.server_time);
$("#zr-info-location").html(zr_data.location);
$("#zr-info-avatar").css("background-image", "url('https://nui-img/" + zr_data.headshot + "/" + zr_data.headshot + "')");
    $.each(zr_jobs, function (_, job) {
      var jobdata = "<div class=\"zr-job\" style=\"border-color: " + job.color + ";\"><span style=\"color: " + job.color + ";\">" + job.name + ":&nbsp</span>" + job.count + ' ' + job.suivname + "</div>";
      $('#zr-jobs').append(jobdata);
    });
  }

  $('#zr-maps').click(function () {
    $.post("https://" + zr_resource + "/show-maps");
  });
  $("#zr-settings-main").click(function () {
    $.post("https://" + zr_resource + "/show-settings");
  });
  $("#zr-back").click(function () {
    $.post("https://" + zr_resource + "/hide");
  });
  $("#rysiu-logout").click(function () {
    $.post("https://" + zr_resource + "/logout");
  });
    $("#zr-disconnect").click(function () {
      $.post("https://" + zr_resource + "/disconnect");
    });
    $("#zr-changelog-btn").click(function () {
      $("#zr-changelog").toggle();
    });
  $("#zr-discord").click(function () {
    window.invokeNative("openUrl", zr_config.discord);
  });

  window.addEventListener("keydown", (event) => {
    if ( event.keyCode == 27 || event.keyCode == 8 ) {
      $.post("https://" + zr_resource + "/hide");
    }
  })