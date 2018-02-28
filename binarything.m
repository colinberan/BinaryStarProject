%thing for binary thing

id1=data2(data2(:,2)==1,:);
id2=data2(data2(:,2)==2,:); %Takes data, separates into certain ID
id3=data2(data2(:,2)==3,:);

filtB=data2(data2(:,6)==1,:);
filtV=data2(data2(:,6)==2,:); %Takes data, separates into certain filter
filtR=data2(data2(:,6)==3,:);

id1B = data2(data2(:,2)==1 & data2(:,6)==1,:);
id2B = data2(data2(:,2)==2 & data2(:,6)==1,:);
id3B = data2(data2(:,2)==3 & data2(:,6)==1,:);
id1V = data2(data2(:,2)==1 & data2(:,6)==2,:);
id2V = data2(data2(:,2)==2 & data2(:,6)==2,:); %takes ID and filter, finds the data similar to both
id3V = data2(data2(:,2)==3 & data2(:,6)==2,:); %note that there are 9, one for each combination of id and filter
id1R = data2(data2(:,2)==1 & data2(:,6)==3,:);
id2R = data2(data2(:,2)==2 & data2(:,6)==3,:);
id3R = data2(data2(:,2)==3 & data2(:,6)==3,:);

magid1B = id1B(:,7);
magid2B = id2B(:,7);
magid3B = id3B(:,7);
magid1V = id1V(:,7);
magid2V = id2V(:,7); %takes id-filter combinations, finds magnitudes
magid3V = id3V(:,7);
magid1R = id1R(:,7);
magid2R = id2R(:,7);
magid3R = id3R(:,7);

diff21 = magid2V - magid1V;
diff31 = magid3V - magid1V; %takes magnitudes, finds differential magnitude
diff32 = magid3V - magid2V; %note that it is currently set for V filter

date1 = id2B(:,3);
date2 = id2V(:,3); %given a certain filter, pulls out HJD for that current observation
date3 = id2R(:,3); %id doesn't matter, same HJD for the whole image

error1B = id1B(:,8);
error1V = id1V(:,8);
error1R = id1R(:,8);
error2B = id2B(:,8);
error2V = id2V(:,8); %finds the error for each id-filter combination
error2R = id2R(:,8);
error3B = id3B(:,8);
error3V = id3V(:,8);
error3R = id3R(:,8);


error31 = sqrt((error3V.^2)+(error1V.^2)+(error3V-error2V)); %used to calculate the error
error32 = sqrt((error3V.^2)+(error2V.^2)+(error3V-error2V)); %stole this from that presentation, not 100% it's right

period = .3050169; %period of your eclipse
pB = (date1 - 2400000 -52500.1211);
pV = (date2 - 2400000 -52500.1211); %that first part of the phase equation for each filter
pR = (date3 - 2400000 -52500.1211);
mB = mod(pB,period);
mV = mod(pB,period); %that entire top part of the phase equation for each filter
mR = mod(pB,period);

phaseB = mB./period;
phaseV = mV./period; %calculate phase for each filter
phaseR = mR./period;

figure(1) %plot 3-1 vs HJD, includes error bars
errorbar(date2,diff31,error31,'.')
title('Differential Magnitude (V Filter), Object 3 - Object 1 vs. HJD')
xlabel('HJD')
ylabel('Magnitude')

figure(2) %plot 3-2 vs HJD, includes error bars (not sure if this is needed)
errorbar(date2,diff32,error32,'.')
title('Differential Magnitude (V Filter), Object 3 - Object 2 vs. HJD')
xlabel('HJD')
ylabel('Magnitude')

figure(3) %plot 3-1 vs Phase, includes error bars
errorbar(phaseV,diff31,error31,'.')
title('Differential Magnitude (V Filter), Object 3 - Object 1 vs. Phase')
xlabel('Phase')
ylabel('Magnitude')

