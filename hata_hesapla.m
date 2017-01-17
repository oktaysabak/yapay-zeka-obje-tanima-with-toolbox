function hata=hata_hesapla(x,beklenen)
i=size(beklenen,1)*size(beklenen,2);
j=size(x,1)*size(x,2);
hata=zeros(i,1);
while i>0
hata(i)=abs(x(j)-beklenen(i));
i=i-1;
j=j-1;
end
hata=max(hata(:));
end