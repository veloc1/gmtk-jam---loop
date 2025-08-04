if (state == "start-record") {
    gif_image = gif_open(1366, 768);
    state = "record"
} else if (state == "record") {
    gif_add_surface(gif_image, application_surface, 6/100);
} else if (state == "stop") {
    state = "none"    
    
    var current_date = date_current_datetime();
    var timestamp = string(date_get_year(current_date)) + 
                    string_format(date_get_month(current_date), 2, 0) + 
                    string_format(date_get_day(current_date), 2, 0) + "_" + 
                    string_format(date_get_hour(current_date), 2, 0) + 
                    string_format(date_get_minute(current_date), 2, 0) + 
                    string_format(date_get_second(current_date), 2, 0);
    
    var gif_filename = string("{0}_{1}.gif", game_display_name, timestamp);
    var file = get_save_filename("*.gif", gif_filename)
    if (file == undefined) {
        return
    }
    gif_save(gif_image, file);
    
}