function _text_random(texts) {
    var i = floor(random(array_length(texts)))
    return texts[i]
}

function text_on_empty_segment() {
    return _text_random([
        "The earth here lies dormant, waiting. \nWhat will you raise from this empty soil?",
    ])
}


function text_on_portal() {
    return _text_random([
        "You are arrived at your goal. Will your \njourney ends here?",
    ])
}


function text_on_church() {
    return _text_random([
        "You can rest here. Everything can wait.",
        "You can rest here. Everything can wait.",
        "You can rest here. Everything can wait.",
        "You can rest here. Everything can wait.",
        "You can rest here. Everything can wait.",
        "You can rest here. Everything can wait.",
        "Astrologers proclaim month of the \nHourglass. Looks like the history will \nrepeat itself.",
    ])
}


function text_on_enemy() {
    return _text_random([
        "The air grows thick with malice. Your \npath forward demands a choice.",
        "Something ancient blocks your way. It \nwill not yield without contest.",
    ])
}


function text_in_fight() {
    return _text_random([
        "You are in the middle of the fight",
    ])
}