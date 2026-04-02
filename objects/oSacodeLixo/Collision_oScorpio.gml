if (!variable_global_exists("lixo_coletado")) {
    global.lixo_coletado = 0;
}

// incrementa ANTES de destruir
global.lixo_coletado += 1;

// debug (confirma se rodou)
show_debug_message("Lixo coletado: " + string(global.lixo_coletado));

instance_destroy();