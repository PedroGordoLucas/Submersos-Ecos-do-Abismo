if (other.tempo_dano <= 0) {

    // ==========================
    // 💥 DANO
    // ==========================
    other.estrutura.atual -= dano;
    other.tempo_dano = 30;

    // ==========================
    // ➡️ DIREÇÃO
    // ==========================
    var dir = sign(other.x - x);

    // evita caso raro de 0
    if (dir == 0) dir = choose(-1, 1);

    // ==========================
    // 🧱 SEPARAR DA COLISÃO
    // ==========================
    var tentativas = 0;

    while (place_meeting(other.x, other.y, id) && tentativas < 10) {
        other.x += dir;
        tentativas++;
    }

    // ==========================
    // 💨 KNOCKBACK
    // ==========================
    var forca = 8;

    if (variable_instance_exists(other, "forca_knockback")) {
        forca = other.forca_knockback;
    }

    other.hsp = dir * forca;
    other.vsp = -4;
}

other.knockback_timer = 10; // duração do empurrão