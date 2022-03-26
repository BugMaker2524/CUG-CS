%% 清空环境
clc
clear

%% 参数初始化
%粒子群算法中的两个加速度因子参数
c1 = 1.49445;
c2 = 1.49445;

maxgen=300;   %迭代次数  
sizepop=20;   %种群规模

Vmax=0.5;   %速度最大值
Vmin=-0.5;  %速度最小值
popmax=2;   %个体最大值
popmin=-2;  %个体最小值

%% 产生初始粒子和速度
for i=1:sizepop
    %随机产生一个种群
    pop(i,:)=2*rands(1,2);  %初始化粒子
    V(i,:)=0.5*rands(1,2);  %初始化速度
    %计算适应度
    fitness(i)=fun(pop(i,:));   %粒子的适应度
end

%% 个体极值和群体极值
[bestfitness bestindex]=max(fitness);
zbest=pop(bestindex,:);   %群体极值位置
gbest=pop;    %个体极值位置
fitnessgbest=fitness;   %个体极值适应度值
fitnesszbest=bestfitness;   %群体极值适应度值

%% 迭代寻优
for i=1:maxgen
    %粒子位置和速度更新
    for j=1:sizepop
        
        %速度更新
        V(j,:) = V(j,:) + c1*rand*(gbest(j,:) - pop(j,:)) + c2*rand*(zbest - pop(j,:));
        V(j,find(V(j,:)>Vmax))=Vmax;
        V(j,find(V(j,:)<Vmin))=Vmin;
        
        %种群更新
        pop(j,:)=pop(j,:)+V(j,:);
        pop(j,find(pop(j,:)>popmax))=popmax;
        pop(j,find(pop(j,:)<popmin))=popmin;
        
        %新粒子适应度值
        fitness(j)=fun(pop(j,:)); 
   
    end
    
    for j=1:sizepop
        
        %个体最优更新
        if fitness(j) > fitnessgbest(j)
            gbest(j,:) = pop(j,:);
            fitnessgbest(j) = fitness(j);
        end
        
        %群体最优更新
        if fitness(j) > fitnesszbest
            zbest = pop(j,:);
            fitnesszbest = fitness(j);
        end
    end 
    yy(i)=fitnesszbest;    %每代最优质记录下来
        
end
%% 结果分析
plot(yy)
title('最优个体适应度','fontsize',12);
xlabel('进化代数','fontsize',12);ylabel('适应度','fontsize',12);

