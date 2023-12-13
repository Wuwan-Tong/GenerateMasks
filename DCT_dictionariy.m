%% run this file to generate DCT dictionary, 
% set the path to load DCT bases and masks, set the path to save DCT_Dictionary data and .png figures
%% set parameters
% use original mask or complement?
ori=1;% =1 if use original wedge, else =2 for complement

% path where DCT bases are saved
path_DCT_bases='DCT_bases/data';
% path where masks are saved
path_sharp_mask='masks/sharp';

% path to save DCT dictionary figures
if ori==1
    path_DCT_dictionary_png='DCT_Dictionary/png_figs/ori';
else
    path_DCT_dictionary_png='DCT_Dictionary/png_figs/compl';
end
% path to save DCT dictionary data
if ori==1
    path_DCT_dictionary_data='DCT_Dictionary/data/ori';
else
    path_DCT_dictionary_data='DCT_Dictionary/data/compl';
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
        
        % init
        DCT_Dictionary=zeros(16,h,w,h,w);
        wedge_current=zeros(h,w);
        DCT_Dictionary_current=zeros(h,w);
        
        % load DCT bases
        filename_DCT=[path_DCT_bases,'/DCT_bases_w',num2str(w),'_h',num2str(h),'.mat'];
        DCT_bases=cell2mat(struct2cell(load(filename_DCT)));
        
        % load masks
        filename_wedge=[path_sharp_mask,'/masks_w',num2str(w),'_h',num2str(h),'.mat'];
        wedge_all=cell2mat( struct2cell(load(filename_wedge)));
               
        for wtype=1:16
            for ipos_w=1:w
                for ipos_h=1:h
                    % combine DCT bases with masks
                    % first copy DCT bases to the init dictionary
                    DCT_Dictionary_current(:,:)=DCT_bases((ipos_h-1)*h+1:ipos_h*h,(ipos_w-1)*w+1:ipos_w*w);
                    % set wedge to 0 or 1s
                    wedge_current(:,:)=wedge_all(ori,wtype,:,:)/64;
                    % combine DCT bases with masks and normalize
                    DCT_Dictionary(wtype,ipos_h,ipos_w,:,:)=(DCT_Dictionary_current.*wedge_current)/norm(DCT_Dictionary_current.*wedge_current);
                    
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
                    img=heatmap((DCT_Dictionary_current.*wedge_current)/norm(DCT_Dictionary_current.*wedge_current),'ColorLimits',[-1 1],'ColorMap',cvar,'ColorbarVisible','off');
                    img.CellLabelFormat='%0.2f';
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
                    filename=[path_DCT_dictionary_png,'/w', num2str(w),'_h', num2str(h),'/y', num2str(ipos_h),'_x', num2str(ipos_w),'_wtype',num2str(wtype)];
                    saveas(gcf,filename,'png')
                    close(gcf);
                end
            end
        end
        
        % save the data
        filename=[path_DCT_dictionary_data,'/DCT_Dictionary_w',num2str(w),'_h',num2str(h),'.mat'];
        save(filename,'DCT_Dictionary');
    end
end
                
        
        
        