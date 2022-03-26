function ret=Select(individuals,sizepop)
% 本函数对每一代种群中的染色体进行选择，以进行后面的交叉和变异
% individuals input  : 种群信息
% sizepop     input  : 种群规模
% opts        input  : 选择方法的选择
% ret         output : 经过选择后的种群

individuals.fitness= 1./(individuals.fitness);  %个体的适应度值，取倒数，因为本案例是求最小值
sumfitness=sum(individuals.fitness);    %适应度值总和
sumf=individuals.fitness./sumfitness;   %轮盘赌个体被选中的概率值
index=[];   %选择的个体索引
for i=1:sizepop   %转sizepop次轮盘
    pick=rand;  %随机选择
    while pick==0
        pick=rand;  %避免随机到0
    end
    for j=1:sizepop
        pick=pick-sumf(j);
        if pick<0
            index=[index j];
            break;  %寻找落入的区间，此次转轮盘选中了染色体i，注意：在转sizepop次轮盘的过程中，有可能会重复选择某些染色体
        end
    end
end
individuals.chrom=individuals.chrom(index,:);   %种群更新
individuals.fitness=individuals.fitness(index); %适应度值更新
ret=individuals;    %返回选择的个体