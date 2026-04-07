var player = instance_find(oScorpio, 0);

if (instance_exists(player)) {

    // ======================
    // 📍 POSIÇÃO BASE
    // ======================
    var pos_x = 20;
    var pos_y = 20;
    var espacamento = 15;

    draw_set_color(c_white);

    // ======================
    // 🛡️ ESTRUTURA (SPRITE + BARRA REAL)
    // ======================
    draw_text(pos_x, pos_y, "ESTRUTURA");
    pos_y += 18;

    // porcentagem
    var perc = player.estrutura_draw / player.estrutura.max;

    // tamanho da sprite
    var w = sprite_get_width(sSpr_vida);
    var h = sprite_get_height(sSpr_vida);

    // 🔳 FUNDO
    draw_set_color(make_color_rgb(40,40,40));
    draw_rectangle(pos_x, pos_y, pos_x + w, pos_y + h, false);

    // 🟩 PREENCHIMENTO
    var cor = make_color_rgb(0,180,255);

    if (perc < 0.6) cor = c_yellow;
    if (perc < 0.3) cor = c_red;

    draw_set_color(cor);
    draw_rectangle(pos_x, pos_y, pos_x + (w * perc), pos_y + h, false);

    // 🧱 SPRITE POR CIMA
    draw_sprite(sSpr_vida, 0, pos_x, pos_y);

    draw_set_color(c_white);

    pos_y += h + espacamento;
}
var padding = 4;

draw_rectangle(
    pos_x + padding,
    pos_y + padding,
    pos_x + padding + (w - padding*2) * perc,
    pos_y + h - padding,
    false
);