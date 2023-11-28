function [master] = get_wedge_mask_inplace(wedge_index,neg,sb_type)
block_size_wide=[4,  4,  8,  8,   8,   16, 16, 16, 32, 32, 32, 64, 64, 64, 128, 128, 4,  16, 8,  32, 16, 64];
block_size_high=[4,  8,  4,   8,  16,  8,  16, 32, 16, 32, 64, 32, 64, 128, 64, 128, 16, 4,  32, 8,  64, 16];
WEDGE_DIRECTIONS=6;
MAX_WEDGE_SIZE_LOG2=5;
MAX_WEDGE_SIZE=2^MAX_WEDGE_SIZE_LOG2;
MASK_MASTER_SIZE=MAX_WEDGE_SIZE*2;
MASK_MASTER_STRIDE=MASK_MASTER_SIZE;
wedge_mask_obl=zeros(2,WEDGE_DIRECTIONS,MASK_MASTER_SIZE*MASK_MASTER_SIZE);

bh = block_size_high(sb_type);
bw = block_size_wide(sb_type);

av1_wedge_params_lookup = create_av1_wedge_params_lookup();
codebook=cell2mat(av1_wedge_params_lookup(sb_type,2));
a=codebook(wedge_index,:);
signflip=cell2mat(av1_wedge_params_lookup(sb_type,3));
wsignflip=signflip(wedge_index);

if wedge_index<0 ||wedge_index>cell2mat(av1_wedge_params_lookup(sb_type,1))
    print('ERROR! wrong wedge_index')
end
woff=(a(2)*bw)/8;
hoff=(a(3)*bh)/8;
master=wedge_mask_obl(neg^wsignflip+1,a(1)+1,MASK_MASTER_STRIDE*(MASK_MASTER_SIZE/2-hoff)+MASK_MASTER_SIZE / 2 - woff);
% todo: init wedge_mask_obl
end

