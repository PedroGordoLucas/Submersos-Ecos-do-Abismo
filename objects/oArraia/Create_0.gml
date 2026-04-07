// --- Física e Nado ---
hsp = 0;
vsp = 0;
spd_patrulha = 1.0;
spd_persegue = 3.2;

// --- Efeito de Nado (Senoide) ---
tempo_nado = 0;
amplitude_nado = 0.8; 
frequencia_nado = 0.05;

// --- Vida ---
vida = 45;
vida_max = 45;

// --- Detecção (Baseada no Scorpio) ---
raio_audicao = 400;
alerta = false;
alerta_timer = 0;
alerta_duracao = 150; 

// --- Ataque de Cauda ---
raio_ataque = 60;
ataque_delay = 45;
ataque_timer = 0;
dano_cauda = 14;
dano_aplicado = false;

// --- Estados ---
// 0 = Patrulha (Nado) | 1 = Alerta (Persegue) | 2 = Ataque (Chicotada)
estado = 0;
dir_x = 1;
dist_patrulha = 120;
x_origem = x;