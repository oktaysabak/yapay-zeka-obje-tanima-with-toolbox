adet=[3 6 2];  
girisler=[0 0 0;0 0 1;0 1 0;0 1 1;1 0 0;1 0 1;1 1 0;1 1 1];
cikislar=[0 0;1 0;1 0;0 1;1 0;0 1;0 1;1 1];
hata_payi=1e-1; 
[W ,B]= ag_olustur(adet); 
[W ,B, hata]= ag_egit(girisler,cikislar,W,B,adet,hata_payi); 

sonuc=zeros(size(cikislar));
for i=1:size(sonuc,1)
sonuc(i,:)=ag_sina(girisler(i,:),W,B,adet,'yazdir'); 
end
