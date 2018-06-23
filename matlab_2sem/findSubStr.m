function Result = findSubStr (str1, str2)
	Result = 0;
	for i = [1:length(str1)]
		flag = 1;
		for j = [1:length(str2)]
			if (i+j-1 > length(str1) || str1(i+j-1) ~= str2(j))
				flag = 0;
				break;
			end
		end
		if flag
			Result++;
		end
	end
end