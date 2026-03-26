// Draw GUI

var player = instance_find(oScorpio, 0);

if (instance_exists(player)) {

    // ======================
    // TEXTO
    // ======================
    draw_set_color(c_white);

    draw_text(20, 20, "Energia: " + string(player.energia));
    draw_text(20, 40, "Estrutura: " 
        + string(player.estrutura.atual) 
        + "/" 
        + string(player.estrutura.max));

    // ======================
    // BARRA DE ENERGIA
    // ======================
    var largura = 200;
    var altura = 20;

    var energia_porcentagem = player.energia / 100;

    draw_set_color(c_red);
    draw_rectangle(20, 70, 20 + largura, 70 + altura, false);

    draw_set_color(c_green);
    draw_rectangle(20, 70, 20 + (largura * energia_porcentagem), 70 + altura, false);

    // ======================
    // BARRA DE ESTRUTURA
    // ======================
    var estrutura_porcentagem = player.estrutura.atual / player.estrutura.max;

    draw_set_color(c_red);
    draw_rectangle(20, 100, 20 + largura, 100 + altura, false);

    draw_set_color(c_blue);
    draw_rectangle(20, 100, 20 + (largura * estrutura_porcentagem), 100 + altura, false);
}