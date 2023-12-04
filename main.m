%fixed values
MAX_WEDGE_TYPES=16;
BLOCK_SIZES_ALL=22;
MAX_WEDGE_SIZE_LOG2=5;
MAX_WEDGE_SIZE=2^MAX_WEDGE_SIZE_LOG2;
MASK_MASTER_SIZE=MAX_WEDGE_SIZE*2;
MASK_MASTER_STRIDE=MASK_MASTER_SIZE;

av1_wedge_params_lookup = create_av1_wedge_params_lookup();
BLOCK_SIZE=1:1:BLOCK_SIZES_ALL;% [1-BLOCK_4X4, 2-BLOCK_4X8, 3-BLOCK_8X4, 4-BLOCK_8X8, 5-BLOCK_8X16, 6-BLOCK_16X8, 
                  % 7-BLOCK_16X16, 8-BLOCK_16X32, 9-BLOCK_32X16, 10-BLOCK_32X32, 11-BLOCK_32X64,
                  % 12-BLOCK_64X32, 13-BLOCK_64X64, 14-BLOCK_64X128, 15-BLOCK_128X64, 16-BLOCK_128X128, 
                  % 17-BLOCK_4X16, 18-BLOCK_16X4, 19-BLOCK_8X32, 20-BLOCK_32X8, 21-BLOCK_16X64, 22-BLOCK_64X16]
wedge_masks=zeros(BLOCK_SIZES_ALL,2,MAX_WEDGE_TYPES);
block_size_wide=[4,  4,  8,  8,   8,   16, 16, 16, 32, 32, 32, 64, 64, 64, 128, 128, 4,  16, 8,  32, 16, 64];
block_size_high=[4,  8,  4,   8,  16,  8,  16, 32, 16, 32, 64, 32, 64, 128, 64, 128, 16, 4,  32, 8,  64, 16];

% calculation start
for bsize=1:BLOCK_SIZES_ALL
    % take init wtypes to check if masks are calculated for current block size
    wedge_params=av1_wedge_params_lookup(bsize,:);
    wtypes=cell2mat(wedge_params(1));
    if wtypes==0
        continue;
    end
    % size of current block 
    bw = block_size_wide(bsize);
    bh = block_size_high(bsize);
    
    dst=zeros(1,bh*bw);% dst to save mask in shape [1,bw*bh]
    masks_save=zeros(2,MAX_WEDGE_TYPES,bh,bw);% init to be saved masks, shape:[1=pos&2=neg,idx of wedge types,mask column, mask row]
    for w=1:wtypes
        % compute mask(master) from init fixed variables 
        mask=get_wedge_mask_inplace(w, 0, bsize);
         % copy mask from master(mask is a part of master)
        for r=0:bh-1
            dst(1,bw*r+1:bw*r+bw)=mask(1,MASK_MASTER_STRIDE*r+1:MASK_MASTER_STRIDE*r+bw);
        end
        % save mask
        mask_save=reshape(dst,[bw bh])';
        masks_save(1,w,1:bh,1:bw)=mask_save(:,:);
        
        % compute mask(master) from init fixed variables 
        mask=get_wedge_mask_inplace(w, 1, bsize);
        % copy mask from master(mask is a part of master)
        for r=0:bh-1
            dst(1,bw*r+1:bw*r+bw)=mask(1,MASK_MASTER_STRIDE*r+1:MASK_MASTER_STRIDE*r+bw);
        end
        % save mask
        mask_save=reshape(dst,[bw bh])';
        masks_save(2,w,1:bh,1:bw)=mask_save(:,:);
    end
    % save file
    save(['masks/masks_w' num2str(bw) '_h' num2str(bh)],'masks_save');
end




