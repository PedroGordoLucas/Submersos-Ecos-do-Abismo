// ======================
// 🏃 FISICA E MOVIMENTO
// ======================
spd = 4;
vsp = 0;
hsp = 0; // Velocidade horizontal para knockback
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
rodando = false;

// ======================
// 🔧 SISTEMA DE FERRAMENTAS (NOVO)
// ======================
// 0 = Nenhuma, 1 = Injeção, 2 = Ruído
ferramenta_ativa = 0; 

// ======================
// 🔋 SISTEMA DE ENERGIA
// ======================
energia = 100;
energia_max = 100;
energia_decay = 0.1;

// ======================
// 💨 DASH
// ======================
dash_timer_d = 0;
dash_timer_a = 0;
dash_delay = 15;
dir_dash = 0;

// ======================
// 🛡️ ESTRUTURA (HP)
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

// ======================
// ⚔️ COMBATE E DANO
// ======================
tempo_dano = 0;
forca_knockback = 20;
knockback_timer = 0;

// ======================
// 🎭 MÁSCARA E COLISÃO
// ======================
// Define a colisão fixa para evitar bugs ao trocar sprites
mask_index = sScorpio_Parado;