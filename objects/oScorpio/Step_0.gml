// Movimento horizontal
var mov = 0;

if (keyboard_check(ord("D"))) {
    mov = 1;
}

if (keyboard_check(ord("A"))) {
    mov = -1;
}


// Colisão horizontal
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


// Gravidade
vsp += grav;


// Pulo (areia OU pedra)
if (place_meeting(x, y + 1, oAreia) || place_meeting(x, y + 1, oRocks1)) {
    if (keyboard_check_pressed(ord("W"))) {
        vsp = jump_force;
    }
}


// Colisão vertical
if (!place_meeting(x, y + vsp, oAreia) && 
    !place_meeting(x, y + vsp, oRocks1)) {
    
    y += vsp;
    
} else {
    while (!place_meeting(x, y + sign(vsp), oAreia) && 
           !place_meeting(x, y + sign(vsp), oRocks1)) {
        y += sign(vsp);
    }
    vsp = 0;
}


// =======================
// 🔋 SISTEMA DE ENERGIA
// =======================

// Detecta bateria
var bat = instance_place(x, y, oBateria);
var pegou_bateria = false;

if (bat != noone) {
    energia = energia_max; // enche totalmente
    pegou_bateria = true;
    
    instance_destroy(bat);
}


// Consumo de energia (só se NÃO pegou bateria)
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

// Coleta de itens (somem ao encostar)

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