voltage_1 = [-1658 -2760 -5525 -10485 -19500 -1656.5 -2750 -5500 -10460 -19410 -1642 -2670 -5370 -10340 -19285];

candela = [0.36 8 28.9 78 164 0.37 7.8 29.9 74 159.5 0.35 7.76 30.3 74.6 160];

voltage_2 = [-1223 -2470 -5090 -9295 -16032.5 -1218 -2448.5 -5060 -9285 -15937.5 -1196.5 -2297 -4815 -9085 -15792];

colors = [0 64 128 192 255 0 64 128 192 255 0 64 128 192 255];



figure, plot(voltage_1, candela,'x')
lsline
figure, plot(voltage_2, candela,'x')
% figure, plot(colors, candela,'-o')
lsline

reg = polyfit(voltage_1, candela,1)
