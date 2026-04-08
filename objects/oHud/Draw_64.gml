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
    // Porcentagem
    var perc = player.estrutura_draw / player.estrutura.max;
    // Tamanho da sprite
    var w = sprite_get_width(sSpr_vida);
    var h = sprite_get_height(sSpr_vida);
    // 🔳 FUNDO
    draw_set_color(make_color_rgb(40, 40, 40));
    draw_rectangle(pos_x, pos_y, pos_x + w, pos_y + h, false);
    // 🟩 PREENCHIMENTO
    var cor = make_color_rgb(0, 180, 255);
    if (perc < 0.6) cor = c_yellow;
    if (perc < 0.3) cor = c_red;
    draw_set_color(cor);
    draw_rectangle(pos_x, pos_y, pos_x + (w * perc), pos_y + h, false);
    // 🧱 SPRITE POR CIMA
    draw_sprite(sSpr_vida, 0, pos_x, pos_y);
    draw_set_color(c_white);
    pos_y += h + espacamento;
    // 🔲 BARRA COM PADDING
    var padding = 4;
    draw_rectangle(
        pos_x + padding,
        pos_y + padding,
        pos_x + padding + (w - padding * 2) * perc,
        pos_y + h - padding,
        false
    );

    pos_y += h + espacamento;

    // ======================
    // ⚡ ENERGIA (SPRITE POR PORCENTAGEM)
    // ======================
    draw_set_color(c_white);
    draw_text(pos_x, pos_y, "ENERGIA");
    pos_y += 18;

    // Escolhe o sprite baseado na energia atual (com suavização)
    var perc_energia = player.energia_draw / player.energia_max;
    var spr_energia;

    if (perc_energia <= 0.0) {
        spr_energia = sEnergia0;
    } else if (perc_energia <= 0.2) {
        spr_energia = sEnergia20;
    } else if (perc_energia <= 0.4) {
        spr_energia = sEnergia40;
    } else if (perc_energia <= 0.6) {
        spr_energia = sEnergia60;
    } else if (perc_energia <= 0.8) {
        spr_energia = sEnergia80;
    } else {
        spr_energia = sEnergia100;
    }

    draw_sprite(spr_energia, 0, pos_x, pos_y);
    pos_y += sprite_get_height(spr_energia) + espacamento;
}