%% run this file to generate DCT bases (data and .png figures) for different block size, 
% if you want to include more block size on line 8, 9, please change the code from line 28 to line 55 accordingly
% the saved data is a 2-D matrix, for example, block size=8*8, the saved data is a 64*64 matrix, including 8*8 sub-matrix, each has size 8*8, the first sub-matrix is at position (1:8,1:8)
%% set parameters
% path to save DCT bases
path_DCT_bases_data='DCT_bases/data';
path_DCT_bases_png='DCT_bases/png_figs';
% set block size
block_size_w=[8 16 32];
block_size_h=[8 16 32];
% set color
cvar=gray;
%%
for iw=1:length(block_size_w)
    for ih=1:length(block_size_h)
        w=block_size_w(iw);
        h=block_size_h(ih);
        
        % init DCT bases
        DCT_bases=zeros(h^2,w^2);
        % compute DCT bases
        D1=dctmtx(w);
        D2=dctmtx(h);
        temp=kron(D1,D2);
        for i=0:w*h-1
            DCT_bases(mod(i,h)*h+1:mod(i,h)*h+h,floor(i/h)*w+1:floor(i/h)*w+w)=reshape(temp(i+1,:),[h w]);
            
            % plot
            figure 
            % set the size of figure to make sure every cell is a square
            if h==w
                set(gcf,'Position',[20,20,600,600]);
            elseif h==2*w
                set(gcf,'Position',[20,20,300,600]);
            elseif w==2*h
                set(gcf,'Position',[20,20,600,300]);
            elseif h==4*w
                set(gcf,'Position',[20,20,300,1200]);
            elseif w==4*h
                set(gcf,'Position',[20,20,1200,300]);
            end
            % plot heatmap, set value range here
            img=heatmap(DCT_bases(mod(i,h)*h+1:mod(i,h)*h+h,floor(i/h)*w+1:floor(i/h)*w+w),'ColorLimits',[-0.3 0.3],'ColorMap',cvar,'ColorbarVisible','off','CellLabelColor','none');
            % make x and y labels unvisible
            if iw==1
                img.XDisplayLabels ={'','','','','','','',''};
            elseif iw==2
                img.XDisplayLabels ={'','','','','','','','','','','','','','','',''};
            else
                img.XDisplayLabels ={'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''};
            end
            if ih==1
                img.YDisplayLabels ={'','','','','','','',''};
            elseif ih==2
                img.YDisplayLabels ={'','','','','','','','','','','','','','','',''};
            else
                img.YDisplayLabels ={'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''};
            end
            % make sure every cell is a square
            set(gcf,'windowstyle','normal')
            img.Position =[0 0 1 1];
            
            % save file
            filename=[path_DCT_bases_png,'/w', num2str(w),'_h', num2str(h),'/y', num2str(mod(i,h)+1),'_x', num2str(floor(i/h)+1)];
            saveas(gcf,filename,'png')
            close(gcf);
        end
        
        % save the data
        filename=[path_DCT_bases_data,'/DCT_bases_w',num2str(w),'_h',num2str(h),'.mat'];
        save(filename,'DCT_bases');
    end
end
% plot the entire DCT_bases
% figure
% heatmap(DCT_bases)

