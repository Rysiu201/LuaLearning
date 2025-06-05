local Translations = {
    ui = {
        -- Główne
        male = "Mężczyzna",
        female = "Kobieta",
        error_title = "Błąd!",
        characters_header = "Wybór postaci",
        characters_count = "postacie",
      
        -- Tworzenie postaci
        default_image = 'image/action_dot.gif',
        create_new_character = "Stwórz nową postać",
        default_right_image = 'image/action_key.png',

        -- Tworzenie tożsamości
        create_header = "Tworzenie tożsamości",
        header_detail = "Wprowadź dane swojej postaci",
        gender_marker = "Płeć",
        
        missing_information = "Brakuje niektórych informacji.",
        badword = "Użyłeś niedozwolonego słowa, spróbuj ponownie!",
       
        create_firstname = "Imię",
        create_lastname = "Nazwisko",
        create_nationality = "Narodowość",
        create_birthday = "Data urodzenia",

        -- Przyciski
        select = "Wybierz",
        create = "Stwórz",
        spawn = "Wybudź",
        delete = "Usuń",
        cancel = "Anuluj",
        confirm = "Potwierdź",
        close = "Zamknij",
    },

    notifications = {
        ["char_deleted"] = "Postać usunięta!",
        ["deleted_other_char"] = "Pomyślnie usunięto postać o ID obywatela %{citizenid}.",
        ["forgot_citizenid"] = "Nie podałeś ID obywatela!",
    },

    commands = {
        -- /deletechar
        ["deletechar_description"] = "Usuwa postać innego gracza",
        ["citizenid"] = "ID obywatela",
        ["citizenid_help"] = "ID obywatela postaci, którą chcesz usunąć",

        -- /logout
        ["logout_description"] = "Wyloguj się z postaci (tylko dla admina)",

        -- /closeNUI
        ["closeNUI_description"] = "Zamknij Multi NUI"
    },

    misc = {
        ["succes_loaded"] = '^2[qb-core]^7 %{value} został pomyślnie załadowany!',
        ["droppedplayer"] = "Zostałeś rozłączony z QBCore"
    },
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
