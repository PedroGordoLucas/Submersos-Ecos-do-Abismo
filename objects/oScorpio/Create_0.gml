spd = 4;
vsp = 0;
grav = 0.5;
jump_force = -10;

// ======================
// SISTEMA DE ENERGIA
// ======================
energia = 100;
energia_max = 100;

// Taxa de consumo
energia_decay = 0.4;

dash_timer_d = 0;
dash_timer_a = 0;
dash_delay = 15;

rodando = false;
dir_dash = 0;

// ======================
// ESTRUTURA (CORRIGIDA)
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