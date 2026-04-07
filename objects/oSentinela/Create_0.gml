// =======================
// 🤖 SENTINELA — CREATE
// =======================
// --- Física ---
vsp = 0;
hsp = 0;
grav = 0.3;          // pesado, afunda devagar
spd = 1.2;           // lento, robô submerso
// --- Vida ---
vida = 60;
vida_max = 60;
// --- Detecção ---
raio_deteccao = 500;  // alcance para ouvir o jogador
raio_seguir   = 450;  // distância para começar a andar
alerta        = false;
alerta_timer  = 0;    // contador regressivo
alerta_duracao = 180; // frames que mantém o alerta (~3 segundos)
// --- Ataque com broca ---
raio_ataque     = 40;
ataque_delay    = 50;
ataque_timer    = 0;
atacando        = false;
dano_aplicado   = false;
dano_broca      = 18;
// --- Knockback aplicado ao jogador ---
forca_kb = 6;
// --- Direção ---
dir_x = 1;
// --- Estado interno ---
// 0 = parado  1 = alerta/perseguindo  2 = atacando
estado = 0;
// --- Patrulha ---
patrol_dist  = 80;
patrol_orig  = x;
patrol_dir   = 1;