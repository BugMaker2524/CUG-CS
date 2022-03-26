function DE(Gm,F0)  
t0 = cputime;  %�㷨��ʼʱ��
%��ֽ����㷨����  
Gm = 8000;  %Gm ���������� 
F0 = 0.5;  %F0�Ǳ�����
Np = 100;  %��Ⱥ��С
CR = 0.9;  %�������  
G= 1; %��ʼ������  
D = 10; %���������ά��  
Gmin = zeros(1,Gm); %����������ֵ  
best_x = zeros(Gm,D); %���������Ž�  
value = zeros(1,Np);  %������Ⱥ

xmin = -5.12;  %�½�
xmax = 5.12;   %�Ͻ�

function y = f(v)  
%Rastrigr ����  
y = sum(v.^2 - 10.*cos(2.*pi.*v) + 10);  
end  

X0 = (xmax-xmin)*rand(Np,D) + xmin;  %����Np��Dά����  
XG = X0;  
XG_next_1= zeros(Np,D); %��ʼ��  
XG_next_2 = zeros(Np,D);  
XG_next = zeros(Np,D);  

while G <= Gm   
%%%%%%%%%%%%%%%%%%%%%%%%----�������----%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
    for i = 1:Np  
        %����j,k,p������ͬ����  
        a = 1;  
        b = Np;  
        dx = randperm(b-a+1) + a- 1;  
        j = dx(1);  
        k = dx(2);  
        p = dx(3);  
        %Ҫ��֤��i��ͬ  
        if j == i  
            j  = dx(4);  
            else if k == i  
                 k = dx(4);  
                else if p == i  
                    p = dx(4);  
                    end  
                end  
         end  
        %��������  
        suanzi = exp(1-Gm/(Gm + 1-G));  
        F = F0*2.^suanzi;  
        %����ĸ������������������  
        son = XG(p,:) + F*(XG(j,:) - XG(k,:));         
        for j = 1: D  
            if son(1,j) >xmin  & son(1,j) < xmax %��ֹ���쳬���߽�  
                XG_next_1(i,j) = son(1,j);  
            else  
                XG_next_1(i,j) = (xmax - xmin)*rand(1) + xmin;  
            end  
        end  
    end  
   %%%%%%%%%%%%%%%%%%%%%%%---�������----%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
    for i = 1: Np  
        randx = randperm(D);% [1,2,3,...D]���������     
        for j = 1: D  
              
            if rand > CR & randx(1) ~= j % CR = 0.9   
                XG_next_2(i,j) = XG(i,j);  
            else  
                XG_next_2(i,j) = XG_next_1(i,j);  
            end  
        end  
    end  
    %%%%%%%%%%%%%%%%%%----ѡ�����---%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
    for i = 1:Np  
        if f(XG_next_2(i,:)) < f(XG(i,:))  
              
            XG_next(i,:) = XG_next_2(i,:);  
        else  
            XG_next(i,:) = XG(i,:);  
        end  
    end  
    %�ҳ���Сֵ  
    for i = 1:Np  
        value(i) = f(XG_next(i,:));  
    end  
    [value_min,pos_min] = min(value);  
    %��G���е�Ŀ�꺯������Сֵ  
    Gmin(G) = value_min;     
    %�������ŵĸ���  
    best_x(G,:) = XG_next(pos_min,:);    
    XG = XG_next;      
    trace(G,1) = G;  
    trace(G,2) = value_min;  
    G = G + 1;  
end  
  [value_min,pos_min] = min(Gmin);  
  best_value = value_min  
  best_vector =  best_x(pos_min,:)    
  fprintf('DE���ĵ�ʱ��Ϊ��%f \n',cputime - t0);  
  %�������������ź���ֵ֮��Ĺ�ϵͼ    
  plot(trace(:,1),trace(:,2));   
end  