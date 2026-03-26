var player = instance_find(oScorpio, 0);

if (instance_exists(player)) {
    draw_text(20, 20, "Energia: " + string(player.energia));
}