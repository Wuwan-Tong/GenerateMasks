% init
% load('DCT_Dictionary');
block_size_w=[8 16 32];
block_size_h=[8 16 32];
smooth='sharp/'; % 'smooth/'; or 'sharp/';
ori=1;% if use original wedge, else =2 for complement
cvar=1-gray;


for iw=2%1:length(block_size_w)
    for ih=3%1:length(block_size_h)
        % init
        w=block_size_w(iw);
        h=block_size_h(ih);
        filename=['DCT_Dictionary/data/DCT_Dictionary_w',num2str(w),'_h',num2str(h),'.mat'];
        load(filename);
        cor_map=zeros(h,w,h,w);
        current_dictionary=zeros(h,w);
        temp_dictionary=zeros(h,w);
        for wtype=1:16
            for ipos_w=1:w
                for ipos_h=1:h
                    current_dictionary(:,:)=DCT_Dictionary(wtype,ipos_h,ipos_w,:,:);
                    for itemp_w=1:w
                        for itemp_h=1:h
                            temp_dictionary(:,:)=DCT_Dictionary(wtype,itemp_h,itemp_w,:,:);
                            cor_map(ipos_h,ipos_w,itemp_h,itemp_w)=abs(corr2(current_dictionary,temp_dictionary));
                        end
                    end
%                     plot
                    temp=zeros(h,w);
                    temp(:,:)=cor_map(ipos_h,ipos_w,:,:);
                    figure
                    set(gcf,'Position',[20,20,600,1200]);
%                     set(gcf,'Position',[20,20,800,400]);
%                     set(gcf,'Position',[20,20,800,800]);
%                     set(gcf,'Position',[20,20,500,500]);
%                     set(gcf,'Position',[20,20,300,1200]);

                    img=heatmap(temp,'ColorLimits',[0 1],'ColorMap',cvar);
                    img.XDisplayLabels ={'','','','','','','','','','','','','','','',''};
                    img.YDisplayLabels ={'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''};
                    img.CellLabelFormat='%0.2f';
                    set(gcf,'windowstyle','normal')
                    img.Position =[0 0 1 1];
                    filename_fig=['DCT_Dictionary/corr/png_figs/w', num2str(w),'_h', num2str(h), '/wedge_type', num2str(wtype),'/y',num2str(ipos_h), '_x',num2str(ipos_w)];
                    saveas(gcf,filename_fig,'png')
                    close(gcf);
                end
            end
%             filemane_corr=['DCT_Dictionary/corr/data/corr_w',num2str(w),'_h',num2str(h),'_wtype',num2str(wtype),'.mat'];
%             save(filemane_corr,'cor_map')
        end
    end
end
                    
        
        
        