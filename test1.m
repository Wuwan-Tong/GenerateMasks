w=8;
h=32;
load('C:\Users\Stacey\Desktop\GenerateMasksLFB\masks\sharp\masks_sharp_w8_h32.mat')
temp_mask=zeros(h,w);
cvar=1-gray;
for i=1:16
    temp_mask(:,:)=masks_save(1,i,:,:);
    figure
    set(gcf,'Position',[20,20,150,600]);
%     set(gcf,'Position',[20,20,150,600]);
%     set(gcf,'Position',[20,20,250,500]);
    img=heatmap(temp_mask,'ColorLimits',[0 64],'ColorMap',cvar,'ColorbarVisible','off','CellLabelColor','none');
    filename=['figures_png/sharp/w8_h32/sharp_w', num2str(w),'_h', num2str(h), '_wedge type', num2str(i)];
    img.XDisplayLabels ={'','','','','','','',''};
    img.YDisplayLabels ={'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''};
    set(gcf,'windowstyle','normal')
    img.Position =[0 0 1 1];
%     img.FontSize = 15;
%     img.YDisplayLabels ={'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''};
%     img.YDisplayLabels ={'','','','','','','','','','','','','','','',''};
%     img.YDisplayLabels ={'','','','','','','',''};
    saveas(gcf,filename,'png')
end

