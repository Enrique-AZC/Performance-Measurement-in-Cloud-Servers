%% Cargar los datos
load('Iperf2_modificado.mat');

%% Preparar la variable dependiente y los factores
x = data.Valor;
x = tiedrank(x);

f_hora = categorical(data.Hora);
f_dia = categorical(data.Dia);
f_config = categorical(data.Configuracion);
f_rate = categorical(data.Rate);

%% ANOVA multifactorial con interacciones
[P,T,STATS,TERMS] = anovan(x, ...
    {f_hora, f_dia, f_config, f_rate}, ...
    'model','interaction', ...
    'varnames', {'Hora', 'Dia', 'Configuracion', 'Rate'});


%% Evaluación de los residuos
sk = skewness(STATS.resid,0);
k = kurtosis(STATS.resid,0);
fprintf('Asimetría (skewness): %.2f\nCurtosis: %.2f\n', sk, k)

figure, normplot(STATS.resid), title('Normalidad de los residuos')

figure, boxplot(STATS.resid, f_hora), xlabel('Hora'), ylabel('Residuos')
figure, boxplot(STATS.resid, f_dia), xlabel('Día'), ylabel('Residuos')
figure, boxplot(STATS.resid, f_config), xlabel('Configuración'), ylabel('Residuos')
figure, boxplot(STATS.resid, f_rate), xlabel('Rate'), ylabel('Residuos')

%% Comparaciones múltiples por factor
figure, multcompare(STATS, 'dimension', 1); % Hora
figure, multcompare(STATS, 'dimension', 2); % Día
figure, multcompare(STATS, 'dimension', 3); % Configuración
figure, multcompare(STATS, 'dimension', 4); % Rate

