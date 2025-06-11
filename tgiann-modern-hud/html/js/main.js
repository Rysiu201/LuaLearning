const huds = ["normal", "square", "circle"];
let staminaBarOn = true;
let inVehicle = false;
let blackbar = false;
let bigMap = false;
let updatedCashCount = 0;
let IsCashHudOn = false;
let cashHudTimeout = null;
let mapType = "";

// window.onload = loaded

// function loaded() {

//   setTimeout(() => {
//     loaded();
//   }, 5000);

//   writeDate();
//   writeClock();
// }

// function writeDate() {
//   let date = new Date();
//   let day = date.getDate();
//   let month = date.getMonth() + 1;
//   let year = date.getFullYear();
//   let strDate = day + '.' + month + '.' + year + " <i class='fa-solid fa-calendar'></i>";
//   $('.day').html(`${strDate}`);
//   setTimeout(() => {
//     writeDate();
//   }, 1 * 60 * 1000);
// }

// function writeClock() {
//   setTimeout(() => {
//     writeClock();
//   }, 2000);
//   let date = new Date();
//   let hours = date.getHours();
//   let minutes = date.getMinutes();
//   let seconds = date.getSeconds();
//   hours = hours < 10 ? '0' + hours : hours;
//   minutes = minutes < 10 ? '0' + minutes : minutes;
//   seconds = seconds < 10 ? '0' + seconds : seconds;
//   let strTime = hours + ':' + minutes + " <i class='fa-solid fa-clock'></i>";
//   $('.time').html(`${strTime}`); setTimeout(() => { writeClock(); }, 1 * 60 * 1000);
// }


$(document).ready(function () {
  $.post("https://tgiann-modern-hud/uiReady");
});

window.addEventListener("message", (event) => {
  const data = event.data;

  switch (data.action) {
    case "first":
      $(".normalHud").fadeIn();
      $(".mainBG").fadeIn(100);

      let switchcircle = window.localStorage.getItem("switchcircle");
      if (switchcircle === null) {
        switchcircle = true;
        window.localStorage.setItem("switchcircle", switchcircle);
      } else if (switchcircle === "false") {
        switchcircle = false;
      } else {
        switchcircle = true;
      }
      $("#switchcircle").attr("checked", switchcircle);
      $.post(
        "https://tgiann-modern-hud/switchcircle",
        JSON.stringify({ isCircle: switchcircle })
      );

      let mono = window.localStorage.getItem("monochrome") === "true";
      if (mono) {
        $("body").addClass("mono");
        $("#monochrome").prop("checked", true);
      }

      let layout = window.localStorage.getItem("hudLayout") || "2";
      $("body").addClass("layout" + layout);
      $("#hudLayout").val(layout);
      enableCustomLayout(layout === "5");

      break;
  }
  if (event.data.action == "hudmenu") {
    $(".hud-menu-container").css("display", "flex");
  }
  else if (event.data.action == "bigMap") {
    if (event.data.show) {
      $(".mainBG").fadeIn();
    } else {
      $(".mainBG").fadeOut();
    }
  }
  else if (event.data.action == "clockStreet") {
    $("#" + "normal" + "StreetNameBoxTop").html((event.data.street).split("|")[0].toUpperCase())
    $("#" + "normal" + "StreetNameBoxBottom").html(((event.data.street).split("|")[1].toUpperCase()).replace("[", "").replace("]", ""))
    $("#" + "normal" + "Compass").html(event.data.compass)
  }
  else if (event.data.action == 'updateStatus') {
    for (let i = 0; i < event.data.data.length; i++) {
      const element = event.data.data[i];
      var val = element.percent
      var prop = element.name

      if (prop == "heal" || prop == "zirh") {
        $("#" + prop).css("width", val + "%")

      $("#switchcircle").attr("checked", switchcircle);
      $.post("https://tgiann-modern-hud/switchcircle", JSON.stringify({ isCircle: switchcircle }));

      let hudPos = window.localStorage.getItem("hudPosition") || "left";
      $("body").addClass(hudPos === "right" ? "hud-right" : "hud-left");
      $("#hudPosition").val(hudPos);

      let mono = window.localStorage.getItem("monochrome") === "true";
      if (mono) {
        $("body").addClass("mono");
        $("#monochrome").prop("checked", true);
      }
      break;

    case "hudmenu":
      $(".hud-menu-container").css("display", "flex");
      break;

    case "bigMap":
      if (data.show) {
        $(".mainBG").fadeIn();
      } else {
        $(".mainBG").fadeOut();
      }
      break;

    case "clockStreet":
      $("#normalStreetNameBoxTop").html(data.street.split("|")[0].toUpperCase());
      $("#normalStreetNameBoxBottom").html(data.street.split("|")[1].toUpperCase().replace("[", "").replace("]", ""));
      $("#normalCompass").html(data.compass);
      break;

    case "updateStatus":
      data.data.forEach((element) => {
        const val = element.percent;
        const prop = element.name;
        if (prop == "heal" || prop == "zirh") {
          $("#" + prop).css("width", val + "%");
        } else {
          $("#" + prop).css("height", val + "%");
        }
      });
      break;

    case "tick":
      $("#normalhealth, #squarehealth").css("width", data.heal + "%");
      $("#normalarmor, #squarearmor").css("width", data.zirh + "%");

      if (data.zirh > 1) {
        $("#normalarmor, #squarearmor, #circlearmor").parent().fadeIn();
        $(".squareHealthArmor").css("grid-template-columns", "repeat(2, 1fr)");
      } else {
        $("#normalarmor, #squarearmor, #circlearmor").parent().fadeOut();
        $(".squareHealthArmor").css("grid-template-columns", "1fr");
      }

      if (!inVehicle) {
        let oxyVal = data.oxy * 2.5;
        oxyVal = Math.min(oxyVal, 100);

        if (oxyVal < 100) {
          $("#normaloxy").css("width", oxyVal + "%");
          $("#normalStaminaBar").fadeOut();
          $("#normalOxyBar").fadeIn();
        } else {
          $("#normalstamina").css("width", data.stamina + "%");
          if (staminaBarOn) $("#normalStaminaBar").fadeIn();
          $("#normalOxyBar").fadeOut();
        }
      }
      break;

    case "carHud":
      $("#squareStreetNameBoxTop").html(data.street.split("|")[0].toUpperCase());
      $("#squareStreetNameBoxBottom").html(data.street.split("|")[1].toUpperCase().replace("[", "").replace("]", ""));
      $("#squareCompass").html(data.compass);

      carHudMiniIconOnOff("engine", data.engine);
      carHudMiniIconOnOff("light", data.light);
      carHudMiniIconOnOff("belt", data.belt);
      carHudMiniIconOnOff("cruise", data.cruise);

      $("#beltColor path").css("fill", data.seatbeltmod ? "orange" : "white");
      $("#engineColor path").css("fill", data.engineHealth < 500 ? "orange" : "white");
      break;

    case "pmavoice":
      let dots = ["micdot1", "micdot2", "micdot3"];
      dots.forEach((dot, i) => {
        let color = (data.value > i) ? "#fff" : "rgba(255, 255, 255, 0.25)";
        $("#normal" + dot).css("background", color).show();
        $("#square" + dot).css("background", color).show();
      });
    } else {
      inVehicle = false
      $("." + "squaremap").fadeOut(function () {
        $(".normalHud").fadeIn();
        $(".carHud").animate(
          {
            opacity: 0,
          },
          100
        );
      });
    }
  }
  else if (event.data.action == "HungerUpdate") {
    let Hunger = event.data.hunger;
    $('#normalhunger').css('width', Hunger + '%');
    $('#squarehunger').css('width', Hunger + '%');
  }
  else if (event.data.action == "ThirstUpdate") {
    let Thirst = event.data.thirst;
    $('#normalwater').css('width', Thirst + '%');
    $('#squarewater').css('width', Thirst + '%');
  }
  else if (event.data.action == "CusalsetSpeedNumbers") {
    SetSpeedValue(event.data.speed)
  }
  else if (event.data.action == "CusalsetFuel") {
    SetFuel(event.data.fuel)
  }
  else if (event.data.action == "CusalsetCarIcon") {
    SetCarIcon(event.data.iconName, event.data.iconColor)
  }
  else if (event.data.type == "vehSpeed") {
    $(".kmh-number").html(event.data.speed)
  }
  else if (event.data.action == "talking") {
    $(".microphoneMicrophone").css("color", "#9400d3");
  }
  else if (event.data.action == "Nottalking") {
    $(".microphoneMicrophone").css("color", "rgba(255, 255, 255, 0.4)");
  }
});

      if (data.value === 0) {
        dots.forEach(dot => {
          $("#normal" + dot).hide();
          $("#square" + dot).hide();
        });
      }
      break;

    case "inVeh":
      inVehicle = data.data;
      if (inVehicle) {
        $(".normalHud").fadeOut(() => {
          $(".squaremap").fadeIn();
          $(".carHud").animate({ opacity: 1 }, 100);
        });
      } else {
        $(".squaremap").fadeOut(() => {
          $(".normalHud").fadeIn();
          $(".carHud").animate({ opacity: 0 }, 100);
        });
      }
      break;

    case "HungerUpdate":
      $('#normalhunger, #squarehunger').css('width', data.hunger + '%');
      break;

    case "ThirstUpdate":
      $('#normalwater, #squarewater').css('width', data.thirst + '%');
      break;

    case "CusalsetSpeedNumbers":
      SetSpeedValue(data.speed);
      break;

    case "CusalsetFuel":
      SetFuel(data.fuel);
      break;

    case "CusalsetCarIcon":
      SetCarIcon(data.iconName, data.iconColor);
      break;

    case "talking":
      $(".microphoneMicrophone").css("color", "#9400D3");
      break;

    case "Nottalking":
      $(".microphoneMicrophone").css("color", "rgba(255, 255, 255, 0.4)");
      break;
  }

  if (data.type === "vehSpeed") {
    $(".kmh-number").html(data.speed);
  }
});

/**
 * @param {Number} speed
 * Sayı olan hız değerini alır, hız sayılarını değiştirir
 * ÖRN: SetSpeedValue(50) 
 */
const SetSpeedValue = speed => {
  speed = speed.toString();

  $(".speedval").removeClass("othernum")
  $(".speedval").html("0")
  $('#speed1').css('color', 'rgb(255 255 255 / 30%)');
  $('#speed2').css('color', 'rgb(255 255 255 / 30%)');
  switch (speed.length) {
    case 1:
      $("#speed0").html(speed[0])
      $('#speed0').css('color', 'rgb(255 255 255 / 100%)');
      $("#speed0").addClass("othernum")
      break;
    case 2:
      $("#speed0").html(speed[1])
      $('#speed0').css('color', 'rgb(255 255 255 / 100%)');
      $("#speed0").addClass("othernum")
      $("#speed1").html(speed[0])
      $('#speed1').css('color', 'rgb(255 255 255 / 100%)');
      $("#speed1").addClass("othernum")
      break;
    case 3:
      $("#speed0").html(speed[2])
      $("#speed0").addClass("othernum")
      $("#speed1").html(speed[1])
      $('#speed1').css('color', 'rgb(255 255 255 / 100%)');
      $("#speed1").addClass("othernum")
      $("#speed2").html(speed[0])
      $('#speed2').css('color', 'rgb(255 255 255 / 100%)');
      $("#speed2").addClass("othernum")
      break;
  }
}

function carHudMiniIconOnOff(style, on) {
  hudcolor = "rgb(255 255 255 / 100%)";
  hudcolor2 = "rgb(255 255 255 / 30%)";
  if (on == "close") {
    $("#" + style).css("color", hudcolor);
  } else if (!on) {
    $("#" + style).css("color", hudcolor2);
  } else {
    $("#" + style).css("color", hudcolor);
  }
}

/**
 * @param {String} icon 
 * @param {String} color
 * Icon id'sini ve renk değerini (hex veya rgb) alır, verilen değerlere göre icon rengi değiştirir.
 * ÖRN: SetCarIcon("seatbelt", "#ff3030")
 * Icon ID'leri : 
 * - headlight <- Farlar
 * - cruise <- Hız sabitleme
 * - engine <- Motor
 * - doors <- Kapılar
 * - trunk <- Bagaj
 * - seatbelt <- Emniyet kemeri
 */
const SetCarIcon = (icon, color) => {
  $(`#${icon}`).css({ "color": `${color}` })
}

const SetFuel = fuel => {
  const Colors = {
    high: "#fff",
    low: "#ef5350"
  }
  if (fuel >= 10) {
    //$(".fuel i").css({"color": `${Colors["high"]}`})
    $("#carHudFuelBarBg").css({ "width": `${fuel}%`, "background": `${Colors["high"]}` })
  } else {
    //$(".fuel i").css({"color": `${Colors["low"]}`})
    $("#carHudFuelBarBg").css({ "width": `${fuel}%`, "background": `${Colors["low"]}` })
  }
}

function setCurrency(price) {
  if (!price) {
    return "0";
  }
  if (price == 0) {
    return "0";
  }
  return price.toLocaleString("tr-TR", {
    style: "decimal",
    currency: "USD",
    maximumFractionDigits: 0,
    minimumFractionDigits: 0,
  });
}

$(document).on("click", "#stamina-checkbox", function (e) {
  staminaBarOn = e.currentTarget.checked;
  for (let x = 0; x < huds.length; x++) {
    const elem = $("#" + huds[x] + "StaminaBar");
    if (staminaBarOn) {
      elem.fadeIn();
    } else {
      elem.fadeOut();
    }
  }
});

$(document).on("click", "#hunger", function (e) {
  for (let x = 0; x < huds.length; x++) {
    const elem = $("#" + huds[x] + "HungerBar");
    if (e.currentTarget.checked) {
      elem.fadeIn();
    } else {
      elem.fadeOut();
    }
  }
});

$(document).on("click", "#water", function (e) {
  for (let x = 0; x < huds.length; x++) {
    const elem = $("#" + huds[x] + "WaterBar");
    if (e.currentTarget.checked) {
      elem.fadeIn();
    } else {
      elem.fadeOut();
    }
  }
});

$(document).on("click", "#monochrome", function (e) {
  const on = e.currentTarget.checked;
  window.localStorage.setItem("monochrome", on);
  if (on) {
    $("body").addClass("mono");
  } else {
    $("body").removeClass("mono");
  }
});


$(document).on("click", "#monochrome", function (e) {
  const on = e.currentTarget.checked;
  window.localStorage.setItem("monochrome", on);
  if (on) {
    $("body").addClass("mono");
  } else {
    $("body").removeClass("mono");
  }
});

$(document).on("change", "#hudPosition", function (e) {
  const pos = e.currentTarget.value;
  window.localStorage.setItem("hudPosition", pos);
  if (pos === "right") {
    $("body").removeClass("hud-left").addClass("hud-right");
    $.post("https://tgiann-modern-hud/setHudPosition", JSON.stringify({ pos: "right" }));
  } else {
    $("body").removeClass("hud-right").addClass("hud-left");
    $.post("https://tgiann-modern-hud/setHudPosition", JSON.stringify({ pos: "left" }));
  }
});

$(document).on("click", "#monochrome", function (e) {
  const on = e.currentTarget.checked;
  window.localStorage.setItem("monochrome", on);
  if (on) {
    $("body").addClass("mono");
  } else {
    $("body").removeClass("mono");
  }
});

$(document).on("change", "#hudPosition", function (e) {
  const pos = e.currentTarget.value;
  window.localStorage.setItem("hudPosition", pos);
  if (pos === "right") {
    $("body").removeClass("hud-left").addClass("hud-right");
  } else {
    $("body").removeClass("hud-right").addClass("hud-left");
  }
});

$(document).on("click", "#monochrome", function (e) {
  if (e.currentTarget.checked) {
    $("body").addClass("mono");
  } else {
    $("body").removeClass("mono");
  }
});

$(document).on("change", "#hudPosition", function (e) {
  const pos = e.currentTarget.value;
  window.localStorage.setItem("hudPosition", pos);
  if (pos === "right") {
    $("body").removeClass("hud-left").addClass("hud-right");
  } else {
    $("body").removeClass("hud-right").addClass("hud-left");
  }
});

$(document).on("click", ".hud-menu-header-close", function (e) {
  $(".hud-menu-container").css("display", "none");
  $.post("https://tgiann-modern-hud/hudmenuclose");
});

$(document).on("click", "#imenu", function (e) {
  $.post(
    "https://tgiann-modern-hud/imenu",
    JSON.stringify({ status: e.currentTarget.checked })
  );
});

$(document).on("click", "#switchcircle", function (e) {
  window.localStorage.setItem("switchcircle", e.currentTarget.checked);
  $.post(
    "https://tgiann-modern-hud/switchcircle",
    JSON.stringify({ isCircle: e.currentTarget.checked })
  );
});

$(document).on("change", "#hudLayout", function (e) {
  const layout = e.currentTarget.value;
  window.localStorage.setItem("hudLayout", layout);
  $("body").removeClass("layout1 layout2 layout3 layout4 layout5").addClass("layout" + layout);
  enableCustomLayout(layout === "5");
});

$(document).on("click", "#blackbar", function (e) {
  blackbar = e.currentTarget.checked;
  if (blackbar) {
    $(".mainBG").fadeOut();
    $(".blackbar-container").css("display", "flex");
  } else {
    $(".mainBG").fadeIn();
    $(".blackbar-container").css("display", "none");
  }
  $.post(
    "https://tgiann-modern-hud/blackbar",
    JSON.stringify({ status: e.currentTarget.checked })
  );
});

$(document).keyup(function (e) {
  if (e.keyCode == 27) {
    $(".hud-menu-container").css("display", "none");
    $.post("https://tgiann-modern-hud/hudmenuclose");
  }
});

$(document).mousedown(function (ev) {
  if (ev.which == 3) {
    $(".hud-menu-container").css("display", "none");
    $.post("https://tgiann-modern-hud/hudmenuclose");
  }
});

function makeDraggable(elem) {
  elem.onmousedown = function (ev) {
    ev.preventDefault();
    const shiftX = ev.clientX - elem.getBoundingClientRect().left;
    const shiftY = ev.clientY - elem.getBoundingClientRect().top;

    function moveAt(pageX, pageY) {
      elem.style.left = pageX - shiftX + "px";
      elem.style.top = pageY - shiftY + "px";
      elem.style.position = "absolute";
    }

    function onMouseMove(event) {
      moveAt(event.pageX, event.pageY);
    }

    document.addEventListener("mousemove", onMouseMove);
    document.onmouseup = function () {
      document.removeEventListener("mousemove", onMouseMove);
      document.onmouseup = null;
    };
  };
  elem.ondragstart = function () {
    return false;
  };
}

function enableCustomLayout(enable) {
  if (enable) {
    makeDraggable(document.querySelector('.normalHudTop'));
    makeDraggable(document.querySelector('.normalStatusHud'));
  }
}
