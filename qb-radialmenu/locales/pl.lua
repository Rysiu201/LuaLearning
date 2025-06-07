local Translations = {
    error = {
        no_people_nearby = "Brak graczy w pobliżu",
        no_vehicle_found = "Nie znaleziono pojazdu",
        extra_deactivated = "Dodatek %{extra} został dezaktywowany",
        extra_not_present = "Dodatek %{extra} nie jest dostępny w tym pojeździe",
        not_driver = "Nie jesteś kierowcą pojazdu",
        vehicle_driving_fast = "Ten pojazd jedzie za szybko",
        seat_occupied = "To siedzenie jest zajęte",
        race_harness_on = "Masz pas wyścigowy, nie możesz zmienić miejsca",
        obj_not_found = "Nie można utworzyć żądanego obiektu",
        not_near_ambulance = "Nie jesteś w pobliżu karetki",
        far_away = "Jesteś za daleko",
        stretcher_in_use = "Te nosze są już używane",
        not_kidnapped = "Nie porwałeś tej osoby",
        trunk_closed = "Bagażnik jest zamknięty",
        cant_enter_trunk = "Nie możesz wejść do tego bagażnika",
        already_in_trunk = "Już jesteś w bagażniku",
        someone_in_trunk = "Ktoś już jest w bagażniku"
    },
    success = {
        extra_activated = "Dodatek %{extra} został aktywowany",
        entered_trunk = "Wszedłeś do bagażnika"
    },
    info = {
        no_variants = "Wygląda na to, że nie ma żadnych wariantów dla tego",
        wrong_ped = "Ten model postaci nie zezwala na tę opcję",
        nothing_to_remove = "Wygląda na to, że nie masz nic do usunięcia",
        already_wearing = "Już to nosisz",
        switched_seats = "Teraz jesteś na %{seat}"
    },
    general = {
        command_description = "Otwórz menu radialne",
        push_stretcher_button = "~g~E~w~ - Pchaj nosze",
        stop_pushing_stretcher_button = "~g~E~w~ - Przestań pchać",
        lay_stretcher_button = "~g~G~w~ - Połóż na noszach",
        push_position_drawtext = "Pchnij tutaj",
        get_off_stretcher_button = "~g~G~w~ - Zejdź z noszy",
        get_out_trunk_button = "[~g~E~w~] Wyjdź z bagażnika",
        close_trunk_button = "[~g~G~w~] Zamknij bagażnik",
        open_trunk_button = "[~g~G~w~] Otwórz bagażnik",
        getintrunk_command_desc = "Wejdź do bagażnika",
        putintrunk_command_desc = "Włóż gracza do bagażnika"
    },
    options = {
        emergency_button = "Przycisk awaryjny",
        driver_seat = "Fotel kierowcy",
        passenger_seat = "Fotel pasażera",
        other_seats = "Inne miejsce",
        rear_left_seat = "Tylne lewe siedzenie",
        rear_right_seat = "Tylne prawe siedzenie"
    },
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
