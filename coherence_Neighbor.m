%% run this file to get coherence data wothout considering its vertical and horizontal neighbors
% set up the path to load correlation map data and to save coherence data
%% set parameters
% use original mask or complement?
ori=1;% if use original wedge, else =2 for complement

% path to load correlation map data
if ori==1
    path_corr_data='DCT_Dictionary/corr/data/ori';
else
    path_corr_data='DCT_Dictionary/corr/data/compl';
end
% path to save coherence data
if ori==1
    path_cohNei_data='DCT_Dictionary/coh_Nei/ori';
else
    path_cohNei_data='DCT_Dictionary/coh_Nei/compl';
end

% set block size
block_size_w=[8 16 32];
block_size_h=[8 16 32];

%%
% init coh to save the coherence
coh=zeros(1,16);

for iw=1:length(block_size_w)
    for ih=1:length(block_size_h)
        w=block_size_w(iw);
        h=block_size_h(ih);
        % init
        max_map=zeros(h,w);
        temp_block=zeros(h,w);
        
        for wtype=1:16
            % load correlation
            filemane_corr=[path_corr_data,'/corr_w',num2str(w),'_h',num2str(h),'_wtype',num2str(wtype),'.mat'];
            load(filemane_corr) % =cor_map
            
            for ipos_w=1:w
                for ipos_h=1:h
                    % compute coherence
                    temp_block(:,:)=cor_map(ipos_h,ipos_w,:,:);
                    temp_block(ipos_h,ipos_w)=0; % ignore it self
                    % ignore neighbors
                    temp_block(max(ipos_h-1,1),ipos_w)=0;
                    temp_block(min(ipos_h+1,h),ipos_w)=0;
                    temp_block(ipos_h,max(ipos_w-1,1))=0;
                    temp_block(ipos_h,min(ipos_w+1,w))=0;
                    % get max correlation each sub block
                    max_map(ipos_h,ipos_w)=max(max(abs(temp_block)));
                end
            end
            % get max correlation
            coh(1,wtype)=max(max(max_map));
        end
        
        % save coherence
        filename_coh=[path_cohNei_data,'/coherence_Nei_w',num2str(w),'_h',num2str(h)];
        save(filename_coh,'coh')
    end
end




