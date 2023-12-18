%% run this file to get coherrence data
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
    path_coh_data='DCT_Dictionary/coh/ori';
else
    path_coh_data='DCT_Dictionary/coh/compl';
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
                    % get max correlation each sub block
                    max_map(ipos_h,ipos_w)=max(max(abs(temp_block)));
                end
            end
            % get max correlation
            coh(1,wtype)=max(max(max_map));
        end
        
        % save coherence
        filename_coh=[path_coh_data,'/coherence_w',num2str(w),'_h',num2str(h)];
        save(filename_coh,'coh')
    end
end




