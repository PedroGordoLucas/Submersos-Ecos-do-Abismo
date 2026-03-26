// Draw GUI

var player = instance_find(oScorpio, 0);

if (instance_exists(player)) {

    // Texto
    draw_set_color(c_white);
    draw_text(20, 20, "Energia: " + string(player.energia));

    // Barra
    var largura = 200;
    var altura = 20;

    draw_set_color(c_red);
    draw_rectangle(20, 50, 20 + largura, 50 + altura, false);

    draw_set_color(c_green);
    draw_rectangle(20, 50, 20 + (largura * (player.energia / 100)), 50 + altura, false);
}