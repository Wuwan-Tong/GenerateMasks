% init
block_size_w=[8 16 32];
block_size_h=[8 16 32];
coh=zeros(1,16);
for iw=1:length(block_size_w)
    for ih=1:length(block_size_h)
        % init
        w=block_size_w(iw);
        h=block_size_h(ih);
        max_map=zeros(h,w);
        temp_block=zeros(h,w);
        for wtype=1:16
            filemane_corr=['DCT_Dictionary/corr/corr_w',num2str(w),'_h',num2str(h),'_wtype',num2str(wtype),'.mat'];
            load(filemane_corr) % =cor_map
            for ipos_w=1:w
                for ipos_h=1:h
                    temp_block(:,:)=cor_map(ipos_h,ipos_w,:,:);
                    temp_block(ipos_h,ipos_w)=0;
                    max_map(ipos_h,ipos_w)=max(max(abs(temp_block)));
                end
            end
            coh(1,wtype)=max(max(max_map));
        end
        filename_coh=['DCT_Dictionary/coh/coherence_w',num2str(w),'_h',num2str(h)];
        save(filename_coh,'coh')
    end
end




