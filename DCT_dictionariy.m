%todo
block_size_w=[8 16 32];
block_size_h=[8 16 32];
smooth='sharp/'; % 'smooth/'; or 'sharp/';
ori=1;% if use original wedge, else =2 for complement
cvar=1-gray;
for iw=1:length(block_size_w)
    for ih=1:length(block_size_h)
        % init
        w=block_size_w(iw);
        h=block_size_h(ih);
        DCT_Dictionary=zeros(16,h,w,h,w);
        wedge_current=zeros(h,w);
        DCT_Dictionary_current=zeros(h,w);
        filename_DCT=['DCT_basis/DCT_basis_w',num2str(w),'_h',num2str(h),'.mat'];
        DCT_basis=cell2mat(struct2cell(load(filename_DCT)));
%         filename_wedge=['masks/',smooth,'masks_w',num2str(w),'_h',num2str(h),'.mat']; % smooth
        filename_wedge=['masks/',smooth,'masks_sharp_w',num2str(w),'_h',num2str(h),'.mat'];
        wedge_all=cell2mat( struct2cell(load(filename_wedge)));
        for wtype=1:16
            for ipos_w=1:w
                for ipos_h=1:h
                    DCT_Dictionary_current(:,:)=DCT_basis((ipos_h-1)*h+1:ipos_h*h,(ipos_w-1)*w+1:ipos_w*w);
                    wedge_current(:,:)=wedge_all(ori,wtype,:,:)/64;
                    DCT_Dictionary(wtype,ipos_h,ipos_w,:,:)=(DCT_Dictionary_current.*wedge_current)/norm(DCT_Dictionary_current.*wedge_current);
%                     figure
%                     heatmap((DCT_Dictionary_current.*wedge_current)/norm(DCT_Dictionary_current.*wedge_current),'ColorMap',cvar)
                end
            end
        end
        filename=['DCT_Dictionary/data/DCT_Dictionary_w',num2str(w),'_h',num2str(h),'.mat'];
        save(filename,'DCT_Dictionary');
    end
end
                
        
        
        