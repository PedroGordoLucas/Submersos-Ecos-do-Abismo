// =======================
// ⏱️ TEMPO DE DANO (PRIMEIRO)
// =======================
if (tempo_dano > 0) {
    tempo_dano--;
}


// =======================
// 🎮 MOVIMENTO (INPUT)
// =======================

mov = 0;

if (estado != ESTADO_TRANSFORMANDO && tempo_dano <= 0)
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

        sprite_index = sScorpio_Transformacao_Veiculo;
        image_index = 0;
        image_speed = 1;
    }
    else if (estado == ESTADO_VEICULO && abs(hsp) < 0.1)
    {
        estado = ESTADO_TRANSFORMANDO;

        sprite_index = sScorpio_Transformacao_Veiculo;
        image_index = image_number - 1;
        image_speed = -1;
    }
}


// =======================
// 🔒 TRANSFORMAÇÃO (UNIFICADO)
// =======================

if (estado == ESTADO_TRANSFORMANDO)
{
    rodando = false;
    mov = 0;

    if (image_speed > 0 && image_index >= image_number - 1 - 0.1)
    {
        estado = ESTADO_VEICULO;
    }

    if (image_speed < 0 && image_index <= 0.1)
    {
        estado = ESTADO_NORMAL;
    }

    exit; // 🔥 trava TODO resto do Step
}


// =======================
// 🎬 SPRITES
// =======================

var no_chao = place_meeting(x, y + 2, oAreia) || place_meeting(x, y + 2, oRocks1);

if (estado != ESTADO_TRANSFORMANDO)
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
// ⚡ VELOCIDADE (CORRIGIDO)
// =======================

if (estado == ESTADO_VEICULO)
{
    spd = (energia <= 0) ? 4 : 10;
}
else
{
    spd = (energia <= 0) ? 2 : 6;
}


// =======================
// 🚶 MOVIMENTO HORIZONTAL
// =======================

var h_total;

if (knockback_timer > 0) {
    h_total = hsp;
    knockback_timer--;
} else {
    h_total = mov * spd;
}

var passo = sign(h_total);
var restante = abs(h_total);

while (restante > 0) {

    if (!place_meeting(x + passo, y, oAreia) && 
        !place_meeting(x + passo, y, oRocks1)) {
        
        x += passo;

    } 
    else if (!place_meeting(x + passo, y - 1, oAreia) && 
             !place_meeting(x + passo, y - 1, oRocks1)) {
        
        x += passo;
        y -= 1;
    }
    else {
        hsp = 0;
        break;
    }

    restante--;
}

if (mov != 0 && knockback_timer <= 0) {
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

if (no_chao && estado != ESTADO_TRANSFORMANDO && tempo_dano <= 0) {
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

hsp *= 0.85;


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