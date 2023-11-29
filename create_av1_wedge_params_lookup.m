function [av1_wedge_params_lookup] = create_av1_wedge_params_lookup()
%% set param
MAX_WEDGE_TYPES=16;
BLOCK_SIZES_ALL=22;

wedge_signflip_lookup=[[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
                       [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
                       [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
                       [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 1];
                       [1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 1];
                       [1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 1];
                       [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 1];
                       [1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 1];
                       [1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 1];
                       [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 1];
                       [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
                       [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
                       [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
                       [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
                       [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
                       [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
                       [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
                       [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
                       [1, 1, 1, 1, 0, 1, 1, 1, 0, 1, 0, 1, 1, 1, 0, 1];
                       [1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 0, 1, 0, 1];
                       [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
                       [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]];

wedge_masks=zeros(BLOCK_SIZES_ALL,2,MAX_WEDGE_TYPES,128*128);

% WEDGE_DIRECTIONS
WEDGE_HORIZONTAL = 0;
WEDGE_VERTICAL = 1;
WEDGE_OBLIQUE27 = 2;
WEDGE_OBLIQUE63 = 3;
WEDGE_OBLIQUE117 = 4;
WEDGE_OBLIQUE153 = 5;
wedge_codebook_16_heqw=[[WEDGE_OBLIQUE27, 4, 4];
                        [WEDGE_OBLIQUE63, 4, 4];
                        [WEDGE_OBLIQUE117, 4, 4];
                        [WEDGE_OBLIQUE153, 4, 4];
                        [WEDGE_HORIZONTAL, 4, 2];
                        [WEDGE_HORIZONTAL, 4, 6];
                        [WEDGE_VERTICAL, 2, 4];
                        [WEDGE_VERTICAL, 6, 4];
                        [WEDGE_OBLIQUE27, 4, 2];
                        [WEDGE_OBLIQUE27, 4, 6];
                        [WEDGE_OBLIQUE153, 4, 2];
                        [WEDGE_OBLIQUE153, 4, 6];
                        [WEDGE_OBLIQUE63, 2, 4];
                        [WEDGE_OBLIQUE63, 6, 4];
                        [WEDGE_OBLIQUE117, 2, 4];
                        [WEDGE_OBLIQUE117, 6, 4]];

wedge_codebook_16_hgtw=[[WEDGE_OBLIQUE27, 4, 4];
                        [WEDGE_OBLIQUE63, 4, 4];
                        [WEDGE_OBLIQUE117, 4, 4];
                        [WEDGE_OBLIQUE153, 4, 4];
                        [WEDGE_HORIZONTAL, 4, 2];
                        [WEDGE_HORIZONTAL, 4, 4];
                        [WEDGE_HORIZONTAL, 4, 6];
                        [WEDGE_VERTICAL, 4, 4];
                        [WEDGE_OBLIQUE27, 4, 2];
                        [WEDGE_OBLIQUE27, 4, 6];
                        [WEDGE_OBLIQUE153, 4, 2];
                        [WEDGE_OBLIQUE153, 4, 6];
                        [WEDGE_OBLIQUE63, 2, 4];
                        [WEDGE_OBLIQUE63, 6, 4];
                        [WEDGE_OBLIQUE117, 2, 4];
                        [WEDGE_OBLIQUE117, 6, 4]];
wedge_codebook_16_hltw=[[WEDGE_OBLIQUE27, 4, 4];
                        [WEDGE_OBLIQUE63, 4, 4];
                        [WEDGE_OBLIQUE117, 4, 4];
                        [WEDGE_OBLIQUE153, 4, 4];
                        [WEDGE_VERTICAL, 2, 4];
                        [WEDGE_VERTICAL, 4, 4];
                        [WEDGE_VERTICAL, 6, 4];
                        [WEDGE_HORIZONTAL, 4, 4];
                        [WEDGE_OBLIQUE27, 4, 2];
                        [WEDGE_OBLIQUE27, 4, 6];
                        [WEDGE_OBLIQUE153, 4, 2];
                        [WEDGE_OBLIQUE153, 4, 6];
                        [WEDGE_OBLIQUE63, 2, 4];
                        [WEDGE_OBLIQUE63, 6, 4];
                        [WEDGE_OBLIQUE117, 2, 4];
                        [WEDGE_OBLIQUE117, 6, 4]];


%%
av1_wedge_params_lookup={0,NaN,NaN,NaN; %not used
                         0,NaN,NaN,NaN; %not used
                         0,NaN,NaN,NaN; %not used
                         MAX_WEDGE_TYPES,wedge_codebook_16_heqw,wedge_signflip_lookup(4,:),wedge_masks(4,:,:,:);
                         MAX_WEDGE_TYPES,wedge_codebook_16_hgtw,wedge_signflip_lookup(5,:),wedge_masks(5,:,:,:);
                         MAX_WEDGE_TYPES,wedge_codebook_16_hltw,wedge_signflip_lookup(6,:),wedge_masks(6,:,:,:);
                         MAX_WEDGE_TYPES,wedge_codebook_16_heqw,wedge_signflip_lookup(7,:),wedge_masks(7,:,:,:);
                         MAX_WEDGE_TYPES,wedge_codebook_16_hgtw,wedge_signflip_lookup(8,:),wedge_masks(8,:,:,:);
                         MAX_WEDGE_TYPES,wedge_codebook_16_hltw,wedge_signflip_lookup(9,:),wedge_masks(9,:,:,:);
                         MAX_WEDGE_TYPES,wedge_codebook_16_heqw,wedge_signflip_lookup(10,:),wedge_masks(10,:,:,:);
                         0,NaN,NaN,NaN; %not used
                         0,NaN,NaN,NaN; %not used
                         0,NaN,NaN,NaN; %not used
                         0,NaN,NaN,NaN; %not used
                         0,NaN,NaN,NaN; %not used
                         0,NaN,NaN,NaN; %not used
                         0,NaN,NaN,NaN; %not used
                         0,NaN,NaN,NaN; %not used
                         MAX_WEDGE_TYPES,wedge_codebook_16_hgtw,wedge_signflip_lookup(19,:),wedge_masks(19,:,:,:);
                         MAX_WEDGE_TYPES,wedge_codebook_16_hltw,wedge_signflip_lookup(20,:),wedge_masks(20,:,:,:);
                         0,NaN,NaN,NaN; %not used
                         0,NaN,NaN,NaN}; %not used
end

