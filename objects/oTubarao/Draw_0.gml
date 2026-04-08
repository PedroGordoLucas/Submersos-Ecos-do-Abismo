draw_self();

// Barra de vida
var pc = (vida / vida_max) * 100;
draw_healthbar(x - 25, y - 40, x + 25, y - 35, pc, c_black, c_red, c_lime, 0, true, true);

// Ícone de alerta
if (alerta) {
    draw_set_color(c_red);
    draw_text(x, y - 55, "!");
    draw_set_color(c_white);
}

// Debug: raio de audição (pode remover depois)
draw_set_alpha(0.08);
draw_set_color(c_aqua);
draw_circle(x, y, raio_audicao, false);
draw_set_alpha(1);