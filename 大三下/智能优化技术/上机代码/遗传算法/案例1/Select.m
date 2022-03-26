function ret=Select(individuals,sizepop)
% ��������ÿһ����Ⱥ�е�Ⱦɫ�����ѡ���Խ��к���Ľ���ͱ���
% individuals input  : ��Ⱥ��Ϣ
% sizepop     input  : ��Ⱥ��ģ
% opts        input  : ѡ�񷽷���ѡ��
% ret         output : ����ѡ������Ⱥ

individuals.fitness= 1./(individuals.fitness);  %�������Ӧ��ֵ��ȡ��������Ϊ������������Сֵ
sumfitness=sum(individuals.fitness);    %��Ӧ��ֵ�ܺ�
sumf=individuals.fitness./sumfitness;   %���̶ĸ��屻ѡ�еĸ���ֵ
index=[];   %ѡ��ĸ�������
for i=1:sizepop   %תsizepop������
    pick=rand;  %���ѡ��
    while pick==0
        pick=rand;  %���������0
    end
    for j=1:sizepop
        pick=pick-sumf(j);
        if pick<0
            index=[index j];
            break;  %Ѱ����������䣬�˴�ת����ѡ����Ⱦɫ��i��ע�⣺��תsizepop�����̵Ĺ����У��п��ܻ��ظ�ѡ��ĳЩȾɫ��
        end
    end
end
individuals.chrom=individuals.chrom(index,:);   %��Ⱥ����
individuals.fitness=individuals.fitness(index); %��Ӧ��ֵ����
ret=individuals;    %����ѡ��ĸ���