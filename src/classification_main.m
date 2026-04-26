%% ====================== Classification script ===========================  
%
% Cet algorithme renvoie la sensibilité, la spécificité et le FPR d'un algorithme
% de classification de signaux sur graphes en utilisant les paramètres alpha et K 
% spécifiés.


%% ================== Initialisation des paramètres =======================
 
% Valeur de alpha que l'on souhaite tester :
alpha = [0.2;0.2;0.2;0.2;0.2];

% Note: Il peut être pratique de charger alpha dans le Workspace avant d'exécuter
% ce script, i.e., cette valeur de alpha peut-être éventuellement commentée
% si nécessaire. Attention à la transposition, il faut utiliser 
% alpha_history(i,:)'

% Valeur de K qui correspond au alpha que l'on souhaite tester
K = 3;

subjects_data_path = "subjects_data.mat";


%% A NE PAS CHANGER : 

% Chargement et normalisation des tenseurs en entrée
[T_norm_S, T_norm_M] = standardize(subjects_data_path);

% Nombre de patients dans la base précédente
s = size(T_norm_S, 3);
m = size(T_norm_M, 3);

% Initialisation du vecteur des vraisemblances
vec_vrais = ones(m+s,1);

% On initialise des compteurs pour les vrais positifs, les vrais
% négatifs, les faux positifs et les faux négatifs.
VP = 0;
VN = 0;
FP = 0;
FN = 0;


%% ============ Calcul de la sensibilité et de la spécificité =============

% On effectue s+m tests avec la valeur de alpha désirée. L'indice k
% correspond au numéro du sujet sur lequel on teste l'algorithme, les
% autres sujets servant de base pour l'apprentissage.

% On s'occupe d'abord de calculer les vraisemblances pour les sujets vraiment sains
for k = 1:s
    if k == 1
        T_norm_S2 = T_norm_S (:,:,2:s);
    elseif k == s
        T_norm_S2 = T_norm_S (:,:,1:(s-1));      
    else
        A = T_norm_S (:,:,1:(k-1));
        B = T_norm_S (:,:,(k+1):s);
        T_norm_S2 = cat(3,A,B);
    end
    vec_vrais (k) = compute_likelihood_ratio( alpha, T_norm_S2, T_norm_M, T_norm_S(:,:,k), K );
end

% Puis on s'occupe des vraisemblances pour les sujets vraiment malades
for k=1:m
    if k == 1
        T_norm_M2 = T_norm_M (:,:,2:m);
    elseif k == m
        T_norm_M2 = T_norm_M (:,:,1:(m-1));      
    else
        A = T_norm_M (:,:,1:(k-1));
        B = T_norm_M (:,:,(k+1):m);
        T_norm_M2 = cat(3,A,B);  
    end
    vec_vrais (k+s) = compute_likelihood_ratio( alpha, T_norm_S, T_norm_M2, T_norm_M(:,:,k), K );
end

% On calcule ensuite les VP, VN, FP, FN

% Mise à jour pour les sujets vraiment sains
for k = 1:s
    if vec_vrais(k) >1 % sujet classé sain
        VN = VN +1;
    else
        FP = FP + 1;
    end
end

% Mise à jour pour les sujets vraiment malades
for k = s+1:s+m
    if vec_vrais(k) >1 % sujet classé sain
        FN = FN +1;
    else
        VP = VP + 1;
    end
end

% Calcul de la sensibilité, de la spécificité et de la fraction de faux
% positifs. Les valeurs sont renvoyées sur la console.
sensitivity = VP/(VP+FN)
specificity = VN/(VN+FP)
false_pos_frac = 1 - specificity
F1_score = 2*VP/(2*VP+FP+FN)
