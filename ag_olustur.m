function [W,B]= ag_olustur(adet)

B=unifrnd (-1,1,[sum(adet),1]);
toplam=0;
for i=1:(size(adet,2)-1)
toplam=toplam+(adet(i)*adet(i+1));
end
W=unifrnd (-1,1,[toplam,1]);

end