function [master_pos,wedge_mask_obl_2D] = get_wedge_mask_inplace_sharp(wedge_index,neg,sb_type)
% fixed values
block_size_wide=[4,  4,  8,  8,   8,   16, 16, 16, 32, 32, 32, 64, 64, 64, 128, 128, 4,  16, 8,  32, 16, 64];
block_size_high=[4,  8,  4,   8,  16,  8,  16, 32, 16, 32, 64, 32, 64, 128, 64, 128, 16, 4,  32, 8,  64, 16];
WEDGE_DIRECTIONS=6;
MAX_WEDGE_SIZE_LOG2=5;
MAX_WEDGE_SIZE=2^MAX_WEDGE_SIZE_LOG2;
MASK_MASTER_SIZE=MAX_WEDGE_SIZE*2;
MASK_MASTER_STRIDE=MASK_MASTER_SIZE;
wedge_master_vertical=zeros(1,64);
wedge_master_vertical(33:64)=64;
wedge_master_oblique_even=wedge_master_vertical;
wedge_master_oblique_odd=wedge_master_vertical;
stride=MASK_MASTER_STRIDE;
h=MASK_MASTER_SIZE;
w=MASK_MASTER_SIZE;
WEDGE_WEIGHT_BITS=6;
WEDGE_HORIZONTAL = 0;
WEDGE_VERTICAL=1;
WEDGE_OBLIQUE27 = 2;
WEDGE_OBLIQUE63 = 3;
WEDGE_OBLIQUE117 = 4;
WEDGE_OBLIQUE153 = 5;

wedge_mask_obl=zeros(2,WEDGE_DIRECTIONS,MASK_MASTER_SIZE*MASK_MASTER_SIZE);% init wedge_mask_obl

shift=h/4;
for i=0:2:h-1
    % if shift>0, shift right, fill left positions with wedge_master_oblique_even/odd(1)
    % if shift<0, shift left, fill right positions with wedge_master_oblique_even/odd(end)
    % shift_copy(), even h
    if shift>=0
        % memset()
        wedge_mask_obl(1,WEDGE_OBLIQUE63+1,i*stride+1:i*stride+shift)=wedge_master_oblique_even(1)*ones(1,shift);
        % memcpy()
        wedge_mask_obl(1,WEDGE_OBLIQUE63+1,i*stride+1+shift:i*stride+MASK_MASTER_SIZE)=wedge_master_oblique_even(1:MASK_MASTER_SIZE-shift);
    else
        shift=-shift;
        % memset()
        wedge_mask_obl(1,WEDGE_OBLIQUE63+1,i*stride+1+MASK_MASTER_SIZE-shift:i*stride+MASK_MASTER_SIZE)=wedge_master_oblique_even(MASK_MASTER_SIZE)*ones(1,shift);
        % memcpy()
        wedge_mask_obl(1,WEDGE_OBLIQUE63+1,i*stride+1:i*stride+MASK_MASTER_SIZE-shift)=wedge_master_oblique_even(1+shift:MASK_MASTER_SIZE);
        shift=-shift;
    end
    
    shift=shift-1;
    % shift_copy(), odd h
    if shift>=0
        % memset()
        wedge_mask_obl(1,WEDGE_OBLIQUE63+1,(i+1)*stride+1:(i+1)*stride+shift)=wedge_master_oblique_odd(1)*ones(1,shift);
        % memcpy()
        wedge_mask_obl(1,WEDGE_OBLIQUE63+1,(i+1)*stride+1+shift:(i+1)*stride+MASK_MASTER_SIZE)=wedge_master_oblique_odd(1:MASK_MASTER_SIZE-shift);
    else
        shift=-shift;
        % memset()
        wedge_mask_obl(1,WEDGE_OBLIQUE63+1,(i+1)*stride+1+MASK_MASTER_SIZE-shift:(i+1)*stride+MASK_MASTER_SIZE)=wedge_master_oblique_odd(MASK_MASTER_SIZE)*ones(1,shift);
        % memcpy()
        wedge_mask_obl(1,WEDGE_OBLIQUE63+1,(i+1)*stride+1:(i+1)*stride+MASK_MASTER_SIZE-shift)=wedge_master_oblique_odd(1+shift:MASK_MASTER_SIZE);
        shift=-shift;
    end        
    wedge_mask_obl(1,WEDGE_VERTICAL+1,(i)*stride+1:(i+1)*stride)=wedge_master_vertical(:);
    wedge_mask_obl(1,WEDGE_VERTICAL+1,(i+1)*stride+1:(i+2)*stride)=wedge_master_vertical(:);
end
for i=0:h-1
    for j=0:w-1
        msk=wedge_mask_obl(1,WEDGE_OBLIQUE63+1,i*stride+j+1);
        wedge_mask_obl(1,WEDGE_OBLIQUE27+1,j*stride+i+1)=msk;
        wedge_mask_obl(1,WEDGE_OBLIQUE153+1,(w-1-j)*stride+i+1)=2^WEDGE_WEIGHT_BITS-msk;
        wedge_mask_obl(1,WEDGE_OBLIQUE117+1,i*stride+w-j)=2^WEDGE_WEIGHT_BITS-msk; 
        wedge_mask_obl(2,WEDGE_OBLIQUE27+1,j*stride+i+1)=2^WEDGE_WEIGHT_BITS-msk;
        wedge_mask_obl(2,WEDGE_OBLIQUE63+1,i*stride+j+1)=2^WEDGE_WEIGHT_BITS-msk;
        wedge_mask_obl(2,WEDGE_OBLIQUE153+1,(w-1-j)*stride+i+1)=msk; 
        wedge_mask_obl(2,WEDGE_OBLIQUE117+1,i*stride+w-j)=msk;
        mskx=wedge_mask_obl(1,WEDGE_VERTICAL+1,i*stride+j+1);
        wedge_mask_obl(1,WEDGE_HORIZONTAL+1,j*stride+i+1)=mskx;
        wedge_mask_obl(2,WEDGE_HORIZONTAL+1,j*stride+i+1)=2^WEDGE_WEIGHT_BITS-mskx;
        wedge_mask_obl(2,WEDGE_VERTICAL+1,i*stride+j+1)=2^WEDGE_WEIGHT_BITS-mskx;
    end
end
% reshape every mask in wedge_mask_obl into 2d matrix
temp=zeros(1,MASK_MASTER_SIZE*MASK_MASTER_SIZE);
wedge_mask_obl_2D=zeros(2,6,MASK_MASTER_SIZE,MASK_MASTER_SIZE);
for i_neg=1:2
    for i_dir=1:6
        temp(:)=wedge_mask_obl(i_neg,i_dir,:);
        wedge_mask_obl_2D(i_neg,i_dir,:,:)=reshape(temp,[MASK_MASTER_SIZE MASK_MASTER_SIZE])';
    end
end
% size of the block 
bh = block_size_high(sb_type);
bw = block_size_wide(sb_type);
% init lookup table
av1_wedge_params_lookup = create_av1_wedge_params_lookup();
codebook=cell2mat(av1_wedge_params_lookup(sb_type,2));
a=codebook(wedge_index,:);
signflip=cell2mat(av1_wedge_params_lookup(sb_type,3));
wsignflip=signflip(wedge_index);

if wedge_index<0 ||wedge_index>cell2mat(av1_wedge_params_lookup(sb_type,1))
    print('ERROR! wrong wedge_index')
end

% offset of w and h
woff=(a(2)*bw)/8;
hoff=(a(3)*bh)/8;
% here the code is a bit different from C, because 0^1=0 in matlab but =1 in C
temp_sign=neg;
if wsignflip==1
    temp_sign=mod(neg+1,2);
end
% init return value master
% master=zeros(1,MASK_MASTER_STRIDE*bh);
% master(1,:)=wedge_mask_obl(temp_sign+1,a(1)+1,MASK_MASTER_STRIDE*(MASK_MASTER_SIZE/2-hoff)+MASK_MASTER_SIZE / 2 - woff+1:MASK_MASTER_STRIDE*(MASK_MASTER_SIZE/2-hoff)+MASK_MASTER_SIZE / 2 - woff+MASK_MASTER_STRIDE*bh);
master_pos=[temp_sign+1,a(1)+1,MASK_MASTER_SIZE/2-hoff,MASK_MASTER_SIZE / 2 - woff];
end

