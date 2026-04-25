function [ eigvec ] = get_laplacian_eigenvectors( alpha, T_norm )
% La fonction "get_laplacian_eigenvectors" prend une valeur de alpha (vecteur colonne à 5 
% composantes, la composante liée au premier paramètre est sur la première 
% ligne), un tenseur normalisé de sujets (sains ou malades),
% construit le graphe associé à ce tenseur de sujets (considéré comme base
% d'apprentissage) calcule la matrice laplacienne associée à ce graphe, et
% renvoie la matrice des {vecteurs propres en colonne} de cette dernière.
% Les vecteurs propres sont indexées dans l'ordre des valeurs
% propres croissantes.


%% =========== Projection des données selon la direction alpha ============ 

nb_sujets = size(T_norm,3);

% On se ramène à une matrice X où l'on a combiné les informations sur les 5
% paramètres. X est donc de taille 116*nb_sujets.

X = zeros(116,nb_sujets);

for r=1:116
    for s=1:nb_sujets
        X(r,s) = T_norm(r,:,s)*alpha;
        % r comme "région" et s comme "sujet"
        % Attention T_norm(r,:,s) est un vecteur ligne
    end
end


%% ============ Calcul de la matrice d'adjacence du graphe ================

% La matrice d'adjacence est une matrice symétrique "adj" de taille 116*116
% telle que W(i,j) est le poids de la liaison entre i et j. Ce poids est
% calculé à l'aide d'un noyau Gaussien (" Gaussien RBF kernel", cf
% l'article de Hu et al.).

% Remarque : dans l'article de Hu et al. il y a un rhô au dénominateur pour
% les poids. Ici on a pris rhô = 1 pour simplifier.

W = zeros(116,116);

for i=1:116 
    for j=1:116   
        W(i,j)=exp(-sum((X(i,:)-X(j,:)).^2));
    end
end


%% ============= Calcul de la matrice des degrés du graphe ================

% Il y a plusieurs définitions pour cette matrice des degrés et nous
% utilisons celle donnée dans l'article de Hu et al. 

D = zeros(116,116);

for i=1:116
    D(i,i) = sum(W(i,:));
end


%% ========= Calcul et diagonalisation de la matrice laplacienne ==========

% Calcul de la matrice laplacienne
L = D - W;

% Diagonalisation de la matrice laplacienne
% On a L*V = V*LAMBDA
[V,LAMBDA] = eig(L);

% Les valeurs propres et les vecteurs propres fournis ne sont pas
% névessairement dans le bon ordre, donc il reste à les trier dans l'ordre
% croissant.

% "ind" est le vecteur des indices qui donne successivement les numéros des
% colonnes pour lequel les valeurs propres associées sont croissantes.
% eigenval est un vecteur qui ne servira pas dans la suite.
[eigenval, ind]=sort(diag(LAMBDA)); 

% Maintenant il suffit de permuter l'ordre des colonnes de V.
eigvec = V(:,ind);

end

