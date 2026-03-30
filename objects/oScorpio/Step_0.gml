// =======================
// ⏱️ TEMPO DE DANO (PRIMEIRO)
// =======================
if (tempo_dano > 0) {
    tempo_dano--;
}


// =======================
// 🎮 MOVIMENTO (INPUT)
// =======================

var mov = 0;

if (!transformando && tempo_dano <= 0) // 🔥 BLOQUEIA CONTROLE NO DANO
{
    if (keyboard_check(ord("D"))) mov = 1;
    if (keyboard_check(ord("A"))) mov = -1;
}


// =======================
// 🔄 TRANSFORMAÇÃO
// =======================

if (keyboard_check_pressed(ord("C")))
{
    if (estado == ESTADO_NORMAL)
    {
        estado = ESTADO_TRANSFORMANDO;
        transformando = true;

        sprite_index = sScorpio_Transformacao_Veiculo;
        image_index = 0;
        image_speed = 1;
    }
    else if (estado == ESTADO_VEICULO && mov == 0)
    {
        estado = ESTADO_TRANSFORMANDO;
        transformando = true;

        sprite_index = sScorpio_Transformacao_Veiculo;
        image_index = image_number - 1;
        image_speed = -1;
    }
}

if (estado == ESTADO_TRANSFORMANDO)
{
    rodando = false;
    mov = 0;

    if (image_speed > 0 && image_index >= image_number - 1)
    {
        estado = ESTADO_VEICULO;
        transformando = false;
    }

    if (image_speed < 0 && image_index <= 0)
    {
        estado = ESTADO_NORMAL;
        transformando = false;
    }
}


// =======================
// 🎬 SPRITES
// =======================

var no_chao = place_meeting(x, y + 2, oAreia) || place_meeting(x, y + 2, oRocks1);

if (!transformando)
{
    if (estado == ESTADO_VEICULO)
    {
        if (!no_chao) sprite_index = sScorpio_Pulando;
        else if (mov != 0) sprite_index = sScorpio_Rodando;
        else sprite_index = sScorpio_Parado;

        image_speed = 1;
    }
    else
    {
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
    }
}


// =======================
// 🚶 MOVIMENTO HORIZONTAL (COM KNOCKBACK)
// =======================

// 🔥 SOMA o knockback com o input
var h_total = mov * spd + hsp;

if (!place_meeting(x + h_total, y, oAreia) && 
    !place_meeting(x + h_total, y, oRocks1)) {
    
    x += h_total;
    
} else {
    while (!place_meeting(x + sign(h_total), y, oAreia) && 
           !place_meeting(x + sign(h_total), y, oRocks1)) {
        x += sign(h_total);
    }
}

// direção do sprite
if (mov != 0) {
    image_xscale = sign(mov);
}


// =======================
// 🌍 GRAVIDADE
// =======================

vsp += grav;
vsp = clamp(vsp, -100, 10);


// =======================
// 🦘 PULO
// =======================

if (no_chao && !transformando && tempo_dano <= 0) {
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
// 💥 ATRITO DO KNOCKBACK
// =======================

hsp *= 0.85; // desacelera empurrão


// =======================
// 🔋 ENERGIA
// =======================

var pegou_bateria = false;
var bat = instance_place(x, y, oBateria);

if (bat != noone) {
    energia = energia_max;
    pegou_bateria = true;
    instance_destroy(bat);
}

if (!pegou_bateria && mov != 0) {
    energia -= energia_decay;
}

energia = clamp(energia, 0, energia_max);


// =======================
// ⚡ VELOCIDADE
// =======================

spd = (energia <= 0) ? 2 : 6;


// =======================
// 🗑️ ITENS
// =======================

var item;

item = instance_place(x, y, oLatinha);
if (item != noone) instance_destroy(item);

item = instance_place(x, y, oSacodeLixo);
if (item != noone) instance_destroy(item);

item = instance_place(x, y, oBanana);
if (item != noone) instance_destroy(item);


// =======================
// 💀 MORTE
// =======================

if (estrutura.esta_morto()) {
    show_message("Você morreu!");
    instance_destroy();
}