w=8;
h=8;
temp_mask=zeros(h,w);
for i=1:16
    temp_mask(:,:)=masks_save(1,i,:,:);
    figure
    heatmap(temp_mask,'ColorLimits',[0 64])
    tlt=['w=', num2str(w),', h=', num2str(h), ', wedge type=', num2str(i)];
    title(tlt)
end

