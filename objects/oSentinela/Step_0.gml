// =======================
// 🤖 SENTINELA — STEP
// =======================
var jogador = oScorpio;

// segurança: se o jogador não existir, não faz nada
if (!instance_exists(jogador)) exit;

var no_chao = place_meeting(x, y + 1, oAreia) || place_meeting(x, y + 1, oRocks1);
 

// =======================
// 👂 DETECÇÃO DE BARULHO
// =======================
var dist = point_distance(x, y, jogador.x, jogador.y);
var jogador_fazendo_barulho = (jogador.mov != 0)
    || (jogador.estado == jogador.ESTADO_VEICULO)
    || (jogador.ferramenta_ativa);

if (dist <= raio_deteccao && jogador_fazendo_barulho) {
    alerta = true;
    alerta_timer = alerta_duracao;  // reinicia o timer toda vez que ouve
} else {
    if (alerta_timer > 0) {
        alerta_timer--;
    } else {
        alerta = false;  // só esquece depois que o timer zerar
    }
}

// =======================
// 🔄 MÁQUINA DE ESTADOS
// =======================

// --- ESTADO 0: PARADO (aguardando) ---
if (estado == 0) {
    atacando = false;
    ataque_timer = 0;
    dano_aplicado = false;

    if (alerta) {
        estado = 1;
    }
    // não faz mais nada — fica completamente parado
}

// --- ESTADO 1: ALERTA (ouviu, mas parado até o jogador chegar perto) ---
else if (estado == 1) {
    atacando = false;
    ataque_timer = 0;
    dano_aplicado = false;

    if (!alerta) {
        estado = 0;
    } else if (dist <= raio_ataque) {
        estado = 2;
    } else if (dist <= raio_seguir) {
        // jogador entrou no raio de seguir — anda em direção a ele
        var dir_para = sign(jogador.x - x);
        var move_x = dir_para * spd;

        if (!place_meeting(x + move_x, y, oAreia) &&
            !place_meeting(x + move_x, y, oRocks1)) {
            x += move_x;
        }

        dir_x = dir_para;
    } else {
        // ouviu mas jogador ainda está longe — fica parado, só olha
        dir_x = sign(jogador.x - x);
    }
}

// --- ESTADO 2: ATACANDO (broca) ---
else if (estado == 2) {
    atacando = true;

    if (dist > raio_ataque + 20) {
        estado = 1;
        atacando = false;
        ataque_timer = 0;
        dano_aplicado = false;
    } else {
        ataque_timer++;

        if (ataque_timer >= ataque_delay && !dano_aplicado) {
            dano_aplicado = true;

            with (jogador) {
                if (tempo_dano <= 0) {
                    estrutura.tomar_dano(other.dano_broca);
                    tempo_dano = 40;

                    var kb_dir = sign(x - other.x);
                    if (kb_dir == 0) kb_dir = 1;
                    hsp = kb_dir * other.forca_kb;
                    vsp = -4;
                    knockback_timer = 12;
                }
            }
        }

        if (ataque_timer >= ataque_delay + 20) {
            ataque_timer = 0;
            dano_aplicado = false;
        }
    }
}

// =======================
// 🌍 GRAVIDADE
// =======================
vsp += grav;
vsp = clamp(vsp, -20, 6);

// =======================
// ⬇️ COLISÃO VERTICAL
// =======================
var passo_v = sign(vsp);
var restante_v = abs(vsp);

repeat (restante_v) {
    if (!place_meeting(x, y + passo_v, oAreia) &&
        !place_meeting(x, y + passo_v, oRocks1)) {
        y += passo_v;
    } else {
        vsp = 0;
        break;
    }
}

// =======================
// 🪞 ESPELHAR SPRITE
// =======================
image_xscale = dir_x;