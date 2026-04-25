function [ TenseurSain5Param, TenseurMA5Param] = standardize(healthy_tensor_path, diseased_tensor_path)
% Résumé : Cette fonction charge deux tenseurs de données, un pour les
% patients sains et un pour les patients malades. La première composante i
% représente le nombre de régions (116 régions), la deuxième composante le
% nombre de paramètres (5 paramètres) et la troisième le nombre de sujets
% (S sujets sains et M sujets malades). Ensuite, elle normalise les
% données en effectuant les moyennes selon les régions à patient et
% paramètres fixés.s
%
% Remarque : On peut améliorer le code et le vectorialiser en supprimant
% l'utilisation de boucles.


%% Chargement des deux matrices de données initiales

load(healthy_tensor_path);
load(diseased_tensor_path);

S = size(TenseurSain5Param, 3);
M = size(TenseurMA5Param, 3);


%% Normalisation des données pour le tenseur des sujets sains

for i=1:S
    for j=1:5
        TenseurSain5Param(:,j,i) = (TenseurSain5Param(:,j,i) - mean(TenseurSain5Param(:,j,i)))...
            /(sqrt(var(TenseurSain5Param(:,j,i))));
    end
end


%% Normalisation des données pour le tenseur des sujets malades

for i=1:M
    for j=1:5
        TenseurMA5Param(:,j,i) = (TenseurMA5Param(:,j,i) - mean(TenseurMA5Param(:,j,i)))...
            /(sqrt(var(TenseurMA5Param(:,j,i))));
    end
end


end


