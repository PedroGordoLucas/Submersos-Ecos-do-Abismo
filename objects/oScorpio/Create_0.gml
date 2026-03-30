spd = 4;
vsp = 0;
grav = 0.5;
jump_force = -10;

// ======================
// 🔄 SISTEMA DE ESTADOS
// ======================
ESTADO_NORMAL = 0;
ESTADO_TRANSFORMANDO = 1;
ESTADO_VEICULO = 2;

estado = ESTADO_NORMAL;
transformando = false;

// ======================
// SISTEMA DE ENERGIA
// ======================
energia = 100;
energia_max = 100;
energia_decay = 0.1;

// ======================
// DASH
// ======================
dash_timer_d = 0;
dash_timer_a = 0;
dash_delay = 15;

rodando = false;
dir_dash = 0;

// ======================
// ESTRUTURA
// ======================
estrutura = {
    atual: 100,
    max: 100,

    tomar_dano: function(valor) {
        atual -= valor;
        if (atual < 0) atual = 0;
    },

    curar: function(valor) {
        atual += valor;
        if (atual > max) atual = max;
    },

    esta_morto: function() {
        return atual <= 0;
    }
};

//tempo de dano
tempo_dano = 0;

//knockback de dano
hsp = 0; // velocidade horizontal
vsp = 0; // velocidade vertical

tempo_dano = 0;
forca_knockback = 20;