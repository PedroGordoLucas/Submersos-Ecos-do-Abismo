draw_self();

// Barra de Vida
var pc = (vida / vida_max) * 100;
draw_healthbar(x - 20, y - 35, x + 20, y - 30, pc, c_black, c_red, c_lime, 0, true, true);

// Feedback Visual de Som
if (alerta) {
    draw_set_color(c_orange);
    draw_text(x, y - 50, "OUVI ALGO!");
    
    // Desenha linha até o jogador para debug
    draw_set_alpha(0.3);
    draw_line(x, y, oScorpio.x, oScorpio.y);
    draw_set_alpha(1);
}

// Visualização do Raio de Som (Círculo azul para água)
draw_set_alpha(0.1);
draw_set_color(c_aqua);
draw_circle(x, y, raio_audicao, false);
draw_set_alpha(1);