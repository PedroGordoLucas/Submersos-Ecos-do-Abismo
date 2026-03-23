var alvo = instance_nearest(x, y, oScorpio);

if (alvo != noone && point_distance(x, y, alvo.x, alvo.y) < distancia_ativacao) {
    cor_atual = cor_proxima;
} else {
    cor_atual = cor_normal;
}