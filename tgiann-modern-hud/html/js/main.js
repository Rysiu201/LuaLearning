const huds = ["normal", "square", "circle"];
let staminaBarOn = true;
let inVehicle = false;
let blackbar = false;
let bigMap = false;
let updatedCashCount = 0;
let IsCashHudOn = false;
let cashHudTimeout = null;
let mapType = "";
let customMode = false;

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

      //Map
      let switchcircle = window.localStorage.getItem("switchcircle");
      if (switchcircle == null) {
        switchcircle = true;
        window.localStorage.setItem("switchcircle", switchcircle);
      } else if (switchcircle == "false") {
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
      placeNormalBars(layout);

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
      } else {
        $("#" + prop).css("height", val + "%")
      }
    }
  }
  else if (event.data.action == 'tick') {
    $("#normalhealth").css("width", event.data.heal + "%")
    $("#squarehealth").css("width", event.data.heal + "%")
    $("#normalarmor").css("width", event.data.zirh + "%")
    $("#squarearmor").css("width", event.data.zirh + "%")
    if (event.data.zirh > 1) {
      $("#normalarmor").parent().fadeIn();
      $("#squarearmor").parent().fadeIn();
      $("#circlearmor").parent().fadeIn();
      $(".squareHealthArmor").css("grid-template-columns", "repeat(2, 1fr)");
    } else {
      $("#normalarmor").parent().fadeOut();
      $("#squarearmor").parent().fadeOut();
      $("#circlearmor").parent().fadeOut();
      $(".squareHealthArmor").css("grid-template-columns", "1fr");
    }
    if (!inVehicle) {
      let oxyVal = event.data.oxy * 2.5
      if (oxyVal > 100) { oxyVal = 100 }
      if (oxyVal < 100) {
        $("#normaloxy").css("width", oxyVal + "%")
        $("#normalStaminaBar").fadeOut()
        $("#normalOxyBar").fadeIn()
      } else {
        $("#normalstamina").css("width", event.data.stamina + "%")
        if (staminaBarOn) { $("#normalStaminaBar").fadeIn(); }
        $("#normalOxyBar").fadeOut()
      }
    }
  }
  else if (event.data.action == "carHud") {
    $("#" + "square" + "StreetNameBoxTop").html((event.data.street).split("|")[0].toUpperCase())
    $("#" + "square" + "StreetNameBoxBottom").html(((event.data.street).split("|")[1].toUpperCase()).replace("[", "").replace("]", ""))
    $("#" + "square" + "Compass").html(event.data.compass)

    // carHudMiniIconOnOff("doors", event.data.doors)
    carHudMiniIconOnOff("engine", event.data.engine)
    carHudMiniIconOnOff("light", event.data.light)
    carHudMiniIconOnOff("belt", event.data.belt)
    // carHudMiniIconOnOff("trunk", event.data.trunk)
    carHudMiniIconOnOff("cruise", event.data.cruise)
    if (event.data.engineHealth < 500) {
      $("#engineColor path").css("fill", "orange")
    } else {
      $("#engineColor path").css("fill", "white")
    }
  }
  else if (event.data.action == "pmavoice") {
    if (event.data.value == 1) {
      $("#" + "normal" + "micdot1").css("background", "#fff");
      $("#" + "normal" + "micdot2").css(
        "background",
        "rgba(255, 255, 255, 0.25)"
      );
      $("#" + "normal" + "micdot3").css(
        "background",
        "rgba(255, 255, 255, 0.25)"
      );
      // Araç İçin
      $("#" + "square" + "micdot1").css("background", "#fff");
      $("#" + "square" + "micdot2").css(
        "background",
        "rgba(255, 255, 255, 0.25)"
      );
      $("#" + "square" + "micdot3").css(
        "background",
        "rgba(255, 255, 255, 0.25)"
      );

    } else if (event.data.value == 2) {
      $("#" + "normal" + "micdot1").css("background", "#fff");
      $("#" + "normal" + "micdot2").css("background", "#fff");
      $("#" + "normal" + "micdot3").css(
        "background",
        "rgba(255, 255, 255, 0.25)"
      );

      // Araç İçin
      $("#" + "square" + "micdot1").css("background", "#fff");
      $("#" + "square" + "micdot2").css("background", "#fff");
      $("#" + "square" + "micdot3").css(
        "background",
        "rgba(255, 255, 255, 0.25)"
      );
    } else if (event.data.value == 3) {
      $("#" + "normal" + "micdot1").css("background", "#fff");
      $("#" + "normal" + "micdot2").css("background", "#fff");
      $("#" + "normal" + "micdot3").css("background", "#fff");

      // Araç İçin
      $("#" + "square" + "micdot1").css("background", "#fff");
      $("#" + "square" + "micdot2").css("background", "#fff");
      $("#" + "square" + "micdot3").css("background", "#fff");
    } else {
      $("#" + "normal" + "micdot1").css("display", "none");
      $("#" + "normal" + "micdot2").css("display", "none");
      $("#" + "normal" + "micdot3").css("display", "none");

      // Araç İçin
      $("#" + "square" + "micdot1").css("display", "none");
      $("#" + "square" + "micdot2").css("display", "none");
      $("#" + "square" + "micdot3").css("display", "none");
    }
  }
  else if (event.data.action == "inVeh") {
    if (event.data.data) {
      inVehicle = true
      $(".normalHud").fadeOut(function () {
        $("." + "squaremap").fadeIn();
        $(".carHud").animate(
          {
            opacity: 1,
          },
          100
        );

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

$(document).on("change", "#stamina-checkbox", function (e) {
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

$(document).on("change", "#hunger", function (e) {
  for (let x = 0; x < huds.length; x++) {
    const elem = $("#" + huds[x] + "HungerBar");
    if (e.currentTarget.checked) {
      elem.fadeIn();
    } else {
      elem.fadeOut();
    }
  }
});

$(document).on("change", "#water", function (e) {
  for (let x = 0; x < huds.length; x++) {
    const elem = $("#" + huds[x] + "WaterBar");
    if (e.currentTarget.checked) {
      elem.fadeIn();
    } else {
      elem.fadeOut();
    }
  }
});

$(document).on("change", "#monochrome", function (e) {
  const on = e.currentTarget.checked;
  window.localStorage.setItem("monochrome", on);
  if (on) {
    $("body").addClass("mono");
  } else {
    $("body").removeClass("mono");
  }
});


$(document).on("click", ".hud-menu-header-close", function (e) {
  if (customMode) {
    customMode = false;
    $("#customHint").css("display", "none");
    enableCustomLayout(false);
  }
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
  $("body")
    .removeClass("layout1 layout2 layout3 layout4 layout5")
    .addClass("layout" + layout);
  enableCustomLayout(layout === "5");
  placeNormalBars(layout);
  if (layout === "5") {
    customMode = true;
    $("#customHint").css("display", "block");
    $(".hud-menu-container").css("display", "none");
  } else {
    customMode = false;
  }
});

$(document).on("change", "#hudLayout", function (e) {
  const layout = e.currentTarget.value;
  window.localStorage.setItem("hudLayout", layout);
  $("body")
    .removeClass("layout1 layout2 layout3 layout4 layout5")
    .addClass("layout" + layout);
  enableCustomLayout(layout === "5");
  placeNormalBars(layout);
  if (layout === "5") {
    customMode = true;
    $("#customHint").css("display", "block");
    $(".hud-menu-container").css("display", "none");
  } else {
    customMode = false;
  }
});

$(document).on("change", "#hudLayout", function (e) {
  const layout = e.currentTarget.value;
  window.localStorage.setItem("hudLayout", layout);
  $("body")
    .removeClass("layout1 layout2 layout3 layout4 layout5")
    .addClass("layout" + layout);
  enableCustomLayout(layout === "5");
  placeNormalBars(layout);
});

$(document).on("change", "#hudLayout", function (e) {
  const layout = e.currentTarget.value;
  window.localStorage.setItem("hudLayout", layout);
  $("body")
    .removeClass("layout1 layout2 layout3 layout4 layout5")
    .addClass("layout" + layout);
  enableCustomLayout(layout === "5");
  placeNormalBars(layout);
});

$(document).on("change", "#hudLayout", function (e) {
  const layout = e.currentTarget.value;
  window.localStorage.setItem("hudLayout", layout);
  $("body")
    .removeClass("layout1 layout2 layout3 layout4 layout5")
    .addClass("layout" + layout);
  enableCustomLayout(layout === "5");
  placeNormalBars(layout);
});

$(document).on("change", "#blackbar", function (e) {
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
    if (customMode) {
      customMode = false;
      $("#customHint").css("display", "none");
      enableCustomLayout(false);
    }
    $(".hud-menu-container").css("display", "none");
    $.post("https://tgiann-modern-hud/hudmenuclose");
  }
});

$(document).mousedown(function (ev) {
  if (ev.which == 3) {
    if (customMode) {
      customMode = false;
      $("#customHint").css("display", "none");
      enableCustomLayout(false);
    }
    $(".hud-menu-container").css("display", "none");
    $.post("https://tgiann-modern-hud/hudmenuclose");
  }
});

function makeDraggable(elem) {
  if (!elem) return;
  const rect = elem.getBoundingClientRect();
  elem.style.position = "absolute";
  elem.style.left = rect.left + "px";
  elem.style.top = rect.top + "px";
  elem.style.cursor = "move";

  elem.onmousedown = function (ev) {
    ev.preventDefault();
    const shiftX = ev.clientX - elem.getBoundingClientRect().left;
    const shiftY = ev.clientY - elem.getBoundingClientRect().top;

    function moveAt(pageX, pageY) {
      elem.style.left = pageX - shiftX + "px";
      elem.style.top = pageY - shiftY + "px";
    }

    function onMouseMove(event) {
      moveAt(event.pageX, event.pageY);
    }

    document.addEventListener("mousemove", onMouseMove);
    document.onmouseup = function () {
      document.removeEventListener("mousemove", onMouseMove);
      document.onmouseup = null;
      savePos(elem);
    };
  };
  elem.ondragstart = function () {
    return false;
  };
}

function disableDraggable(elem) {
  if (!elem) return;
  elem.onmousedown = null;
  elem.ondragstart = null;
  elem.style.cursor = "";
}

function savePos(elem) {
  if (!elem || !elem.dataset.dragId) return;
  localStorage.setItem(
    "customPos_" + elem.dataset.dragId,
    JSON.stringify({ left: elem.style.left, top: elem.style.top })
  );
}

function loadPos(elem) {
  if (!elem || !elem.dataset.dragId) return;
  const pos = localStorage.getItem("customPos_" + elem.dataset.dragId);
  if (pos) {
    const { left, top } = JSON.parse(pos);
    elem.style.position = "absolute";
    elem.style.left = left;
    elem.style.top = top;
  }
}

function enableCustomLayout(enable) {
  const selectors = [
    [".normalHudTop", "normalHudTop"],
    [".normalStatusHud", "normalStatusHud"],
    [".circlemap", "circlemap"],
    [".squaremap", "squaremap"],
    [".money-cash", "moneyCash"],
  ];

  selectors.forEach(([sel, id]) => {
    const el = document.querySelector(sel);
    if (!el) return;
    el.dataset.dragId = id;
    if (enable) {
      loadPos(el);
      makeDraggable(el);
    } else {
      savePos(el);
      disableDraggable(el);
    }
  });
}

function placeNormalBars(layout) {
  const bars = $(".normalStatusHudTop");
  const hudTop = $(".normalHudTop");
  const statusHud = $(".normalStatusHud");

  if (layout === "3") {
    if (!statusHud.find(bars).length) {
      statusHud.append(bars);
    }
    bars.css("margin-left", "0");
  } else {
    if (!hudTop.find(bars).length) {
      bars.insertBefore(hudTop.find(".normalStreetNameCompass"));
    }
    bars.css("margin-left", "");
  }
}