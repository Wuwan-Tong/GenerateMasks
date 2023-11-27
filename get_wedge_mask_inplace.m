function [master] = get_wedge_mask_inplace(wedge_index,neg,sb_type)
block_size_wide=[4,  4,  8,  8,   8,   16, 16, 16, 32, 32, 32, 64, 64, 64, 128, 128, 4,  16, 8,  32, 16, 64];
block_size_high=[4,  8,  4,   8,  16,  8,  16, 32, 16, 32, 64, 32, 64, 128, 64, 128, 16, 4,  32, 8,  64, 16];
bh = block_size_high(sb_type);
bw = block_size_wide(sb_type);
end

