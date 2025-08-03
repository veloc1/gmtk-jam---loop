function _text_random(texts) {
    var i = floor(random(array_length(texts)))
    return texts[i]
}

function text_on_empty_segment() {
    return _text_random([
        "The earth here lies dormant, waiting. \nWhat will you raise from this empty soil?",
    ])
}

function text_on_empty_necropol_segment() {
    return _text_random([
        "The dark energy lingers around. \n Looks like there is a lot of souls \nto collect.",
    ])
}


function text_on_portal() {
    return _text_random([
        "You are arrived at your goal. Will your \njourney end here?",
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

function text_on_building(building, lifetime) {
    return string("You are at {0}. \nThis building will collapse in {1} \nseasons.", building, lifetime)
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

function text_event_tutorial_church() {
    return "Welcome, mage. Ancient whispers have \ndrawn you to this forgotten church. \nRebuild the portal up ahead is your \nonly path home."
}

function text_event_tutorial_mana_gather() {
    return "You can collect energy from ground. \nTry doing this right now."
}

function text_event_tutorial_build() {
    return "With collected energy - you can \ncreate. Try creating building here. \nEvery building will provide different \nresources."
}

function text_event_tutorial_fight() {
    return "Oh no! There is an enemy. Looks \nlike you should fight them. Enemies will \nbe spawned on destroyed \nbuildings."
}
