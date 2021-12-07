function plotThem(points)
% points = [ux_0,uy_0; ux_1,uy_1; ux_2,uy_2; ...];
% function to scatter plot points one-by-one

    oye = log(points - min(points)+1);
    for i = 1:15
        oye = log(oye - min(oye) + 1);
    end
    close all
    figure;
    plot1 = scatter(oye(1,1), oye(1,2), 40, 'filled');
    xlabel('log(u_{x})\rightarrow', FontSize=17);
    ylabel('log(u_{y})\rightarrow', FontSize=17);

    xlim([min(oye(:,1)) max(oye(:,1))]);
    ylim([min(oye(:,2)) max(oye(:,2))]);
%     set(gca,'Color','none');
%     set(gca,'CLim',[0, 1E-4]);

    gif('myJIFFY.gif');

    for i = 2:length(oye)
        plot1.XData = oye(1:i,1);
        plot1.YData = oye(1:i,2);
%         plot1.CData = colorArray(1:i);

        gif;
    end
end

