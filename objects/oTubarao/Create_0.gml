// --- Referência ao jogador ---
var jogador = oScorpio;

// --- Física e Nado ---
hsp = 0;
vsp = 0;
spd_patrulha  = 1.8;
spd_alerta    = 3.5;
spd_investida = 7.0;

// --- Efeito de Nado (Senoide) ---
tempo_nado      = 0;
amplitude_nado  = 0.8;
frequencia_nado = 0.05;

// --- Vida ---
vida     = 70;
vida_max = 70;

// --- Detecção por Proximidade ---
raio_audicao   = 420;
alerta         = false;
alerta_timer   = 0;
alerta_duracao = 160;

// --- Investida ---
raio_investida    = 200;
raio_ataque       = 80;
dano_mordida      = 20;
dano_aplicado     = false;
investindo        = false;
investida_dir_x   = 0;
investida_dir_y   = 0;
investida_timer   = 0;
investida_duracao = 60;

// --- Cooldown pós-ataque ---
cooldown_timer   = 0;
cooldown_duracao = 90;

// --- Direção de sprite ---
dir_x = 1;

// --- Estados ---
// 0 = Patrulha | 1 = Alerta | 2 = Investida | 3 = Cooldown
estado = 0;

// --- Patrulha ---
dist_patrulha = 140;
x_origem      = x;

// Fuga por ruído
fuga_timer    = 0;
fuga_duracao  = 120; // 4 segundos fugindo — ajuste à vontade
fuga_spd      = 5;   // velocidade de fuga