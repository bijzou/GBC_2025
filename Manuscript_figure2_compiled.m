%% 
%compile codes to plot the manuscript figures 2: Fe, SO4, Cl concentration,
%SO42-/Cl, and deltaS in SO4 profiles
leng = ["Jan.-20", "Feb.-20" , "Mar.-20", "Apr.-20", "May-20","Jun.-20", "Jul.-20", "Aug.-20", "Sep.-20", "Oct.-20", "Nov.-20", "Dec.-20", "Jan.-21", "Feb.-21", "Mar.-21", "Apr.-21", "May-21","Jun.-21", "Jul.-21", "Aug.-21", "Sep.-21", "Oct.-21"]
FFe=readmatrix('in_situ_matlab_summary_sum_updateNov23.xlsx','Sheet','ferrozine','Range','D4:Y22');
SFe=readmatrix('in_situ_matlab_summary_sum_updateNov23.xlsx','Sheet','ferrozine','Range','D25:Y43');
Dep =readmatrix('in_situ_matlab_summary_sum_updateNov23.xlsx','Sheet','ferrozine','Range','C4:C22')
FSO=readmatrix('in_situ_matlab_summary_sum_updateNov23.xlsx','Sheet','SO4','Range','D4:Y22');
SSO=readmatrix('in_situ_matlab_summary_sum_updateNov23.xlsx','Sheet','SO4','Range','D25:Y43');
FCl=readmatrix('in_situ_matlab_summary_sum_updateNov23.xlsx','Sheet','Cl','Range','D4:Y22');
SCl=readmatrix('in_situ_matlab_summary_sum_updateNov23.xlsx','Sheet','Cl','Range','D25:Y43');
FSCl=readmatrix('in_situ_matlab_summary_sum_updateNov23.xlsx','Sheet','SCl','Range','D4:Y22');
SSCl=readmatrix('in_situ_matlab_summary_sum_updateNov23.xlsx','Sheet','SCl','Range','D25:Y43');
FS34= readmatrix('in_situ_matlab_summary_sum_updateNov23.xlsx','Sheet','d34S','Range','D4:Y22');
SS34= readmatrix('in_situ_matlab_summary_sum_updateNov23.xlsx','Sheet','d34S','Range','D25:Y43');
FFe_err = FFe* 0.004
FSO_err = FSO* 0.02
SSO_err = SSO* 0.02
FCl_err = FCl* 0.02
SCl_err = SCl* 0.02
FSCl_err = FSCl* 0.02*1.414
SSCl_err = SSCl* 0.02*1.414
FS34_err = zeros(19,22)+ 0.2
SS34_err = zeros(19,22)+ 0.2
%%
%plot Feconc in Ferruginous, Figure a
fig = figure('Name','manuscript_figure2');
fig.Units = 'inches'
fig.Position(3:4) = [20 10]

a = subplot(2,5,1)

FFet= transpose(FFe)% Fe(II) inF pond %
name = strings %create a string array to store legend of each axis%
[i,j] = size(FFet)
c = 1 %counting index%
for k = 1:12
     z = FFet(k,:);
     %skip the column only with nan%
     if sum(isnan(z)) == j 
	continue;
     end
     %if the value is nan, intraplate the value by connecting the adjacent value linearly%
     Depv = Dep(~isnan(FFet(k,:)))
     FFetk = FFet(k,:)
     FFetv = FFetk(~isnan(FFetk))
     FFeti = interp1(Depv, FFetv, Dep, 'Linear')
    %set the color of line as a function of month%
     a = 0.08*k
     b = 1-0.08*k;
     if 0 < k & k < 4
        col = [a*2 b b]
     end
     if 4 < k & k < 10
        col = [a*1.2 b/1.5 b]; %rgb color code of line%
     end
     if k > 10
        col = [b*3 a-0.4 a]; %rgb color code of line%
     end
    
     %plot%
     ev = plot(Dep, FFeti , 'Color', col, MarkerSize = 5);
     ev.LineStyle ='-';
     ev.Marker ='*';
     ev.LineWidth = 1;
     hold on;
     %if the data is plotted, add the legend to the name string array%
     name(c) = leng(k)
     c = c+1
end
hold on
for k = 13:22
	z = FFet(k,:);
    if sum(isnan(z)) == j
		continue;
	end
     	n = k-12
     	a = 0.08*n
     	b = 1-0.08*n
     	if 0 < n & n < 4
          col = [a*2 b b]
        end
        if 4 < n & n < 10
            col = [a*1.2 b/1.5 b]; %rgb color code of line%
        end
        if n > 10
            col = [b*3 a-0.4 a]; %rgb color code of line%
        end
     	Depv = Dep(~isnan(FFet(k,:)))
	    FFetk = FFet(k,:)
     	FFetv = FFetk(~isnan(FFetk))
    	FFeti = interp1(Depv, FFetv, Dep, 'Linear')
    	ev = plot(Dep, FFeti , 'Color', col, MarkerSize = 5);
    	ev.LineStyle ='-';
    	ev.Marker = 'o';
    	ev.LineWidth = 1;
	hold on;
	name(c) = leng(k)
	c = c+1
end
for i = 1:22
    e = errorbar(Dep,FFe(:,i),FFe_err(:,i));
    e.LineStyle = "none";
    e.Color = 'k';
end


view ([90 90]);
ylim([0 1]);
ax = gca;
ax.YAxisLocation = "origin"
xlabel('Depth (cm)')
ylabel('[Fe^{2+}] (mM)')
ax = gca;
ax.LineWidth = 1;
ax.FontSize = 12;
text(40,max(ylim)*0.95, sprintf('A'), 'Horiz','right', 'Vert','bottom',FontSize = 20)

%% 
%plot SO42 conc in Ferruginous, figure b
b = subplot(2,5,2)
FSOt = transpose(FSO)
name = strings %create a string array to store legend of each axis%
[i,j] = size(FSOt)
for k = 1:12
     z = FSOt(k,:);
     %skip the column only with nan%
     if sum(isnan(z)) == j 
	continue;
     end
     %set the color of line as a function of month%
     a = 0.08*(k)
     b = 1-0.08*(k)
     if 0 < k & k < 4
        col = [a*2 b b]
     end
     if 4 < k & k < 10
        col = [a*1.2 b/1.5 b]; %rgb color code of line%
     end
     if k > 10
        col = [b*3 a-0.4 a]; %rgb color code of line%
     end %rgb color code of line%
 %rgb color code of line%
     %if the value is nan, intraplate the value by connecting the adjacent value linearly%
     Depv = Dep(~isnan(FSOt (k,:)))
     FSOtk = FSOt (k,:)
     FSOtv = FSOtk(~isnan(FSOtk))
     FSOti = interp1(Depv, FSOtv, Dep, 'Linear')
     %plot%
     ev = plot(Dep, FSOti , 'Color', col);
     ev.LineStyle ='-';
     ev.Marker = '*';
     ev.LineWidth = 1;
     hold on;
     %if the data is plotted, add the legend to the name string array%
     name(c) = leng(k)
     c = c+1
end
hold on
for k = 13:22
	z = FSOt(k,:);
if sum(isnan(z)) == j
		continue;
	end
     	n = k-12
     	a = 0.08*(n)
     	b = 1-0.08*(n)
     	if 0 < n & n < 4
          col = [a*2 b b]
        end
        if 4 < n & n < 10
            col = [a*1.2 b/1.5 b]; %rgb color code of line%
        end
        if n > 10
            col = [b*3 a-0.4 a]; %rgb color code of line%
        end
     	Depv = Dep(~isnan(FSOt (k,:)))
	FSOtk = FSOt (k,:)
     	FSOtv = FSOtk(~isnan(FSOtk))
    	FSOti = interp1(Depv, FSOtv, Dep, 'Linear')
    	ev = plot(Dep, FSOti , 'Color', col);
    	ev.LineStyle ='-';
    	ev.Marker = 'o';
    	ev.LineWidth = 1;
	hold on;
	%name(c) = leng(k)
	c = c+1
end

for i = 1:22
    e = errorbar(Dep,FSO(:,i),FSO_err(:,i));
    e.LineStyle = "none";
    e.Color = 'k';
end

view ([90 90])
ax = gca;
ax.LineWidth = 1;
ax.FontSize = 12;
set(gca, 'XAxisLocation', 'bottom')
set(gca, 'YAxisLocation', 'right')
xlim([0 40])
ylabel('[SO_{4}^{2-}] (mM)')
SWS = zeros([19,1])+27.6
ev2 = plot(Dep,SWS,'k')
ev2.LineStyle ='--';
ev2.LineWidth = 1.5;
ylim([0 30])
text(40,max(ylim)*0.95, sprintf('B'), 'Horiz','right', 'Vert','bottom',FontSize = 20)
%%
%%
%Figure c, plot Cl conc in Fe
C = subplot(2,5,3)
FClt= transpose(FCl)% Fe(II) inF pond %
name = strings %create a string array to store legend of each axis%
[i,j] = size(FClt)
c = 1 %counting index%
for k = 1:12
     z = FClt(k,:);
     %skip the column only with nan%
     if sum(isnan(z)) == j 
	continue;
     end
     %if the value is nan, intraplate the value by connecting the adjacent value linearly%
     Depv = Dep(~isnan(FClt(k,:)))
     FCltk = FClt(k,:)
     FCltv = FCltk(~isnan(FCltk))
     FClti = interp1(Depv, FCltv, Dep, 'Linear')
    %set the color of line as a function of month%
     a = 0.08*(k)
     b = 1-0.08*(k)
     if 0 < k & k < 4
        col = [a*2 b b]
     end
     if 4 < k & k < 10
        col = [a*1.2 b/1.5 b]; %rgb color code of line%
     end
     if k > 10
        col = [b*3 a-0.4 a]; %rgb color code of line%
     end %rgb color code of line% %rgb color code of line%
     %plot%
     ev = plot(Dep, FClti , 'Color', col);
     ev.LineStyle ='-';
     ev.Marker = '*';
     ev.LineWidth = 1;
     hold on;
     %if the data is plotted, add the legend to the name string array%
     %name(c) = leng(k)
     c = c+1
end
hold on
for k = 13:22
    
	z = FClt(k,:);
if sum(isnan(z)) == j
		continue;
	end
     	n = k-12
     	a = 0.08*(n)
     	b = 1-0.08*(n)
     	if 0 < n & n < 4
          col = [a*2 b b]
        end
        if 4 < n & n < 10
            col = [a*1.2 b/1.5 b]; %rgb color code of line%
        end
        if n > 10
            col = [b*3 a-0.4 a]; %rgb color code of line%
        end
     	Depv = Dep(~isnan(FClt(k,:)))
	    FCltk = FClt(k,:)
     	FCltv = FCltk(~isnan(FCltk))
    	FClti = interp1(Depv, FCltv, Dep, 'Linear')
    	ev = plot(Dep, FClti , 'Color', col);
    	ev.LineStyle ='-';
    	ev.Marker = 'o';
    	ev.LineWidth = 1;
	hold on;
	%name(c) = leng(k)
	c = c+1
end

for i = 1:22
    e = errorbar(Dep,FCl(:,i),FCl_err(:,i));
    e.LineStyle = "none";
    e.Color = 'k';
end


view ([90 90])
%note after rotate the axis using view function, y axis is horizontal and x axis is vertical%
ax = gca;
ax.LineWidth = 1;
ax.FontSize = 15;
set(gca, 'XAxisLocation', 'bottom')
set(gca, 'YAxisLocation', 'right')
ylabel('[Cl^{-}] (mM)')
SWS = zeros([19,1])+536.2
ev2 = plot(Dep,SWS,'k')
ev2.LineStyle ='--';
ev2.LineWidth = 1.5;
ylim([0 600])
xlim([0 40])
ax = gca;
ax.LineWidth = 1;
ax.FontSize = 12;
text(40,max(ylim)*0.95, sprintf('C'), 'Horiz','right', 'Vert','bottom',FontSize = 20)
%%
%plot S/Cl ratio in Fe
%d = subplot(2,5,4)
figure
FSClt = transpose(FSCl)% SO4/Cl ratio in S pond %
SW = zeros([19,1])+0.051524;
name = strings  %create a string array to store legend of each axis%
[i,j] = size(FSClt)
c = 1 %counting index%
leng = ["Jan.-20", "Feb.-20" , "Mar.-20", "Apr.-20", "May-20","Jun.-20", "Jul.-20", "Aug.-20", "Sep.-20", "Oct.-20", "Nov.-20", "Dec.-20", "Jan.-21", "Feb.-21", "Mar.-21", "Apr.-21", "May-21","Jun.-21", "Jul.-21", "Aug.-21", "Sep.-21", "Oct.-21"]

for k = 1:12
     z = FSClt(k,:);
     % skip the column only with nan%
     if sum(isnan(z)) == j 
	continue;
     end
     %set the color of line as a function of month%
     a = 0.08*k
     b = 1-0.08*k
     if 0 < k & k < 4
        col = [a*2 b b]
     end
     if 4 < k & k < 10
        col = [a*1.2 b/1.5 b]; %rgb color code of line%
     end
     if k > 10
        col = [b*3 a-0.4 a]; %rgb color code of line%
     end %rgb color code of line% %rgb color code of line%
     %if the value is nan, intraplate the value by connecting the adjacent value linearly%
     Depv = Dep(~isnan(FSClt (k,:)))
     FSCltk = FSClt(k,:)
     FSCltv = FSCltk(~isnan(FSCltk))
     FSClti = interp1(Depv, FSCltv, Dep, 'Linear')
     %plot%
     ev = plot(Dep, FSClti, 'Color', col);
     ev.LineStyle ='-'
     ev.Marker = '*';
     ev.LineWidth = 1;  
     hold on;
     %if the data is plotted, add the legend to the name string array%
     name(c) = leng(k)
     c = c+1
end
hold on
for k = 13:22
	z = FSClt(k,:);
if sum(isnan(z)) == j
		continue;
	end
	n = k-12
     	a = 0.08*n
     	b = 1-0.08*n
     	if 0 < n & n < 4
          col = [a*2 b b]
        end
        if 4 < n & n < 10
            col = [a*1.2 b/1.5 b]; %rgb color code of line%
        end
        if n > 10
            col = [b*3 a-0.4 a]; %rgb color code of line%
        end %rgb color code of line%
     	Depv = Dep(~isnan(FSClt(k,:)))
	    FSCltk = FSClt(k,:)
     	FSCltv = FSCltk(~isnan(FSCltk))
    	FSClti = interp1(Depv, FSCltv, Dep, 'Linear')
    	ev = plot(Dep, FSClti, 'Color', col);
    	ev.LineStyle ='-';
   ev.Marker = 'o';
	ev.MarkerSize = 5; 
    	ev.LineWidth = 1;
	hold on;
	name(c) = leng(k)
	c = c+1
end

%for i = 1:22
   % e = errorbar(Dep,FSCl(:,i),FSCl_err(:,i));
   % e.LineStyle = "none";
   % e.Color = 'k';
   % e.CapSize = 20;
%end

view ([90 90])
ax = gca;
ax.LineWidth = 2;
ax.FontSize = 20;
set(gca, 'XAxisLocation', 'bottom')
set(gca, 'YAxisLocation', 'right')
xlim([0 40])
ylim([0.04 0.055])
%ylim([0 0.06])
%ylabel('[SO_{4}^{2-}]/[Cl^{-}]')
ev2 = plot (Dep, SW, 'Color', 'k') 
ev2.LineStyle ='--';
ev2.LineWidth = 1.5;
%text(40,max(ylim)*0.95, sprintf('D'), 'Horiz','right', 'Vert','bottom',FontSize = 20)

%%
%plot d34S in Fe
%e = subplot(2,5,5)
figure
FS34t= transpose(FS34)% Fe(II) inF pond %
name = strings %create a string array to store legend of each axis%
[i,j] = size(FS34t)
c = 1 %counting index%

for k = 1:12
     z = FS34t(k,:);
     %skip the column only with nan%
     if sum(isnan(z)) == j 
	continue;
     end
     %if the value is nan, intraplate the value by connecting the adjacent value linearly%
     Depv = Dep(~isnan(FS34t(k,:)))
     FS34tk = FS34t(k,:)
     FS34tv = FS34tk(~isnan(FS34tk))
     FS34ti = interp1(Depv, FS34tv, Dep, 'Linear')
    %set the color of line as a function of month%
     a = 0.08*k
     b = 1-0.08*k
     if 0 < k & k < 4
        col = [a*2 b b]
     end
     if 4 < k & k < 10
        col = [a*1.2 b/1.5 b]; %rgb color code of line%
     end
     if k > 10
        col = [b*3 a-0.4 a]; %rgb color code of line%
     end %rgb color code of line% %rgb color code of line%
     %plot%
     ev = plot(Dep, FS34ti , 'Color', col);
     ev.LineStyle ='-'
     ev.LineWidth = 1;
     ev.Marker = '*';
     hold on;
     %if the data is plotted, add the legend to the name string array%
     name(c) = leng(k)
     c = c+1
end
hold on
for k = 13:22
	z = FS34t(k,:);
if sum(isnan(z)) == j
		continue;
	end
     	n = k-12
     	a = 0.08*n
     	b = 1-0.08*n
     	if 0 < n & n < 4
          col = [a*2 b b]
        end
        if 4 < n & n < 10
            col = [a*1.2 b/1.5 b]; %rgb color code of line%
        end
        if n > 10
            col = [b*3 a-0.4 a]; %rgb color code of line%
        end
     	Depv = Dep(~isnan(FS34t(k,:)))
	    FS34tk = FS34t(k,:)
     	FS34tv = FS34tk(~isnan(FS34tk))
    	FS34ti = interp1(Depv, FS34tv, Dep, 'Linear')
    	ev = plot(Dep, FS34ti , 'Color', col);
    	ev.LineStyle ='-';
    	ev.Marker = 'o';
    	ev.LineWidth = 1;
	hold on;
	name(c) = leng(k)
	c = c+1
end

for i = 1:22
    %e = errorbar(Dep,FS34(:,i),FS34_err(:,i));
    %e.LineStyle = "none";
    %e.Color = 'k';
end

view ([90 90])
%note after rotate the axis using view function, y axis is horizontal and x axis is vertical%
ax = gca;
ax.LineWidth = 1;
ax.FontSize = 15;
set(gca, 'XAxisLocation', 'bottom')
set(gca, 'YAxisLocation', 'right')
ylabel(['\delta^{34}S_{SO4} (',char(8240) ,'VCDT)'])
SWS = zeros([19,1])+21
ev2 = plot(Dep,SWS,'k')
ev2.LineStyle ='--';
ev2.LineWidth = 1.5;
ylim([15 30])
xlim([0 40])
ax = gca;
ax.LineWidth = 2;
ax.FontSize = 20;
%text(40,max(ylim)*0.95, sprintf('E'), 'Horiz','right', 'Vert','bottom',FontSize = 20)
%%
%Fe in sulfidic
f = subplot(2,5,6)
SFet= transpose(SFe)% Fe(II) inF pond %

[i,j] = size(SFet)
c = 1 %counting index%

for k = 1:12
     z = SFet(k,:);
     %skip the column only with nan%
     if sum(isnan(z)) == j 
	continue;
     end
     %if the value is nan, intraplate the value by connecting the adjacent value linearly%
     Depv = Dep(~isnan(SFet(k,:)))
     SFetk = SFet(k,:)
     SFetv = SFetk(~isnan(SFetk))
     SFeti = interp1(Depv, SFetv, Dep, 'Linear')
    %set the color of line as a function of month%
     a = 0.08*k
     b = 1-0.08*k
     if 0 < k & k < 4
        col = [a*2 b b]
     end
     if 4 < k & k < 10
        col = [a*1.2 b/1.5 b]; %rgb color code of line%
     end
     if k > 10
        col = [b*3 a-0.4 a]; %rgb color code of line%
     end %rgb color code of line% %rgb color code of line%
     %plot%
     ev = plot(Dep, SFeti , 'Color', col);
     ev.LineStyle ='-';
     ev.Marker = '*';
     ev.LineWidth = 1;
     hold on;
     %if the data is plotted, add the legend to the name string array%
     name(c) = leng(k)
     c = c+1
end
hold on
for k = 13:22
	z = SFet(k,:);
if sum(isnan(z)) == j
		continue;
	end
     	n = k-12
     	a = 0.08*n
     	b = 1-0.08*n
     	if 0 < n & n < 4
          col = [a*2 b b]
        end
        if 4 < n & n < 10
            col = [a*1.2 b/1.5 b]; %rgb color code of line%
        end
        if n > 10
            col = [b*3 a-0.4 a]; %rgb color code of line%
        end
     	Depv = Dep(~isnan(SFet(k,:)))
	    SFetk = SFet(k,:)
     	SFetv = SFetk(~isnan(SFetk))
    	SFeti = interp1(Depv, SFetv, Dep, 'Linear')
    	ev = plot(Dep, SFeti , 'Color', col);
    	ev.LineStyle ='-';
    	ev.Marker = 'o';
    	ev.LineWidth = 1;
	
	hold on;
	name(c) = leng(k)
	c = c+1
end

lgd= legend(name)
lgd.FontSize = 10;
lgd.Location = 'south'
view ([90 90])

%note after rotate the axis using view function, y axis is horizontal and x axis is vertical%
ax = gca;
ax.LineWidth = 1;
ax.FontSize = 12;

set(gca, 'XAxisLocation', 'bottom');
set(gca, 'YAxisLocation', 'right');
xlim([0 40])
ylim([0 1])
xlabel('Depth (cm)')
ylabel('[Fe^{2+}] (mM)')
text(40,max(ylim)*0.95, sprintf('F'), 'Horiz','right', 'Vert','bottom',FontSize = 20)
%%
%plot SO4 in S
g = subplot(2,5,7)
SSOt = transpose(SSO)% SO4/Cl ratio in S pond %
name = strings %create a string array to store legend of each axis%
[i,j] = size(SSOt)
c = 1  %counting index%
for k = 1:12
     z = SSOt(k,:);
     %skip the column only with nan%
     if sum(isnan(z)) == j 
	continue;
     end
     %set the color of line as a function of month%
     a = 0.08*(k)
     b = 1-0.08*(k)
     if 0 < k & k < 4
        col = [a*2 b b]
     end
     if 4 < k & k < 10
        col = [a*1.2 b/1.5 b]; %rgb color code of line%
     end
     if k > 10
        col = [b*3 a-0.4 a]; %rgb color code of line%
     end %rgb color code of line% %rgb color code of line%
     %if the value is nan, intraplate the value by connecting the adjacent value linearly%
     Depv = Dep(~isnan(SSOt (k,:)))
     SSOtk = SSOt (k,:)
     SSOtv = SSOtk(~isnan(SSOtk))
     SSOti = interp1(Depv, SSOtv, Dep, 'Linear')
     %plot%
     ev = plot(Dep, SSOti , 'Color', col);
     ev.LineStyle ='-';
     ev.Marker = '*';
     ev.LineWidth = 1;
     hold on;
     %if the data is plotted, add the legend to the name string array%
     name(c) = leng(k)
     c = c+1
end
hold on
for k = 13:22
	z = SSOt(k,:);
if sum(isnan(z)) == j
		continue;
	end
     	n = k-12
     	a = 0.08*(n)
     	b = 1-0.08*(n)
     	if 0 < n & n < 4
          col = [a*2 b b]
        end
        if 4 < n & n < 10
            col = [a*1.2 b/1.5 b]; %rgb color code of line%
        end
        if n > 10
            col = [b*3 a-0.4 a]; %rgb color code of line%
        end 
     	Depv = Dep(~isnan(SSOt (k,:)))
	    SSOtk = SSOt (k,:)
     	SSOtv = SSOtk(~isnan(SSOtk))
    	SSOti = interp1(Depv, SSOtv, Dep, 'Linear')
    	ev = plot(Dep, SSOti , 'Color', col);
    	ev.LineStyle ='-';
    	ev.Marker = 'o';
    	ev.LineWidth = 1;
	hold on;
	
	c = c+1
end

for i = 1:22
    e = errorbar(Dep,SSO(:,i),SSO_err(:,i));
    e.LineStyle = "none";
    e.Color = 'k';
end

view ([90 90])
%note after rotate the axis using view function, y axis is horizontal and x axis is vertical%
ax = gca;
ax.LineWidth = 1;
ax.FontSize = 12;
set(gca, 'XAxisLocation', 'bottom')
set(gca, 'YAxisLocation', 'right')
xlim([0 40])
ylabel('[SO_{4}^{2-}] (mM)')
SWS = zeros([19,1])+27.6
ev2 = plot (Dep, SWS, 'Color', 'k') 
ev2.LineStyle ='--';
ev2.LineWidth = 1.5;
ylim([0 30])
text(40,max(ylim)*0.95, sprintf('G'), 'Horiz','right', 'Vert','bottom',FontSize = 20)

%%
%plot Cl in S
h = subplot(2,5,8)
SClt= transpose(SCl)% Fe(II) inF pond %
name = strings %create a string array to store legend of each axis%
[i,j] = size(SClt)
c = 1 %counting index%
for k = 1:12
     z = SClt(k,:);
     %skip the column only with nan%
     if sum(isnan(z)) == j 
	continue;
     end
     %if the value is nan, intraplate the value by connecting the adjacent value linearly%
     Depv = Dep(~isnan(SClt(k,:)))
     SCltk = SClt(k,:)
     SCltv = SCltk(~isnan(SCltk))
     SClti = interp1(Depv, SCltv, Dep, 'Linear')
    %set the color of line as a function of month%
     a = 0.08*(k)
     b = 1-0.08*(k)
     if 0 < k & k < 4
        col = [a*2 b b]
     end
     if 4 < k & k < 10
        col = [a*1.2 b/1.5 b]; %rgb color code of line%
     end
     if k > 10
        col = [b*3 a-0.4 a]; %rgb color code of line%
     end %rgb color code of line%%rgb color code of line%
     %plot%
     ev = plot(Dep, SClti , 'Color', col);
     ev.LineStyle ='-'
     ev.Marker ='*'
     ev.LineWidth = 1;
     hold on;
     %if the data is plotted, add the legend to the name string array%
     name(c) = leng(k)
     c = c+1
end
hold on
for k = 13:22
	z = SClt(k,:);
if sum(isnan(z)) == j
		continue;
	end
     	n = k-12
     	a = 0.08*(n)
     	b = 1-0.08*(n)
     	if 0 < n & n < 4
          col = [a*2 b b]
        end
        if 4 < n & n < 10
            col = [a*1.2 b/1.5 b]; %rgb color code of line%
        end
        if n > 10
            col = [b*3 a-0.4 a]; %rgb color code of line%
        end
     	Depv = Dep(~isnan(SClt(k,:)))
	SCltk = SClt(k,:)
     	SCltv = SCltk(~isnan(SCltk))
    	SClti = interp1(Depv, SCltv, Dep, 'Linear')
    	ev = plot(Dep, SClti , 'Color', col);
    	ev.LineStyle ='-';
    	ev.Marker = 'o';
    	ev.LineWidth = 1;
	hold on;
	name(c) = leng(k)
	c = c+1
end

for i = 1:22
    e = errorbar(Dep,SCl(:,i),SCl_err(:,i));
    e.LineStyle = "none";
    e.Color = 'k';
end

view ([90 90])
%note after rotate the axis using view function, y axis is horizontal and x axis is vertical%
ax = gca;
ax.LineWidth = 1;
ax.FontSize = 12;
set(gca, 'XAxisLocation', 'bottom')
set(gca, 'YAxisLocation', 'right')
SWS = zeros([19,1])+536.2
ev2 = plot(Dep,SWS,'k')
ev2.LineStyle ='--';
ev2.LineWidth = 1.5;
ylim([0 600])
xlim([0 40])
ylabel('[Cl^{-}] (mM)')
text(40,max(ylim)*0.95, sprintf('H'), 'Horiz','right', 'Vert','bottom',FontSize = 20)
%%
%SCl in S
i = subplot(2,5,9)
SSClt = transpose(SSCl)% SO4/Cl ratio in S pond %
name = strings  %create a string array to store legend of each axis%
[i,j] = size(SSClt)
c = 1  %counting index%

for k = 1:12
     z = SSClt(k,:);
     %skip the column only with nan%
     if sum(isnan(z)) == j 
	continue;
     end
     %set the color of line as a function of month%
     a = 0.08*(k)
     b = 1-0.08*(k)
     if 0 < k & k < 4
        col = [a*2 b b]
     end
     if 4 < k & k < 10
        col = [a*1.2 b/1.5 b]; %rgb color code of line%
     end
     if k > 10
        col = [b*3 a-0.4 a]; %rgb color code of line%
     end %rgb color code of line% %rgb color code of line%
     %if the value is nan, intraplate the value by connecting the adjacent value linearly%
     Depv = Dep(~isnan(SSClt (k,:)))
     SSCltk = SSClt (k,:)
     SSCltv = SSCltk(~isnan(SSCltk))
     SSClti = interp1(Depv, SSCltv, Dep, 'Linear')
     %plot%
     ev = plot(Dep, SSClti , 'Color', col);
     ev.LineStyle ='-';
     ev.Marker = '*';
     ev.LineWidth = 1;
     hold on;
     %if the data is plotted, add the legend to the name string array%
     name(c) = leng(k)
     c = c+1
end
hold on
for k = 13:22
	z = SSClt(k,:);
if sum(isnan(z)) == j
		continue;
	end
     	n = k-12
     	a = 0.08*(n)
     	b = 1-0.08*(n)
	
     	if 0 < n & n < 4
          col = [a*2 b b]
        end
        if 4 < n & n < 10
            col = [a*1.2 b/1.5 b]; %rgb color code of line%
        end
        if n > 10
            col = [b*3 a-0.4 a]; %rgb color code of line%
        end
     	Depv = Dep(~isnan(SSClt (k,:)))
	SSCltk = SSClt (k,:)
     	SSCltv = SSCltk(~isnan(SSCltk))
    	SSClti = interp1(Depv, SSCltv, Dep, 'Linear')
    	ev = plot(Dep, SSClti , 'Color', col);
    	ev.LineStyle ='-';
    	ev.Marker = 'o';
    	ev.LineWidth = 1;
	hold on;
	name(c) = leng(k)
	c = c+1
end

for i = 1:22
    e = errorbar(Dep,SSCl(:,i),SSCl_err(:,i));
    e.LineStyle = "none";
    e.Color = 'k';
end

view ([90 90])
%note after rotate the axis using view function, y axis is horizontal and x axis is vertical%
ax = gca;
ax.LineWidth = 1;
ax.FontSize = 12;
set(gca, 'XAxisLocation', 'bottom')
set(gca, 'YAxisLocation', 'right')
SWS = zeros([19,1])+0.051524
ev2 = plot (Dep, SWS, 'Color', 'k')
ylabel('[SO_{4}^{2-}]/[Cl^{-}]')
ev2.LineStyle ='--';
ev2.LineWidth = 1.5;
ylim([0 0.06])
xlim([0 40])
text(40,max(ylim)*0.95, sprintf('I'), 'Horiz','right', 'Vert','bottom',FontSize = 20)
%%
j = subplot(2,5,10)
SS34t= transpose(SS34)% Fe(II) inF pond %
name = strings %create a string array to store legend of each axis%
[i,j] = size(SS34t)
c = 1 %counting index%

for k = 1:12
     z = SS34t(k,:);
     %skip the column only with nan%
     if sum(isnan(z)) == j 
	 continue;
     end
     %if the value is nan, intraplate the value by connecting the adjacent value linearly%
     Depv = Dep(~isnan(SS34t(k,:)))
     SS34tk = SS34t(k,:)
     SS34tv = SS34tk(~isnan(SS34tk))
     SS34ti = interp1(Depv, SS34tv, Dep, 'Linear')
    %set the color of line as a function of month%
     a = 0.08*k
     b = 1-0.08*k
     if 0 < k & k < 4
        col = [a*2 b b]
     end
     if 4 < k & k < 10
        col = [a*1.2 b/1.5 b]; %rgb color code of line%
     end
     if k > 10
        col = [b*3 a-0.4 a]; %rgb color code of line%
     end %rgb color code of line% %rgb color code of line%
     %plot%
     ev = plot(Dep, SS34ti , 'Color', col);
     ev.LineStyle ='-';
     ev.Marker = '*';
     ev.LineWidth = 1;
     hold on;
     %if the data is plotted, add the legend to the name string array%
     name(c) = leng(k)
     c = c+1
end
hold on
for k = 13:19
	z = SS34t(k,:);
if sum(isnan(z)) == j
		continue;
	end
     	n = k-12
     	a = 0.08*n
     	b = 1-0.08*n
     	if 0 < n & n < 4
          col = [a*2 b b]
        end
        if 4 < n & n < 10
            col = [a*1.2 b/1.5 b]; %rgb color code of line%
        end
        if n > 10
            col = [b*3 a-0.4 a]; %rgb color code of line%
        end
     	Depv = Dep(~isnan(SS34t(k,:)))
	    SS34tk = SS34t(k,:)
     	SS34tv = SS34tk(~isnan(SS34tk))
    	SS34ti = interp1(Depv, SS34tv, Dep, 'Linear')
    	ev = plot(Dep, SS34ti , 'Color', col);
    	ev.LineStyle ='-';
    	ev.Marker = 'o';
    	ev.LineWidth = 1;
	hold on;
	name(c) = leng(k)
	c = c+1
end

for i = 1:22
    e = errorbar(Dep,SS34(:,i),SS34_err(:,i));
    e.LineStyle = "none";
    e.Color = 'k';
end

view ([90 90])
%note after rotate the axis using view function, y axis is horizontal and x axis is vertical%
ax = gca;
ax.LineWidth = 1;
ax.FontSize = 12;
set(gca, 'XAxisLocation', 'bottom')
set(gca, 'YAxisLocation', 'right')
SWS = zeros([19,1])+21
ev2 = plot(Dep,SWS,'k')
ev2.LineStyle ='--';
ev2.LineWidth = 1.5;
ylim([0 80])
xlim([0 40])
ylabel(['\delta^{34}S_{SO4} (',char(8240) ,'VCDT)'])
text(40,max(ylim)*0.95, sprintf('J'), 'Horiz','right', 'Vert','bottom',FontSize = 20)

exportgraphics(fig, 'manuscript_f2_v4.pdf','Resolution',600)
