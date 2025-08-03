enum EVENT {
    TUTORIAL_CHURCH,
    TUTORIAL_MANA_GATHER,
    TUTORIAL_BUILD,
    TUTORIAL_FIGHT,
}


function Event(text, actions, can_skip, is_exclusive) constructor {
    self.text = text
    self.actions = actions
    self.can_skip = can_skip
    self.is_exclusive = is_exclusive
}

function get_event_description(event) {
    var events = []
    events[EVENT.TUTORIAL_CHURCH] = new Event(text_event_tutorial_church(), [ACTION.OK], false, true)
    events[EVENT.TUTORIAL_MANA_GATHER] = new Event(text_event_tutorial_mana_gather(), [ACTION.COLLECT_MANA], false, true)
    events[EVENT.TUTORIAL_BUILD] = new Event(text_event_tutorial_build(), [ACTION.BUILD_QUARRY], false, true) 
    events[EVENT.TUTORIAL_FIGHT] = new Event(text_event_tutorial_fight(), [ACTION.FIGHT], false, true)
    return events[event]
}