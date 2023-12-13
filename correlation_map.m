%% run this file to get correlation maps, both data and .png figures
%% set parameters
% use original mask or complement?
ori=2;% =1 if use original wedge, else =2 for complement

% path to load DCT dictionary figures
if ori==1
    path_DCT_dictionary_data='DCT_Dictionary/data/ori';
else
    path_DCT_dictionary_data='DCT_Dictionary/data/compl';
end
% path to save correlation map figures
if ori==1
    path_corr_png='DCT_Dictionary/corr/png_figs/ori';
else
    path_corr_png='DCT_Dictionary/corr/png_figs/compl';
end
% path to save correlation map data
if ori==1
    path_corr_data='DCT_Dictionary/corr/data/ori';
else
    path_corr_data='DCT_Dictionary/corr/data/compl';
end

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
        
        % load DCT_dictionary
        filename=[path_DCT_dictionary_data,'/DCT_Dictionary_w',num2str(w),'_h',num2str(h),'.mat'];
        load(filename);
        
        % init
        cor_map=zeros(h,w,h,w);
        current_dictionary=zeros(h,w);
        temp_dictionary=zeros(h,w);
        
        for wtype=1:16
            for ipos_w=1:w
                for ipos_h=1:h
                    % compute correlations
                    current_dictionary(:,:)=DCT_Dictionary(wtype,ipos_h,ipos_w,:,:);
                    for itemp_w=1:w
                        for itemp_h=1:h
                            temp_dictionary(:,:)=DCT_Dictionary(wtype,itemp_h,itemp_w,:,:);
                            cor_map(ipos_h,ipos_w,itemp_h,itemp_w)=abs(corr2(current_dictionary,temp_dictionary));
                        end
                    end
                    
%                     % plot
%                     temp=zeros(h,w);
%                     temp(:,:)=cor_map(ipos_h,ipos_w,:,:);
%                     figure
%                     % set the size of figure to make sure every cell is a square
%                     if h==w
%                         set(gcf,'Position',[20,20,600,600]);
%                     elseif h==2*w
%                         set(gcf,'Position',[20,20,300,600]);
%                     elseif w==2*h
%                         set(gcf,'Position',[20,20,600,300]);
%                     elseif h==4*w
%                         set(gcf,'Position',[20,20,300,1200]);
%                     elseif w==4*h
%                         set(gcf,'Position',[20,20,1200,300]);
%                     end
%                     % plot heatmap, set value range here
%                     if w==8&&h==8 % show values in the cell
%                         img=heatmap(temp,'ColorLimits',[0 1],'ColorMap',cvar,'ColorbarVisible','off');
%                         img.CellLabelFormat='%0.2f';
%                     else
%                         img=heatmap(temp,'ColorLimits',[0 1],'ColorMap',cvar,'ColorbarVisible','off','CellLabelColor','none');
%                     end
%                     % make x and y labels unvisible
%                     if iw==1
%                         img.XDisplayLabels ={'','','','','','','',''};
%                     elseif iw==2
%                         img.XDisplayLabels ={'','','','','','','','','','','','','','','',''};
%                     else
%                         img.XDisplayLabels ={'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''};
%                     end
%                     if ih==1
%                         img.YDisplayLabels ={'','','','','','','',''};
%                     elseif ih==2
%                         img.YDisplayLabels ={'','','','','','','','','','','','','','','',''};
%                     else
%                         img.YDisplayLabels ={'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''};
%                     end
%                     % make sure every cell is a square
%                     set(gcf,'windowstyle','normal')
%                     img.Position =[0 0 1 1];
%                     
%                     % save file
%                     filename_fig=[path_corr_png,'/w', num2str(w),'_h', num2str(h), '/wedge_type', num2str(wtype),'/y',num2str(ipos_h), '_x',num2str(ipos_w)];
%                     saveas(gcf,filename_fig,'png')
%                     close(gcf);
                end
            end
            % save correlation map data
            filemane_corr=[path_corr_data,'/corr_w',num2str(w),'_h',num2str(h),'_wtype',num2str(wtype),'.mat'];
            save(filemane_corr,'cor_map')
        end
    end
end
                    
        
        
        