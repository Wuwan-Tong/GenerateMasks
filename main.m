av1_wedge_params_lookup = create_av1_wedge_params_lookup();
BLOCK_SIZE=1:1:22;% [1-BLOCK_4X4, 2-BLOCK_4X8, 3-BLOCK_8X4, 4-BLOCK_8X8, 5-BLOCK_8X16, 6-BLOCK_16X8, 
                  % 7-BLOCK_16X16, 8-BLOCK_16X32, 9-BLOCK_32X16, 10-BLOCK_32X32, 11-BLOCK_32X64,
                  % 12-BLOCK_64X32, 13-BLOCK_64X64, 14-BLOCK_64X128, 15-BLOCK_128X64, 16-BLOCK_128X128, 
                  % 17-BLOCK_4X16, 18-BLOCK_16X4, 19-BLOCK_8X32, 20-BLOCK_32X8, 21-BLOCK_16X64, 22-BLOCK_64X16]
wedge_masks=zeros(BLOCK_SIZES_ALL,2,MAX_WEDGE_TYPES);
block_size_wide=[4,  4,  8,  8,   8,   16, 16, 16, 32, 32, 32, 64, 64, 64, 128, 128, 4,  16, 8,  32, 16, 64];
block_size_high=[4,  8,  4,   8,  16,  8,  16, 32, 16, 32, 64, 32, 64, 128, 64, 128, 16, 4,  32, 8,  64, 16];
for bsize=1:22
    wedge_params=av1_wedge_params_lookup(bsize,:);
    wtypes=wedge_params(1);
    if wtypes==0
        continue;
    end
    bw = block_size_wide(bsize);
    bh = block_size_high(bsize);
    for w=1:wtypes
        mask=get_wedge_mask_inplace(w, 0, bsize);
    end
        
end



