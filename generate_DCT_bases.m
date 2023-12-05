D=dctmtx(8);
DCT_basis=zeros(64,64);
for i=0:7
    for j=0:7
        DCT_basis(i*8+1:i*8+8,j*8+1:j*8+8)=transpose(D(:,j+1)*D(i+1,:));
    end
end
heatmap(DCT_basis)