// =======================
// 🚗 DOUBLE TAP (FRENTE E TRÁS)
// =======================

// DOUBLE TAP DIREITA (D)
if (keyboard_check_pressed(ord("D"))) {
    
    if (dash_timer_d > 0) {
        rodando = true;
        dir_dash = 1;
    }
    
    dash_timer_d = dash_delay;
}

// DOUBLE TAP ESQUERDA (A)
if (keyboard_check_pressed(ord("A"))) {
    
    if (dash_timer_a > 0) {
        rodando = true;
        dir_dash = -1;
    }
    
    dash_timer_a = dash_delay;
}

// Contadores
if (dash_timer_d > 0) dash_timer_d--;
if (dash_timer_a > 0) dash_timer_a--;

// Para de rodar ao soltar tecla
if ((dir_dash == 1 && !keyboard_check(ord("D"))) ||
    (dir_dash == -1 && !keyboard_check(ord("A")))) {
    
    rodando = false;
}


// =======================
// Movimento horizontal
// =======================

var mov = 0;

if (rodando) {
    mov = dir_dash;
}
else {
    if (keyboard_check(ord("D"))) {
        mov = 1;
    }
    if (keyboard_check(ord("A"))) {
        mov = -1;
    }
}


// =======================
// 🎬 SPRITES
// =======================

var no_chao = place_meeting(x, y + 2, oAreia) || place_meeting(x, y + 2, oRocks1);

if (!no_chao) {
    sprite_index = sScorpio_Pulando;
    image_speed = 1;
}
else if (rodando) {
    sprite_index = sScorpio_Rodando;
    image_speed = 1;
}
else if (mov != 0) {
    sprite_index = sScorpio_Caminhando;
    image_speed = 1;
}
else {
    sprite_index = sScorpio_Parado;
    image_speed = 0;
    image_index = 0;
}


// =======================
// 🚶 MOVIMENTO HORIZONTAL
// =======================

if (!place_meeting(x + mov * spd, y, oAreia) && 
    !place_meeting(x + mov * spd, y, oRocks1)) {
    
    x += mov * spd;
    
} else {
    while (!place_meeting(x + sign(mov), y, oAreia) && 
           !place_meeting(x + sign(mov), y, oRocks1)) {
        x += sign(mov);
    }
}


// Inverte sprite
if (mov != 0) {
    image_xscale = sign(mov);
}


// =======================
// 🌍 GRAVIDADE
// =======================

vsp += grav;

if (vsp > 10) vsp = 10;


// =======================
// 🦘 PULO
// =======================

if (place_meeting(x, y + 2, oAreia) || place_meeting(x, y + 2, oRocks1)) {
    if (keyboard_check_pressed(ord("W"))) {
        vsp = jump_force;
    }
}


// =======================
// ⬇️ COLISÃO VERTICAL
// =======================

if (place_meeting(x, y + vsp, oAreia) || 
    place_meeting(x, y + vsp, oRocks1)) {

    while (!place_meeting(x, y + sign(vsp), oAreia) && 
           !place_meeting(x, y + sign(vsp), oRocks1)) {
        y += sign(vsp);
    }
    vsp = 0;
}
else {
    y += vsp;
}


// =======================
// 🔋 SISTEMA DE ENERGIA
// =======================

var bat = instance_place(x, y, oBateria);
var pegou_bateria = false;

if (bat != noone) {
    energia = energia_max;
    pegou_bateria = true;
    instance_destroy(bat);
}

if (!pegou_bateria) {
    if (mov != 0) {
        energia -= energia_decay;
    }
}

energia = clamp(energia, 0, energia_max);


// =======================
// ⚡ VELOCIDADE
// =======================

if (energia <= 0) {
    spd = 2;
}
else {
    if (rodando) {
        spd = 10;
    } else {
        spd = 6;
    }
}


// =======================
// 🗑️ COLETA DE ITENS
// =======================

var latinha = instance_place(x, y, oLatinha);
if (latinha != noone) {
    instance_destroy(latinha);
}

var lixo = instance_place(x, y, oSacodeLixo);
if (lixo != noone) {
    instance_destroy(lixo);
}

var banana = instance_place(x, y, oBanana);
if (banana != noone) {
    instance_destroy(banana);
}