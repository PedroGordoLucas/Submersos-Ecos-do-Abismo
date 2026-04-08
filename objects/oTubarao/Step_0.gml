var jogador = oScorpio;
if (!instance_exists(jogador)) exit;

// =======================
// 👂 DETECÇÃO DE BARULHO
// =======================
var dist = point_distance(x, y, jogador.x, jogador.y);

var v_mov        = variable_instance_exists(jogador, "mov")              ? jogador.mov              : 0;
var v_estado     = variable_instance_exists(jogador, "estado")           ? jogador.estado           : 0;
var v_ferramenta = variable_instance_exists(jogador, "ferramenta_ativa") ? jogador.ferramenta_ativa : 0;

var fazendo_barulho = (v_mov != 0) || (v_estado == 2) || (v_ferramenta != 0);

// Ativa o alerta ao ouvir barulho
if (dist <= raio_audicao && fazendo_barulho) {
    alerta       = true;
    alerta_timer = alerta_duracao;
}

// Timer regride independente — só esquece quando zerar
if (alerta_timer > 0) {
    alerta_timer--;
} else {
    alerta = false;
}

// =======================
// 🌊 SENOIDE DE NADO
// =======================
tempo_nado += frequencia_nado;
var oscilacao = sin(tempo_nado) * amplitude_nado;

// =======================
// 🔊 DETECÇÃO DE PULSO DE RUÍDO
// =======================
var pulso = instance_nearest(x, y, oRuidoPulso);
if (pulso != noone) {
    var dist_pulso = point_distance(x, y, pulso.x, pulso.y);
    if (dist_pulso <= pulso.raio) {
        if (estado != 4) {
            estado     = 4;
            fuga_timer = fuga_duracao;
        }
    }
}

// =======================
// 🔄 MÁQUINA DE ESTADOS
// =======================
switch (estado) {

    // -----------------------
    case 0: // PATRULHA CALMA
    // -----------------------
        hsp = dir_x * spd_patrulha;
        vsp = oscilacao;

        if (abs(x - x_origem) > dist_patrulha
        ||  place_meeting(x + hsp, y, oAreia)
        ||  place_meeting(x + hsp, y, oRocks1)) {
            dir_x *= -1;
        }

        if (alerta) estado = 1;
    break;

    // -----------------------
    case 1: // ALERTA — nada em direção ao jogador
    // -----------------------
        var ang = point_direction(x, y, jogador.x, jogador.y);
        hsp = lengthdir_x(spd_alerta, ang) + oscilacao * 0.5;
        vsp = lengthdir_y(spd_alerta, ang) + oscilacao;

        dir_x = (jogador.x > x) ? 1 : -1;

        if (dist <= raio_investida) {
            estado          = 2;
            investindo      = true;
            dano_aplicado   = false; // ✅ reset ao iniciar investida
            investida_timer = 0;

            var ang_inv     = point_direction(x, y, jogador.x, jogador.y);
            investida_dir_x = lengthdir_x(spd_investida, ang_inv);
            investida_dir_y = lengthdir_y(spd_investida, ang_inv);
        }

        if (!alerta) {
            estado   = 0;
            x_origem = x;
        }
    break;

    // -----------------------
    case 2: // INVESTIDA DIRETA
    // -----------------------
        hsp = investida_dir_x;
        vsp = investida_dir_y + oscilacao * 0.3;

        investida_timer++;

        if (!dano_aplicado && dist <= raio_ataque) {
            dano_aplicado = true;
            var _dano = dano_mordida; // ✅ captura antes do with
            var _kb   = 10;
            with (jogador) {
                if (tempo_dano <= 0) {
                    estrutura.tomar_dano(_dano);
                    tempo_dano = 30;

                    var kb_dir = sign(x - other.x);
                    if (kb_dir == 0) kb_dir = 1;
                    hsp             = kb_dir * _kb;
                    vsp             = -4;
                    knockback_timer = 12;
                }
            }
        }

        var bateu_parede = place_meeting(x + hsp, y, oAreia)
                        || place_meeting(x + hsp, y, oRocks1)
                        || place_meeting(x, y + vsp, oAreia)
                        || place_meeting(x, y + vsp, oRocks1);

        if (investida_timer >= investida_duracao || bateu_parede) {
            investindo     = false;
            estado         = 3;
            cooldown_timer = cooldown_duracao;
        }
    break;

    // -----------------------
    case 3: // COOLDOWN — recua devagar
    // -----------------------
        hsp = lerp(hsp, -dir_x * spd_patrulha, 0.08);
        vsp = lerp(vsp, oscilacao, 0.1);

        cooldown_timer--;
        if (cooldown_timer <= 0) {
            dano_aplicado   = false; // ✅ reset ao sair do cooldown
            investida_timer = 0;     // ✅ reset do timer
            estado = alerta ? 1 : 0;
            if (!alerta) x_origem = x;
        }
    break;

    // -----------------------
    case 4: // FUGA — afasta do jogador
    // -----------------------
        var ang_fuga = point_direction(x, y, jogador.x, jogador.y) + 180;
        hsp = lerp(hsp, lengthdir_x(fuga_spd, ang_fuga), 0.15);
        vsp = lerp(vsp, lengthdir_y(fuga_spd, ang_fuga) + oscilacao, 0.15);

        dir_x = (jogador.x > x) ? -1 : 1;

        fuga_timer--;
        if (fuga_timer <= 0) {
            dano_aplicado   = false; // ✅ reset ao sair da fuga também
            investida_timer = 0;
            estado   = 0;
            x_origem = x;
        }
    break;
}

// =======================
// 🧱 COLISÃO
// =======================
if (place_meeting(x + hsp, y, oAreia) || place_meeting(x + hsp, y, oRocks1)) {
    while (!place_meeting(x + sign(hsp), y, oAreia)
        && !place_meeting(x + sign(hsp), y, oRocks1)) {
        x += sign(hsp);
    }
    hsp = 0;
}
x += hsp;

if (place_meeting(x, y + vsp, oAreia) || place_meeting(x, y + vsp, oRocks1)) {
    while (!place_meeting(x, y + sign(vsp), oAreia)
        && !place_meeting(x, y + sign(vsp), oRocks1)) {
        y += sign(vsp);
    }
    vsp = 0;
}
y += vsp;

image_xscale = dir_x;