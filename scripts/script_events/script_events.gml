enum EVENT {
    TUTORIAL_CHURCH,
    TUTORIAL_MANA_GATHER,
    TUTORIAL_BUILD,
    TUTORIAL_FIGHT,
}


function Event(text, actions, can_skip) constructor {
    self.text = text
    self.actions = actions
    self.can_skip = can_skip
}

function get_event_description(event) {
    var events = []
    events[EVENT.TUTORIAL_CHURCH] = new Event(text_event_tutorial_church(), [ACTION.OK], false)
    return events[event]
}