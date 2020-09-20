function auc = AUC(scores,targetlabel) %score决策值,targetlabel 真实类标签
% x = xlsread('xalan-2.6.xlsx');
% data = x(:,1:size(x,2)-1);
% label = x(:,size(x,2));
% 
% traindata = data(1:600,:);
% trainlabel = label(1:600,:);
% 
% testdata = data(601:800,:);
% targetlabel = label(601:800,:);
% 
% Factor = NaiveBayes.fit(traindata, trainlabel,'Distribution','normal');
% [Scores,Predictlabel] = posterior(Factor, testdata);
% scores = Scores(:,2);

%第一种计算方法
% pos_num = sum(targetlabel==1);
% neg_num = sum(targetlabel==0);
% 
% m=size(targetlabel,1);
% [pre,Index]=sort(scores);
% targetlabel=targetlabel(Index);
% x=zeros(m+1,1);
% y=zeros(m+1,1);
% auc=0;
% x(1)=1;y(1)=1;
% 
% 
% for i=2:m
% TP=sum(targetlabel(i:m)==1);FP=sum(targetlabel(i:m)==0);
% x(i)=FP/neg_num;
% y(i)=TP/pos_num;
% auc=auc+(y(i)+y(i-1))*(x(i-1)-x(i))/2;
% end;
% auc;
% 
% x(m+1)=0;y(m+1)=0;
% auc=auc+y(m)*x(m)/2
% plot(x,y);

%第二种计算方法
%[A,I]=sort(scores);
% M=0;N=0;
% for i=1:length(scores)
%     if(targetlabel(i)==1)
%         M=M+1;
%     else
%         N=N+1;
%     end
% end
% sigma=0;
% for i=M+N:-1:1
%     if(targetlabel(I(i))==1)
%         sigma=sigma+i;
%     end
% end
% auc=(sigma-(M+1)*M/2)/(M*N)

%第三种计算方法
% [val,ind] = sort(scores,'descend');
% roc_y = targetlabel(ind);
% stack_x = cumsum(roc_y == 0)/sum(roc_y == 0);
% stack_y = cumsum(roc_y == 1)/sum(roc_y == 1);
% auc = sum((stack_x(2:length(roc_y),1)-stack_x(1:length(roc_y)-1,1)).*stack_y(2:length(roc_y),1))

%第四种计算方法
[X,Y,T,auc] =perfcurve(targetlabel,scores,'1');
auc;