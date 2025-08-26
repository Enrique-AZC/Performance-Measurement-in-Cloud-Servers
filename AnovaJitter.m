% === Cargar los datos ===
data = readtable('tabla_anova_jitter.xlsx');

% === Extraer variables ===
x = boxcox(data.Valor);  % Jitter en ms
f_hora = categorical(data.Hora);
f_dia = categorical(data.Dia);
f_config = categorical(data.Configuracion);
f_rate = categorical(data.Rate);

% === ANOVA multifactorial con interacción ===
[P, T, STATS, TERMS] = anovan(x, ...
    {f_hora, f_dia, f_config, f_rate}, ...
    'model', 'interaction', ...
    'varnames', {'Hora', 'Dia', 'Configuracion', 'Rate'});

% === Verificar normalidad de los residuos ===
sk = skewness(STATS.resid);
k = kurtosis(STATS.resid);

disp(['Skewness: ', num2str(sk)])
disp(['Kurtosis: ', num2str(k)])

% === Gráfica de normalidad de residuos ===
figure, normplot(STATS.resid), title('Normalidad de residuos (Jitter UDP)')

% === Boxplots de residuos por factor ===
figure, boxplot(STATS.resid, f_config), ylabel('Residuo'), xlabel('Configuración')
figure, boxplot(STATS.resid, f_hora), ylabel('Residuo'), xlabel('Hora')
figure, boxplot(STATS.resid, f_rate), ylabel('Residuo'), xlabel('Rate')
figure, boxplot(STATS.resid, f_dia), ylabel('Residuo'), xlabel('Día')

figure, multcompare(STATS, 'dimension', 1); % Hora
figure, multcompare(STATS, 'dimension', 2); % Día
figure, multcompare(STATS, 'dimension', 3); % Configuración
figure, multcompare(STATS, 'dimension', 4); % Rate
