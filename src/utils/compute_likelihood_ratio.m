function [ ratio ] = compute_likelihood_ratio( alpha, T_norm_S, T_norm_M, sujet, K )
% "likelihood" prend en argument le vecteur colonne alpha, un tenseur de 
% sujets sains, un tenseur de sujets malades, un sujet (matrice 116*5) et 
% K. Elle renvoie le rapport de vraisemblance associée au test "le sujet est
% sain (numérateur) VS le sujet est malade (dénominateur)". 


%% =========== Projection des données selon la direction alpha ============

% La matrice "sujet" est une matrice 116*5.
% Le vecteur des données projetées y est de longueur 116.
y = sujet*alpha;


%% =============== Calcul du rapport de vraisemblance =====================

% NOTE SUR L ARTICLE: Il est écrit L = F*LAMBDA*(F') d'où (F')*L*F = LAMBDA
% donc get_laplacian_eigenvectors.m récupère bien F
% or TF(y) = (F')*y
% d'où [TF(y)(1); ... ; TF(y)(K)] = [F'(1); ... ; F'(K)]*y (vecteur colonne)

% vecteur des K premières valeurs propres du sujet (resp. sain puis
% malade)
F_S = get_laplacian_eigenvectors(alpha, T_norm_S); 
F_S = F_S(:,1:K)';
F_M = get_laplacian_eigenvectors(alpha, T_norm_M);
F_M = F_M(:,1:K)';

% norme 2 au carré du vecteur des sujets
norme = sum(y.^2); % Attention "norm" est un opérateur dans Matlab.

% rapport de vraisemblance; N = 116 car il y a 116 régions.
ratio = ((norme - sum((F_M*y).^2))/(norme - sum((F_S*y).^2)))^(116/2);

end

