var jogador = oScorpio;

// Segurança: se o jogador não existir, não faz nada
if (!instance_exists(jogador)) exit;

// =======================
// 👂 AUDIÇÃO SENSÍVEL (VERSÃO CORRIGIDA)
// =======================
var dist = point_distance(x, y, jogador.x, jogador.y);

// Usamos variable_instance_get para evitar erro caso o Scorpio ainda não tenha as variáveis
var v_mov        = variable_instance_exists(jogador, "mov") ? jogador.mov : 0;
var v_estado     = variable_instance_exists(jogador, "estado") ? jogador.estado : 0;
var v_ferramenta = variable_instance_exists(jogador, "ferramenta_ativa") ? jogador.ferramenta_ativa : false;

// Ela ouve: Movimento, Estado de Veículo (2) ou Ferramenta ativa
var fazendo_barulho = (v_mov != 0) || (v_estado == 2) || (v_ferramenta);

if (dist <= raio_audicao && fazendo_barulho) {
    alerta = true;
    alerta_timer = alerta_duracao;
} else {
    if (alerta_timer > 0) {
        alerta_timer--;
    } else {
        alerta = false;
    }
}

// =======================
// 🔄 MÁQUINA DE ESTADOS
// =======================
tempo_nado += frequencia_nado;
var oscilacao = sin(tempo_nado) * amplitude_nado;

switch (estado) {
    case 0: // PATRULHA CALMA
        hsp = dir_x * spd_patrulha;
        vsp = oscilacao; // Nado ondulado
        
        // Inverte direção na patrulha ou ao bater em paredes
        if (abs(x - x_origem) > dist_patrulha || place_meeting(x + hsp, y, oAreia) || place_meeting(x + hsp, y, oRocks1)) {
            dir_x *= -1;
        }
        if (alerta) estado = 1;
        break;

    case 1: // PERSEGUIÇÃO (ALERTA)
        var dir_player = point_direction(x, y, jogador.x, jogador.y);
        hsp = lengthdir_x(spd_persegue, dir_player);
        vsp = lengthdir_y(spd_persegue, dir_player) + oscilacao;
        
        dir_x = (jogador.x > x) ? 1 : -1;

        if (dist <= raio_ataque) estado = 2;
        
        if (!alerta) {
            estado = 0;
            x_origem = x; // Reseta a patrulha onde ela desistiu
        }
        break;

    case 2: // ATAQUE DE CAUDA
        // Desacelera para atacar
        hsp = lerp(hsp, 0, 0.1);
        vsp = lerp(vsp, 0, 0.1);
        ataque_timer++;

        if (ataque_timer >= ataque_delay && !dano_aplicado) {
            dano_aplicado = true;
            if (dist <= raio_ataque + 10) {
                with (jogador) {
                    if (tempo_dano <= 0) {
                        estrutura.tomar_dano(other.dano_cauda);
                        tempo_dano = 30;
                        
                        // Knockback clássico do seu projeto
                        var kb_dir = sign(x - other.x);
                        if (kb_dir == 0) kb_dir = 1;
                        hsp = kb_dir * 8;
                        vsp = -3;
                        knockback_timer = 10;
                    }
                }
            }
        }

        if (ataque_timer >= ataque_delay + 15) {
            ataque_timer = 0;
            dano_aplicado = false;
            estado = 1; // Volta a perseguir após o golpe
        }
        break;
}

// =======================
// 🧱 COLISÃO (PADRÃO SCORPIO)
// =======================
// Horizontal
if (place_meeting(x + hsp, y, oAreia) || place_meeting(x + hsp, y, oRocks1)) {
    while (!place_meeting(x + sign(hsp), y, oAreia) && !place_meeting(x + sign(hsp), y, oRocks1)) {
        x += sign(hsp);
    }
    hsp = 0;
}
x += hsp;

// Vertical
if (place_meeting(x, y + vsp, oAreia) || place_meeting(x, y + vsp, oRocks1)) {
    while (!place_meeting(x, y + sign(vsp), oAreia) && !place_meeting(x, y + sign(vsp), oRocks1)) {
        y += sign(vsp);
    }
    vsp = 0;
}
y += vsp;

// Atualiza a direção da sprite
image_xscale = dir_x;