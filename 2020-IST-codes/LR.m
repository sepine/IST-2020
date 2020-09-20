function [predictlabel,Performance] = LR(sourcedata,sourcelabel,targetdata,targetlabel)

model = train(sourcelabel, sparse(real(sourcedata)),'-s 0 -c 1 -B -1 -q'); % num * fec
[predictlabel,~, prob_estimates] = predict(targetlabel, sparse(real(targetdata)), model,'-b 1');

% nb = NaiveBayes.fit(sourcedata, sourcelabel,'Distribution','kernel');
% [prob_estimates,predictlabel] = posterior(nb, targetdata);

if (predictlabel(1) == 0) && (prob_estimates(1,1)< prob_estimates(1,2))
    score = prob_estimates(:,1);
elseif (predictlabel(1) == 0) && (prob_estimates(1,1)> prob_estimates(1,2))
    score = prob_estimates(:,2);
elseif (predictlabel(1) == 1) && (prob_estimates(1,1)< prob_estimates(1,2))
    score = prob_estimates(:,2);
elseif (predictlabel(1) == 1) && (prob_estimates(1,1)> prob_estimates(1,2))
    score = prob_estimates(:,1);
end
% score = prob_estimates(:,2);
logitFit = score;

predictlabel_zhuanzhi = predictlabel';
targetlabel_zhuanzhi = targetlabel';

TN1 = 0;
FP1 = 0;
FN1 = 0;
TP1 = 0;
for i = 1:size(targetlabel_zhuanzhi,2)
    if (targetlabel_zhuanzhi(i)== 0 && predictlabel_zhuanzhi(i) == 0)
	    TN1 = TN1 + 1;
	elseif (targetlabel_zhuanzhi(i) == 0 && predictlabel_zhuanzhi(i) == 1)
        FP1 = FP1 + 1;
	elseif (targetlabel_zhuanzhi(i) == 1 && predictlabel_zhuanzhi(i) == 0)
        FN1 = FN1 + 1;
    else
        TP1 = TP1 + 1;
    end
end

%求基本指标
Accuracy1 = (TN1 + TP1) / (TN1 + FP1 + FN1 + TP1);
Recall1 = TP1 / (TP1 + FN1);
Pd1 = Recall1;
Precision1 = TP1 / (TP1 + FP1);
False_Positive1 = FP1 / (FP1 + TN1);
Pf1 = False_Positive1;
F_measure1 = 2 * Precision1 * Recall1 / (Precision1 + Recall1);
% F_2 = 5 * Precision * Recall / (4 * Precision + Recall);
G_measure1 = 2 * Recall1 * (1 - False_Positive1) / (Recall1 + (1 - False_Positive1));
g_mean1 = sqrt((TN1 / (TN1 + FP1)) * (TP1 / (TP1 + FN1)));
Bal1 = 1- sqrt((0-Pf1)^2+(1-Pd1)^2)/sqrt(2);
MCC1 = (TP1 * TN1 - FN1 * FP1) / sqrt((TP1 + FN1) * (TP1 + FP1) * (FN1 + TN1) * (FP1 + TN1));
[~,~,~,AUC1] = perfcurve(targetlabel,logitFit,1);

Performance1 = [Accuracy1, Precision1, Recall1, F_measure1, G_measure1, g_mean1, Bal1, MCC1, AUC1];

TN2 = 0;
FP2 = 0;
FN2 = 0;
TP2 = 0;
for i = 1:size(targetlabel_zhuanzhi,2)
    if (targetlabel_zhuanzhi(i)== 1 && predictlabel_zhuanzhi(i) == 1)
	    TN2 = TN2 + 1;
	elseif (targetlabel_zhuanzhi(i) == 1 && predictlabel_zhuanzhi(i) == 0)
        FP2 = FP2 + 1;
	elseif (targetlabel_zhuanzhi(i) == 0 && predictlabel_zhuanzhi(i) == 1)
        FN2 = FN2 + 1;
    else
        TP2 = TP2 + 1;
    end
end


%求基本指标
Accuracy2 = (TN2 + TP2) / (TN2 + FP2 + FN2 + TP2);
Recall2 = TP2 / (TP2 + FN2);
Pd2 = Recall2;
Precision2 = TP2 / (TP2 + FP2);
False_Positive2 = FP2 / (FP2 + TN2);
Pf2 = False_Positive2;
F_measure2 = 2 * Precision2 * Recall2 / (Precision2 + Recall2);
% F_2 = 5 * Precision * Recall / (4 * Precision + Recall);
G_measure2 = 2 * Recall2 * (1 - False_Positive2) / (Recall2 + (1 - False_Positive2));
g_mean2 = sqrt((TN2 / (TN2 + FP2)) * (TP2 / (TP2 + FN2)));
Bal2 = 1- sqrt((0-Pf2)^2+(1-Pd2)^2)/sqrt(2);
MCC2 = (TP2 * TN2 - FN2 * FP2) / sqrt((TP2 + FN2) * (TP2 + FP2) * (FN2 + TN2) * (FP2 + TN2));
Performance2 = [Accuracy2, Precision2, Recall2, F_measure2, G_measure2, g_mean2, Bal2, MCC2];

Performance = [Performance1, Performance2];