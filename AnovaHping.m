close all;
clear all;

% === Cargar los datos ===
load('Hping.mat');



% === Extraer variables ===
x = tiedrank(data.Valor);
f_hora = categorical(data.Hora);
f_dia = categorical(data.Dia);
f_config = categorical(data.Configuracion);

% === ANOVA multifactorial con interacción ===
[P,T,STATS,TERMS] = anovan(x, ...
    {f_hora, f_dia, f_config}, ...
    'model', 'interaction', ...
    'varnames', {'Hora', 'Dia', 'Configuracion'});

% === Análisis de residuos ===
sk = skewness(STATS.resid);  % Debe estar entre -1 y 1
k = kurtosis(STATS.resid);   % Debe estar cerca de 3
disp(['Skewness: ', num2str(sk)])
disp(['Kurtosis: ', num2str(k)])

% === Gráfica de normalidad de residuos ===
figure, normplot(STATS.resid), title('Normalidad de residuos')

% === Boxplots por factor para visualizar variabilidad ===
figure, boxplot(STATS.resid, f_config), ylabel('Residuo'), xlabel('Configuración')
figure, boxplot(STATS.resid, f_hora), ylabel('Residuo'), xlabel('Hora')
figure, boxplot(STATS.resid, f_dia), ylabel('Residuo'), xlabel('Día')

figure, multcompare(STATS, 'dimension', 1); % Hora
figure, multcompare(STATS, 'dimension', 2); % Día
figure, multcompare(STATS, 'dimension', 3); % Configuración


figure, multcompare(STATS, 'dimension', [1 3]); %  Hora y Configuración
