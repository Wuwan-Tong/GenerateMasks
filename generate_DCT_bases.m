block_size=[8 16 32];
cvar=1-gray;
for idx_size=1
    b=block_size(idx_size);
    D=dctmtx(b);
    DCT_basis=zeros(b^2,b^2);

    temp=kron(D,D);
    for i=0:b^2-1
        DCT_basis(floor(i/b)*b+1:floor(i/b)*b+b,mod(i,b)*b+1:mod(i,b)*b+b)=reshape(temp(i+1,:),[b b])';
%         figure 
%         set(gcf,'Position',[20,20,600,600]);
%         img=heatmap(DCT_basis(floor(i/b)*b+1:floor(i/b)*b+b,mod(i,b)*b+1:mod(i,b)*b+b),'ColorMap',cvar,'ColorbarVisible','off','CellLabelColor','none');
%         img.XDisplayLabels ={'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''};
%         img.YDisplayLabels ={'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''};
%         set(gcf,'windowstyle','normal')
%         img.Position =[0 0 1 1];
%         filename=['DCT_basis/b', num2str(b),'/b',num2str(b),'_y', num2str(floor(i/b)+1),'_x', num2str(mod(i,b)+1)];
%         saveas(gcf,filename,'png')
    end
end

