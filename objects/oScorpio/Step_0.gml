// Movimento horizontal
var mov = 0;

if (keyboard_check(ord("D"))) {
    mov = 1;
}

if (keyboard_check(ord("A"))) {
    mov = -1;
}

// Aplica movimento horizontal
x += mov * spd;


// Gravidade
vsp += grav;


// Verifica colisão com o chão (substitua oFloor pelo seu objeto de chão)
if (place_meeting(x, y + 1, oFloor)) {
    
    // Se estiver no chão, permite pular
    if (keyboard_check_pressed(ord("W"))) {
        vsp = jump_force;
    }
}


// Aplica movimento vertical com colisão
if (!place_meeting(x, y + vsp, oFloor)) {
    y += vsp;
} else {
    // Ajusta posição ao colidir
    while (!place_meeting(x, y + sign(vsp), oFloor)) {
        y += sign(vsp);
    }
    vsp = 0;
}