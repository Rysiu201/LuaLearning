local Translations = {
afk = {
    will_kick = 'Jesteś AFK i zostaniesz wyrzucony za ',
    time_seconds = ' sekund!',
    time_minutes = ' minut(y)!',
    kick_message = 'Zostałeś wyrzucony za bycie AFK',
},
wash = {
    in_progress = "Pojazd jest myty...",
    wash_vehicle = "[E] Umyj pojazd",
    wash_vehicle_target = "Umyj pojazd",
    dirty = "Pojazd nie jest brudny.",
    cancel = "Anulowano...",
},
consumables = {
    eat_progress = "Jesz...",
    drink_progress = "Pijesz...",
    liqour_progress = "Pijesz alkohol...",
    coke_progress = "Wciągasz kreskę...",
    crack_progress = "Palisz crack...",
    ecstasy_progress = "Łykasz pigułki...",
    healing_progress = "Leczysz się...",
    meth_progress = "Palisz mety...",
    joint_progress = "Odpalasz jointa...",
    use_parachute_progress = "Zakładasz spadochron...",
    pack_parachute_progress = "Składasz spadochron...",
    no_parachute = "Nie masz spadochronu!",
    armor_full = "Masz już wystarczająco pancerza!",
    armor_empty = "Nie masz założonej kamizelki...",
    armor_progress = "Zakładasz kamizelkę kuloodporną...",
    heavy_armor_progress = "Zakładasz ciężką kamizelkę...",
    remove_armor_progress = "Zdejmujesz kamizelkę...",
    canceled = "Anulowano...",
},
cruise = {
    unavailable = "Tempomat niedostępny",
    activated = "Tempomat aktywowany: ",
    deactivated = "Tempomat wyłączony",
},
editor = {
    started = "Rozpoczęto nagrywanie!",
    save = "Zapisano nagranie!",
    delete = "Usunięto nagranie!",
    editor = "Do zobaczenia później!",
},
firework = {
    place_progress = "Umieszczanie fajerwerki...",
    canceled = "Anulowano...",
    time_left = "Fajerwerka skończy się za ~r~"
},
seatbelt = {
    use_harness_progress = "Zakładasz uprząż wyścigową...",
    remove_harness_progress = "Zdejmujesz uprząż wyścigową...",
    no_car = "Nie jesteś w pojeździe.",
},
teleport = {
    teleport_default = 'Użyj windy'
},
pushcar = {
    stop_push = "[E] Zatrzymaj pchanie"
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})