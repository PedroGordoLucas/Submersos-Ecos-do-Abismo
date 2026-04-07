var player = instance_find(oScorpio, 0);

if (instance_exists(player)) {

    var margin = 20;
    var largura = 200;
    var altura = 20;
    var espacamento = 15;

    // =========================
    // 🔲 FUNDO HUD (CAIXA)
    // =========================
    var box_x = margin - 10;
    var box_y = margin - 10;
    var box_w = largura + 20;
    var box_h = 140;

    draw_set_color(make_color_rgb(20, 20, 20));
    draw_rectangle(box_x, box_y, box_x + box_w, box_y + box_h, false);

    draw_set_color(c_white);
    draw_rectangle(box_x, box_y, box_x + box_w, box_y + box_h, true);

    var pos_x = margin;
    var pos_y = margin;

    draw_set_font(-1);
    draw_set_color(c_white);

    // ======================
    // 🔋 ENERGIA
    // ======================
    draw_text(pos_x, pos_y, "ENERGIA");
    pos_y += 18;

    var energia_porcentagem = player.energia_draw / player.energia_max;

    var cor_energia = c_green;
    if (energia_porcentagem < 0.6) cor_energia = c_yellow;
    if (energia_porcentagem < 0.3) cor_energia = c_red;

    // fundo
    draw_set_color(make_color_rgb(40, 40, 40));
    draw_rectangle(pos_x, pos_y, pos_x + largura, pos_y + altura, false);

    // barra
    draw_set_color(cor_energia);
    draw_rectangle(pos_x, pos_y, pos_x + (largura * energia_porcentagem), pos_y + altura, false);

    // borda
    draw_set_color(c_white);
    draw_rectangle(pos_x, pos_y, pos_x + largura, pos_y + altura, true);

    pos_y += altura + espacamento;

    // ======================
    // 🛡️ ESTRUTURA
    // ======================
    draw_set_color(c_white);
    draw_text(pos_x, pos_y, "ESTRUTURA");
    pos_y += 18;

    var estrutura_porcentagem = player.estrutura_draw / player.estrutura.max;

    var cor_estrutura = make_color_rgb(0, 180, 255);

    if (estrutura_porcentagem < 0.6) cor_estrutura = c_yellow;
    if (estrutura_porcentagem < 0.3) cor_estrutura = c_red;

    // fundo
    draw_set_color(make_color_rgb(40, 40, 40));
    draw_rectangle(pos_x, pos_y, pos_x + largura, pos_y + altura, false);

    // barra
    draw_set_color(cor_estrutura);
    draw_rectangle(pos_x, pos_y, pos_x + (largura * estrutura_porcentagem), pos_y + altura, false);

    // borda
    draw_set_color(c_white);
    draw_rectangle(pos_x, pos_y, pos_x + largura, pos_y + altura, true);

    // ======================
    // 📊 INFO DIREITA (LOGS / DISTÂNCIA)
    // ======================
    var right_x = display_get_gui_width() - 180;

    draw_set_color(c_white);
    draw_text(right_x, 20, "LOGS: " + string(global.lixo_coletado) + "/5");
    draw_text(right_x, 40, "DIST: " + string(round(point_distance(0,0,player.x,player.y))) + "m");

    // ======================
    // ⚠️ INTERAÇÃO CENTRAL
    // ======================
    var coral = instance_nearest(player.x, player.y, oCoral);

    if (coral != noone)
    {
        var dist = point_distance(player.x, player.y, coral.x, coral.y);

        if (dist < 40 && player.ferramenta_ativa)
        {
            draw_set_color(c_white);
            draw_text(display_get_gui_width()/2 - 60, display_get_gui_height() - 60, "PRESSIONE E");
        }
    }

    // ======================
    // 🎒 SLOTS (BASE ESQUERDA)
    // ======================
    var slot_y = display_get_gui_height() - 80;

    for (var i = 0; i < 3; i++) {

        var sx = margin + i * 70;

        draw_set_color(make_color_rgb(30,30,30));
        draw_rectangle(sx, slot_y, sx + 60, slot_y + 60, false);

        draw_set_color(c_white);
        draw_rectangle(sx, slot_y, sx + 60, slot_y + 60, true);

        draw_text(sx + 25, slot_y + 20, "1");
    }

    // ======================
    // 🔊 RUÍDO (BASE DIREITA)
    // ======================
    var noise_x = display_get_gui_width() - 200;
    var noise_y = display_get_gui_height() - 100;

    draw_set_color(c_white);
    draw_text(noise_x, noise_y, "RUÍDO");

    for (var i = 0; i < 12; i++) {
        var h = random(40);

        draw_set_color(make_color_rgb(0,200,100));
        draw_rectangle(noise_x + i*10, noise_y + 60, noise_x + i*10 + 6, noise_y + 60 - h, false);
    }
}