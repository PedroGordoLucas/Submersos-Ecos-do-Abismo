// =======================
// 🎨 SENTINELA — DRAW (DEBUG TEMPORÁRIO)
// =======================

// Desenha o bloco
draw_self();

// Cor do estado
var cor;
switch (estado) {
    case 0: cor = c_gray;   break;  // patrulha
    case 1: cor = c_yellow; break;  // alerta
    case 2: cor = c_red;    break;  // atacando
}

// Barra de vida
draw_set_color(c_red);
draw_rectangle(x - 20, y - 28, x + 20, y - 22, false);
draw_set_color(c_lime);
draw_rectangle(x - 20, y - 28, x - 20 + (40 * (vida / vida_max)), y - 22, false);

// Label do estado
draw_set_color(cor);
draw_set_halign(fa_center);
var label;
if (estado == 0) label = "PATRULHA";
else if (estado == 1) label = "ALERTA";
else label = "ATACANDO";
draw_text(x, y - 40, label);

// Raio de detecção (círculo fino)
draw_set_alpha(0.15);
draw_set_color(c_yellow);
draw_circle(x, y, raio_deteccao, false);

// Raio de ataque
draw_set_color(c_red);
draw_circle(x, y, raio_ataque, false);

draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);