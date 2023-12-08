block_size_w=[8 16 32];
block_size_h=[8 16 32];
cvar=1-gray;
for iw=1:3
    for ih=1:3
        w=block_size_w(iw);
        h=block_size_h(ih);
        D1=dctmtx(w);
        D2=dctmtx(h);
        DCT_basis=zeros(h^2,w^2);
        temp=kron(D1,D2);
        for i=0:w*h-1
            DCT_basis(mod(i,h)*h+1:mod(i,h)*h+h,floor(i/h)*w+1:floor(i/h)*w+w)=reshape(temp(i+1,:),[h w]);
%             figure 
%             set(gcf,'Position',[20,20,600,300]);
%             img=heatmap(DCT_basis(mod(i,h)*h+1:mod(i,h)*h+h,floor(i/h)*w+1:floor(i/h)*w+w),'ColorMap',cvar,'ColorbarVisible','off','CellLabelColor','none');
%             img.XDisplayLabels ={'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''};
%             img.YDisplayLabels ={'','','','','','','','','','','','','','','',''};
%             set(gcf,'windowstyle','normal')
%             img.Position =[0 0 1 1];
%             filename=['DCT_basis/w', num2str(w),'_h', num2str(h),'/w',num2str(w),'_y', num2str(mod(i,h)+1),'_x', num2str(floor(i/h)+1)];
%             saveas(gcf,filename,'png')
%             close(gcf);
        end
        filename=['DCT_basis/DCT_basis_w',num2str(w),'_h',num2str(h),'.mat'];
        save(filename,'DCT_basis');
    end
end
% figure
% heatmap(DCT_basis)

