// Movimento horizontal
var mov = 0;

if (keyboard_check(ord("D"))) {
    mov = 1;
}

if (keyboard_check(ord("A"))) {
    mov = -1;
}


// =======================
// 🎬 SPRITES
// =======================

// Verifica se está no chão (CORRIGIDO)
var no_chao = place_meeting(x, y + 2, oAreia) || place_meeting(x, y + 2, oRocks1);

// Define sprite
if (!no_chao) {
    sprite_index = sScorpio_Pulando;
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

// 🔥 LIMITADOR DE QUEDA (EVITA ATRAVESSAR O CHÃO)
if (vsp > 10) vsp = 10;


// =======================
// 🦘 PULO
// =======================

if (no_chao) {
    if (keyboard_check_pressed(ord("W"))) {
        vsp = jump_force;
    }
}


// =======================
// ⬇️ COLISÃO VERTICAL (CORRIGIDA)
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

// Detecta bateria
var bat = instance_place(x, y, oBateria);
var pegou_bateria = false;

if (bat != noone) {
    energia = energia_max;
    pegou_bateria = true;
    instance_destroy(bat);
}


// Consumo de energia
if (!pegou_bateria) {
    if (mov != 0) {
        energia -= energia_decay;
    }
}


// Limite de energia
energia = clamp(energia, 0, energia_max);


// Controle de velocidade
if (energia <= 0) {
    spd = 0;
} else {
    spd = 4;
}


// =======================
// 🗑️ COLETA DE ITENS
// =======================

// Latinha
var latinha = instance_place(x, y, oLatinha);
if (latinha != noone) {
    instance_destroy(latinha);
}

// Saco de lixo
var lixo = instance_place(x, y, oSacodeLixo);
if (lixo != noone) {
    instance_destroy(lixo);
}

// Banana
var banana = instance_place(x, y, oBanana);
if (banana != noone) {
    instance_destroy(banana);
}