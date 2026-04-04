var player = instance_find(oScorpio, 0);

var pos_x = 20;
var pos_y = 20;

var largura = 200;
var altura = 20;
var espacamento = 10;

if (instance_exists(player)) {

    draw_set_color(c_white);

    // ======================
    // 🔋 ENERGIA
    // ======================
    draw_text(pos_x, pos_y, "Energia: " + string(player.energia));
    pos_y += 20;

    var energia_porcentagem = player.energia / player.energia_max;

    draw_set_color(c_red);
    draw_rectangle(pos_x, pos_y, pos_x + largura, pos_y + altura, false);

    draw_set_color(c_green);
    draw_rectangle(pos_x, pos_y, pos_x + (largura * energia_porcentagem), pos_y + altura, false);

    pos_y += altura + espacamento;

    // ======================
    // 🛡️ ESTRUTURA
    // ======================
    draw_set_color(c_white);
    draw_text(pos_x, pos_y, "Estrutura: " 
        + string(player.estrutura.atual) 
        + "/" 
        + string(player.estrutura.max));

    pos_y += 20;

    var estrutura_porcentagem = player.estrutura.atual / player.estrutura.max;

    draw_set_color(c_red);
    draw_rectangle(pos_x, pos_y, pos_x + largura, pos_y + altura, false);

    draw_set_color(c_blue);
    draw_rectangle(pos_x, pos_y, pos_x + (largura * estrutura_porcentagem), pos_y + altura, false);

    pos_y += altura + espacamento;

    // ======================
    // 🗑️ LIXO
    // ======================
    draw_set_color(c_white);
    draw_text(pos_x, pos_y, "Lixo coletado: " + string(global.lixo_coletado));

    pos_y += 30;

    // ======================
    // 🔧 DEBUG FERRAMENTA (OPCIONAL)
    // ======================
    draw_text(pos_x, pos_y, "Ferramenta: " + string(player.ferramenta_ativa));

    pos_y += 30;

    // ======================
    // 🤝 INTERAÇÃO COM CORAL
    // ======================
    var coral = instance_nearest(player.x, player.y, oCoral);

    if (coral != noone)
    {
        var dist = point_distance(player.x, player.y, coral.x, coral.y);

        if (dist < 40 && player.ferramenta_ativa)
        {
            draw_text(pos_x, pos_y, "Pressione E para interagir");
        }
    }
}