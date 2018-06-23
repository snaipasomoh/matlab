function D = nn52 (n)
   summ = 0;
   sqSumm = 0;
   len = 0;
   for i = n
       summ += i;
       sqSumm += i^2;
       len++;
   end
   D = sqrt(sqSumm/len-(summ/len)^2);
end