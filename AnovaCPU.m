% === Cargar datos ===
data = readtable('tabla_anova_cpu.xlsx');

% === Extraer variables ===
x = log(data.Var1 + 1);  % porcentaje de CPU idle promedio
f_hora = categorical(data.Var2);
f_dia = categorical(data.Var3);
f_config = categorical(data.Var4);

% === ANOVA multifactorial con interacción ===
[P,T,STATS,TERMS] = anovan(x, ...
    {f_hora, f_dia, f_config}, ...
    'model', 'interaction', ...
    'varnames', {'Hora', 'Dia', 'Configuracion'});

% === Verificar supuestos: análisis de residuos ===
sk = skewness(STATS.resid);  % idealmente entre -1 y 1
k = kurtosis(STATS.resid);   % idealmente ~3

disp(['Skewness: ', num2str(sk)])
disp(['Kurtosis: ', num2str(k)])

% === Gráfica de normalidad de residuos ===
figure, normplot(STATS.resid), title('Normalidad de residuos')

% === Boxplots de residuos por factor ===
figure, boxplot(STATS.resid, f_config), ylabel('Residuo'), xlabel('Configuración')
figure, boxplot(STATS.resid, f_hora), ylabel('Residuo'), xlabel('Hora')
figure, boxplot(STATS.resid, f_dia), ylabel('Residuo'), xlabel('Día')

figure, multcompare(STATS, 'dimension', 1); % Hora
figure, multcompare(STATS, 'dimension', 2); % Día
figure, multcompare(STATS, 'dimension', 3); % Configuración


figure, multcompare(STATS, 'dimension', [1 2]); % Hora y Día
