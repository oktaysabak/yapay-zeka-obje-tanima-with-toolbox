function [W,B,hata] = ag_egit(girisler,cikislar,W,B,adet,hata_payi) 
a=0.7;	
b=0.3;	
T=1;	
j=0;
for i=2:size(adet,2)
    j=j+(adet(i-1)*adet(i));
end
deg_W=zeros(j,1);
X=zeros(sum(adet),1);
deg_B=zeros(sum(adet),1);
hata_sayac=0;
hata=[];

while true
hata_sayac=hata_sayac+1;
hata(hata_sayac)=0;
for dongu=1:size(girisler,1)
beklenen=cikislar(dongu,:);
X(1:adet(1))=girisler(dongu,:);
noron=adet(1)+1;
weyt=1;
beta=adet(1)+1;
z=0;
for k=1:(size(adet,2)-1)
    for asdf=1:adet(k+1)
        ag=0;
        for i=1:adet(k)
            ag=ag+(X(z+i)*W(weyt));
            weyt=weyt+1;
        end
        ag=ag+(T*B(beta));
        X(noron)=logsig(ag);
        noron=noron+1;
        beta=beta+1;
    end
    z=z+adet(k);
end
weyt=weyt-1;
yeni_hata=hata_hesapla(X,beklenen);
if yeni_hata>hata(hata_sayac)
hata(hata_sayac)=yeni_hata;
end

S=zeros(sum(adet),1);
z=sum(adet);
i=adet(size(adet,2));
while z>(sum(adet)-adet(size(adet,2)))
S(z)=(beklenen(i)-X(z))*X(z)*(1-X(z));
z=z-1;
i=i-1;
end
weyt2=weyt;
weyt3=weyt;
yedek_weyt=weyt;
for k=(size(adet,2)-1):-1:2
for i=1:adet(k)
S(z)=X(z)*(1-X(z));
Ssum=0;
for j=sum(adet(1:k+1)):-1:(sum(adet(1:k))+1)
Ssum=Ssum+(S(j)*W(weyt2));
weyt2=weyt2-adet(k);
end
S(z)=S(z)*Ssum;
z=z-1;
weyt=weyt-1;
weyt3=weyt2;
weyt2=weyt;
end
weyt2=weyt3;
weyt=weyt3;
end
weyt=yedek_weyt;


z=sum(adet);
noron=z-adet(size(adet,2));
for k=(size(adet,2)-1):-1:1
for j=0:(adet(k+1)-1)
for i=0:(adet(k)-1)
deg_W(weyt)=(a*X(noron-i)*S(z-j))+(b*deg_W(weyt));
weyt=weyt-1;
end
end
z=noron;
noron=noron-adet(k);
end


for i=(adet(1)+1):sum(adet)
deg_B(i)=(a*S(i))+(b*deg_B(i));
end


W=W+deg_W;
B=B+deg_B;

end	%for


if hata(hata_sayac)<=hata_payi
break;
end

end	
figure, subplot(2,1,1);
plot(hata,'cyan','LineWidth',3);
xlabel('Iterasyon','FontSize',12,'FontWeight','bold');
ylabel('Hata','FontSize',12,'FontWeight','bold');
xlim([1 size(hata,2)]);

sonuc=zeros(size(cikislar));
for i=1:size(sonuc,1)
sonuc(i,:)=ag_sina(girisler(i,:),W,B,adet,'yazdirma');
end

subplot(2,1,2);
h1=plot(cikislar,'r');
hold on;
h2=plot(sonuc,'*-');
xlabel('Ýndis','FontSize',11,'FontWeight','bold');
ylabel('Deðer','FontSize',11,'FontWeight','bold');
ylim([-0.5 max(cikislar(:))+0.6]);
legend([h1(1),h2(1)],'Beklenen','Að Çýktýlarý','Location','northwest');

end	

