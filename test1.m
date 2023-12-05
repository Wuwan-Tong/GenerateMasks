w=8;
h=16;
temp_mask=zeros(h,w);
cvar=1-gray;
for i=1:16
    temp_mask(:,:)=masks_save(1,i,:,:);
    figure
    set(gcf,'Position',[20,20,250,500]);
    img=heatmap(temp_mask,'ColorLimits',[0 64],'ColorMap',cvar,'ColorbarVisible','off');
    filename=['figures_png/smooth/w8_h16/smooth_w', num2str(w),'_h', num2str(h), '_wedge type', num2str(i)];
    img.XDisplayLabels ={'','','','','','','',''};
    img.YDisplayLabels ={'','','','','','','','','','','','','','','',''};
    set(gcf,'windowstyle','normal')
    img.Position =[0 0 1 1];
%     img.Position = [0.1 0.25 0.78,1/2];
%     img.YDisplayLabels ={'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''};
%     img.Position = [0.38 0 0.78/4,1];
%     img.YDisplayLabels ={'','','','','','','','','','','','','','','',''};
%     img.Position = [0.27 0 0.78/2,1];
%     img.YDisplayLabels ={'','','','','','','',''};
%     img.Position = [0.1 0 0.78,1];
    saveas(gcf,filename,'png')
end

