for (var i = 0; i < array_length(incremented_resources);i++) {
    var ir = incremented_resources[i]
    if (ir.to_delete) {
        array_delete(incremented_resources, i, 1)
        i -= 1
    }
}
for (var i = 0; i < array_length(insufficient_resources);i++) {
    var ir = insufficient_resources[i]
    if (ir.to_delete) {
        array_delete(insufficient_resources, i, 1)
        i -= 1
    }
}

for (var i = 0; i < array_length(action_buttons);i++) {
    action_buttons[i].step()
}

skip_button.step()